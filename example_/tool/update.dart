library polymer_elements_examples.tool.update;

import 'dart:async' show Future, Stream;
import 'dart:convert' show JsonEncoder;
import 'dart:io' as io;
import 'package:crypto/crypto.dart' show CryptoUtils;
import 'package:github/server.dart'
    show
        Authentication,
        GitHub,
        RepositoriesService,
        Repository,
        RepositoryContents,
        RepositorySlug,
        initGitHub;
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'package:quiver/core.dart' show hash2;

main() async {
  final UpdateStatus updateStatus = new UpdateStatus('updatestatus.yaml')
    ..load();

  String gitHubToken = _readGitHubToken('.github_token');
  final gitHub = new StatusComparer(updateStatus, gitHubToken);
  await gitHub.compare();
  await gitHub.downloadAdded();
  await updateStatus.persist();
}

String _readGitHubToken(String gitHubTokenFilePath) {
  final gitHubTokenFile = new io.File(gitHubTokenFilePath);

  if (!gitHubTokenFile.existsSync()) {
    print(
        'File ".github_token" not found. Without a token the script might not '
        'be able to download the necessary data from GitHub because of an API '
        'rate limit.');
    return null;
  } else {
    String gitHubToken = gitHubTokenFile.readAsStringSync();
    if (gitHubToken.contains('\n')) {
      gitHubToken = gitHubToken.split('\n').first.trim();
    }
    return gitHubToken;
  }
}

class StatusComparer {
  GitHub gitHubClient;
  final String gitHubToken;
  final UpdateStatus updateStatus;
  final List<GitHubOrganizationComparer> organizations =
      <GitHubOrganizationComparer>[];

  StatusComparer(this.updateStatus, this.gitHubToken) {
    initGitHub();
    gitHubClient = new GitHub(
        auth: gitHubToken != null
            ? new Authentication.withToken(gitHubToken)
            : new Authentication.anonymous());
    organizations.addAll(updateStatus.organizations.map((orgStatus) =>
        new GitHubOrganizationComparer(orgStatus, gitHubClient)));
  }

  Future compare() async {
    List<Future> tasks = <Future>[];
    for (final org in organizations) {
      tasks.add(org.compare());
    }
    await Future.wait(tasks);
  }

  Future downloadAdded() async {
    List<Future> tasks = <Future>[];
    for (final org in organizations) {
      tasks.add(org.downloadAdded());
    }
    await Future.wait(tasks);
  }
}

class GitHubOrganizationComparer {
//  final String organizationName;
  final OrganizationStatus updateStatus;
  final GitHub gitHubClient;
  GitHubOrganizationComparer(this.updateStatus, this.gitHubClient) {}

  Stream<Repository> _loadRepositories() {
    return new RepositoriesService(gitHubClient)
        .listOrganizationRepositories(updateStatus.name);
  }

  Future<RepositoryContents> _loadDemoFiles(Repository repository) async {
    return new RepositoriesService(gitHubClient)
        .getContents(repository.slug(), 'demo');
  }

  Future compare() async {
    final repoService = new RepositoriesService(gitHubClient);
    final subscription = _loadRepositories().listen((repository) async {
      final slug = new RepositorySlug(updateStatus.name, repository.name);
      var foundRepoStatus = updateStatus.repositories
          .where((repoStatus) => repoStatus.name == repository.name);
      RepositoryStatus repositoryStatus;
      if (foundRepoStatus.isNotEmpty) {
        repositoryStatus = foundRepoStatus.first
          ..change = RepositoryChange.none;
      } else {
        repositoryStatus =
            new RepositoryStatus(updateStatus.name, repository.name)
              ..change = RepositoryChange.added;
        updateStatus.repositories.add(repositoryStatus);
      }

      final contents = await _loadDemoFiles(repository);
      if (contents.tree != null) {
        for (var item in contents.tree) {
          if (item.type == 'file') {
            var foundFiles =
                repositoryStatus.files.where((file) => file.path == item.path);
            FileStatus file;
            if (foundFiles.isNotEmpty) {
              file = foundFiles.first;
              if (file.sha == item.sha) {
                file.change = FileChange.none;
              } else {
                final newCommit = await repoService.getCommit(slug, item.sha);
                final oldCommit = await repoService.getCommit(slug, file.sha);
                // TODO(zoechi) compare isn't yet implemented in the github package
                file
                  ..oldSha = file.sha
                  ..sha = item.sha
                  ..change = FileChange.modified
                  ..compareView =
                      '${repository.htmlUrl}/compare/master...${file.oldSha}';
              }
            } else {
              file = new FileStatus(repository.name, item.path)
                ..sha = item.sha
                ..change = FileChange.added;
              repositoryStatus.files.add(file);
            }
          }
        }
      }
      repositoryStatus.files
          .where((file) => file.change == FileChange.unknown)
          .forEach((file) => file.change = FileChange.deleted);
    });

    await subscription.asFuture();
    updateStatus.repositories
        .where((repoStatus) => repoStatus.change == RepositoryChange.unknown)
        .forEach((repoStatus) => repoStatus.change = RepositoryChange.deleted);
  }

  String dartifyPath(String path) => path.toLowerCase().replaceAll('-', '_');

  Future downloadAdded() async {
    List<Future> tasks = <Future>[];
    updateStatus.repositories.forEach((repo) {
      repo.files
          .where((file) => file.change == FileChange.added ||
              file.change == FileChange.modified)
          .forEach((file) async {
        final contentsFuture = new RepositoriesService(gitHubClient)
            .getContents(
                new RepositorySlug(updateStatus.name, repo.name), file.path);
        tasks.add(contentsFuture);
        final contents = await contentsFuture;
        String filePath = dartifyPath(path.join(
            'web', repo.name, path.relative(contents.file.path, from: 'demo')));
        final fileContent =
            CryptoUtils.base64StringToBytes(contents.file.content);
        if (file.change == FileChange.added) {
          if (contents.file.name.toLowerCase() == 'index.html') {
            _generateDartFiles(
                path.dirname(filePath), new String.fromCharCodes(fileContent));
          }
          filePath = path.join(
              path.dirname(filePath), '__new__', path.basename(filePath));
        } else {
          filePath = path.join(
              path.dirname(filePath), '__updated__', path.basename(filePath));
        }
        final destination = new io.File(filePath);
        destination.createSync(recursive: true);
        destination.writeAsBytesSync(fileContent);
//        file.change = FileChange.none;
      });
    });
    await Future.wait(tasks);
  }

  final RegExp _bodyRegExp =
      new RegExp(r'(?:<body.*?>)((.|\s|\n)*?)(?:</body>)');
  final RegExp _styleRegExp =
      new RegExp(r'(?:<style.*?>)((.|\s|\n)*?)(?:</style>)');
  final RegExp _importRegExp = new RegExp(r'(?:<link.*?import.*?>)');
  final RegExp _importHrefRegExp =
      new RegExp(r'''(?:href=['"])(.*?\.html)(?:['"])''');

  String removeHtmlExtension(String fileName) => fileName.replaceAllMapped(
      new RegExp(r'(.*)(?:\.html$)'), (match) => match.group(1));

  void _generateDartFiles(String exampleDirectory, String indexHtmlContent) {
    String bodyContent = '';
    var match = _bodyRegExp.firstMatch(indexHtmlContent);
    if (match != null && match.groupCount == 2) bodyContent = match.group(1);

    final importsMatch = _importRegExp.allMatches(indexHtmlContent);
    final elementsImports = <String>[];
    final localImports = <String>[];
    importsMatch.forEach((match) {
      final hrefMatch = _importHrefRegExp.firstMatch(match.group(0));
      if (hrefMatch != null) {
        final url = hrefMatch.group(1);
        final parts = path.split(url);
        if (parts[0] == '..') {
          elementsImports.add(removeHtmlExtension(parts.last));
        } else {
          localImports.add(removeHtmlExtension(url));
        }
      }
    });

    localImports.forEach((import) {
      // TODO(zoechi) find element file and copy body
      final tagName = import;
      final fileName = tagName.replaceAll('-', '_');

      final elementHtmlFile =
          new io.File(path.join(exampleDirectory, '${fileName}.html'));
      elementHtmlFile.createSync(recursive: true);
      elementHtmlFile
          .writeAsStringSync(_elementHtmlContent('', '', tagName: tagName));

      final elementDartFile =
          new io.File(path.join(exampleDirectory, '${fileName}.dart'));
      elementDartFile.createSync(recursive: true);
      elementDartFile.writeAsStringSync(
          _elementDartContent(tagName: tagName, fileName: fileName));
    });

    String styleContent = '';
    match = _styleRegExp.firstMatch(indexHtmlContent);
    if (match != null && match.groupCount == 2) styleContent = match.group(1);

    final indexHtmlFile =
        new io.File(path.join(exampleDirectory, 'index.html'));
    indexHtmlFile.createSync(recursive: true);
    indexHtmlFile.writeAsStringSync(_indexHtmlContent('', ''));

    final indexDartFile =
        new io.File(path.join(exampleDirectory, 'index.dart'));
    indexDartFile.createSync(recursive: true);
    indexDartFile.writeAsStringSync(_indexDartContent());

    final appElementHtmlFile =
        new io.File(path.join(exampleDirectory, 'app_element.html'));
    appElementHtmlFile.createSync(recursive: true);
    appElementHtmlFile
        .writeAsStringSync(_elementHtmlContent(bodyContent, styleContent));

    final appElementDartFile =
        new io.File(path.join(exampleDirectory, 'app_element.dart'));
    appElementDartFile.createSync(recursive: true);
    appElementDartFile.writeAsStringSync(_elementDartContent(
        elementsImports: elementsImports, localImports: localImports));
  }

  String _tagNameToClassName(String tagName) =>
      '${tagName[0].toUpperCase()}${tagName.substring(1).replaceAllMapped(new RegExp('(?:-)(.?)'), (match) => match.group(1).toUpperCase())}';

  String _tagNameToFileName(String tagName) => tagName.replaceAll('-', '_');

  String _elementDartContent(
      {String tagName: 'app-element',
      String fileName: 'app_element',
      List<String> elementsImports,
      List<String> localImports}) {
    String className = _tagNameToClassName(tagName);
    List<String> imports = <String>[];
    String silenceClasses = '';
    if (elementsImports != null) {
      for (final import in elementsImports) {
        imports.add(
            "import 'package:polymer_elements/${_tagNameToFileName(import)}.dart';");
        silenceClasses += ' [${_tagNameToClassName(import)}],';
      }
    }
    if (localImports != null) {
      for (final import in localImports) {
        imports.add("import '${_tagNameToFileName(import)}.dart';");
        silenceClasses += ' [${_tagNameToClassName(import)}],';
      }
    }
    return '''
@HtmlImport('${fileName}.html')
library ${fileName};

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
${imports.join('\n')}
// import 'package:polymer_elements/dummy.dart';

/// Silence analyzer${silenceClasses}
@PolymerRegister('${tagName}')
class ${className} extends PolymerElement {
  ${className}.created() : super.created();
}
''';
  }

  String _elementHtmlContent(String body, String style,
      {String tagName: 'app-element'}) {
    return '''
<dom-module id="${tagName}">
  <template>
    <style>
      :host {
        display: block;
      }
${style}
    </style>
${body}
  </template>
</dom-module>
''';
  }

  String _indexDartContent() {
    return '''
import 'package:polymer/polymer.dart';
import 'app_element.dart';

/// Silence analyzer [AppElement]
main() async {
  await initPolymer();
}
''';
  }

  String _indexHtmlContent(String body, String style) {
    body ??= '';

    var styleTag = style == null || style.isEmpty
        ? ''
        : '''
  <style is="custom-style">${style}
        </style>''';

    return '''
  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
      <script src="packages/web_components/webcomponents-lite.min.js"></script>
      <script src="packages/browser/dart.js"></script>
      ${styleTag}
    </head>
    <body unresolved>
      <app-element></app-element>
      ${body}
      <script type="application/dart" src="index.dart"></script>
    </body>
  </html>
''';
  }
}

class UpdateStatus {
  final String statusFilePath;
  io.File _statusFile;
  final List<OrganizationStatus> organizations = <OrganizationStatus>[];

  UpdateStatus(this.statusFilePath);

  void load() {
    _statusFile = new io.File(statusFilePath);
    if (_statusFile.existsSync()) {
      final yaml = loadYaml(_statusFile.readAsStringSync());
      final List organizationsYaml = yaml['organizations'];
      if (organizationsYaml != null) {
        organizations.addAll(organizationsYaml
//            .where((repo) => repo['skip'] != true)
            .map((repo) => new OrganizationStatus.fromYaml(repo)));
      }
    } else {
      print('info: update status file "$statusFilePath" doesn\'t exist.');
    }
  }

  void persist() {
    final result = {
      'organizations': organizations.map((repo) => repo.toJson()).toList(),
      'transformers': generateTransformerEntryPoints()
    };
    final json = const JsonEncoder.withIndent('  ').convert(result);
    _statusFile.writeAsStringSync(json, mode: io.FileMode.WRITE_ONLY);
  }

  Map generateTransformerEntryPoints() {
    List<String> webComponentsEntryPoints = <String>[];
    List<String> reflectableEntryPoints = <String>[];
    for (final org in organizations) {
      for (final repo in org.repositories) {
        webComponentsEntryPoints.add('web/${repo.name}/index.html');
        reflectableEntryPoints.add('web/${repo.name}/index.dart');
      }
    }
    return {
      'web_components': webComponentsEntryPoints,
      'reflectable': reflectableEntryPoints
    };
  }
}

class OrganizationStatus {
  final String name;
  final List<RepositoryStatus> repositories;
  OrganizationStatus(this.name, {List<RepositoryStatus> repositories})
      : repositories = repositories ?? <RepositoryStatus>[];

  factory OrganizationStatus.fromYaml(Map yaml) {
    final organization = yaml['organization'];
    List<RepositoryStatus> repositories = <RepositoryStatus>[];
    List repositoriesYaml = yaml['repositories'];
    if (repositoriesYaml != null) {
      repositories.addAll(repositoriesYaml
          .map((repo) => new RepositoryStatus(organization, repo)));
    }
    return new OrganizationStatus(organization, repositories: repositories);
  }

  operator ==(other) => other is OrganizationStatus && other.name == name;

  @override
  int get hashCode => name.hashCode;

  Map toJson() {
    final result = {
      'organization': name,
      'repositories': repositories.map((file) => file.toJson()).toList(),
    };
    return result;
  }
}

class RepositoryStatus {
  final String organization;
  final String name;
  final List<FileStatus> files;
  final bool skip;
  final String skipReason;
  RepositoryChange change = RepositoryChange.unknown;

  factory RepositoryStatus.fromYaml(String organization, Map yaml) {
    final repository = yaml['repository'];
    List<FileStatus> files = <FileStatus>[];
    List filesYaml = yaml['files'];
    if (filesYaml != null) {
      files.addAll(
          filesYaml.map((file) => new FileStatus.fromYaml(repository, file)));
    }
    return new RepositoryStatus(organization, repository,
        files: files,
        skip: yaml['skip'] ?? false,
        skipReason: yaml['skip_reason']);
  }

  RepositoryStatus(this.organization, this.name,
      {List<FileStatus> files, bool skip, this.skipReason})
      : files = files ?? <FileStatus>[],
        skip = skip ?? false;

  operator ==(other) => other is RepositoryStatus &&
      other.organization == organization &&
      other.name == name;

  @override
  int get hashCode => hash2(organization.hashCode, name.hashCode);

  Map toJson() {
    final result = {
      'repository': name,
      'files': files.map((file) => file.toJson()).toList(),
      'skip': skip
    };
    if (skipReason != null) result['skip_reason'] = skipReason;
    if (change != RepositoryChange.none.toString()) result['change'] =
        change.toString();
    return result;
  }
}

enum RepositoryChange { unknown, none, added, deleted }

class FileStatus {
  final String repository;
  final String path;
  String sha;
  String oldSha;
  FileChange change = FileChange.unknown;
  String compareView;

  FileStatus(this.repository, this.path);

  factory FileStatus.fromYaml(String repository, Map yaml) {
    return new FileStatus(repository, yaml['file'])..sha = yaml['sha'];
  }

  operator ==(other) => other is FileStatus &&
      other.repository == repository &&
      other.path == path;

  @override
  int get hashCode => hash2(repository.hashCode, path.hashCode);

  Map toJson() {
    final result = {'file': path, 'sha': sha};
    if (oldSha != null) result['old_sha'] = oldSha;
    if (change != FileChange.none.toString()) result['change'] =
        change.toString();
    if (compareView != null) result['compare_view'] = compareView;
    return result;
  }
}

enum FileChange { unknown, none, modified, added, deleted }
