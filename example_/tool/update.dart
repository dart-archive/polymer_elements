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

  final gitHub = new StatusComparer('PolymerElements', updateStatus);
  await gitHub.compare();
  await gitHub.downloadAdded();
  await updateStatus.persist();
}

class StatusComparer {
  GitHub gitHubClient;
  final String organizationName;
  final UpdateStatus updateStatus;
  StatusComparer(this.organizationName, this.updateStatus) {
    initGitHub();
    gitHubClient = new GitHub(
        auth: new Authentication.withToken(
            'a8dc97e3043c7e1743d7eab6c40afa7c3b460ff0'));
  }

  Stream<Repository> _loadRepositories() {
    return new RepositoriesService(gitHubClient)
        .listOrganizationRepositories(organizationName);
  }

  Future<RepositoryContents> _loadDemoFiles(Repository repository) async {
    return new RepositoriesService(gitHubClient)
        .getContents(repository.slug(), 'demo');
  }

  Future compare() async {
    final repoService = new RepositoriesService(gitHubClient);
    final subscription = _loadRepositories().listen((repository) async {
      final slug = new RepositorySlug(organizationName, repository.name);
      var foundRepoStatus = updateStatus.repositories
          .where((repoStatus) => repoStatus.name == repository.name);
      RepositoryStatus repositoryStatus;
      if (foundRepoStatus.isNotEmpty) {
        repositoryStatus = foundRepoStatus.first
          ..change = RepositoryChange.none;
      } else {
        repositoryStatus = new RepositoryStatus(repository.name)
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
                  ..newSha = item.sha
                  ..change = FileChange.modified
                  ..compareView =
                      '${repository.htmlUrl}/compare/master...${file.sha}';
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
                new RepositorySlug(organizationName, repo.name), file.path);
        tasks.add(contentsFuture);
        final contents = await contentsFuture;
        String filePath = dartifyPath(path.join(
            'web', repo.name, path.relative(contents.file.path, from: 'demo')));
        final fileContent = CryptoUtils.base64StringToBytes(contents.file.content);
        if (file.change == FileChange.added) {
          if(contents.file.name.toLowerCase() == 'index.html') {
            _generateDartFiles(path.dirname(filePath), new String.fromCharCodes(fileContent));
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

  final RegExp _bodyRegExp = new RegExp(r'(?:<body.*?>)((.|\s|\n)*?)(?:</body>)');
  final RegExp _styleRegExp = new RegExp(r'(?:<style.*?>)((.|\s|\n)*?)(?:</style>)');
  void _generateDartFiles(String exampleDirectory, String indexHtmlContent) {
    String bodyContent = '';
    var match = _bodyRegExp.firstMatch(indexHtmlContent);
    if(match != null && match.groupCount == 2) bodyContent = match.group(1);

    String styleContent = '';
    match = _styleRegExp.firstMatch(indexHtmlContent);
    if(match != null && match.groupCount == 2) styleContent = match.group(1);

    final indexHtmlFile = new io.File(path.join(exampleDirectory, 'index.html'));
    indexHtmlFile.createSync(recursive: true);
    indexHtmlFile.writeAsStringSync(_indexHtmlContent(bodyContent, styleContent));

    final indexDartFile =new io.File(path.join(exampleDirectory, 'index.dart'));
    indexDartFile.createSync(recursive: true);
    indexDartFile.writeAsStringSync(_indexDartContent());

    final appElementHtmlFile =new io.File(path.join(exampleDirectory, 'app_element.html'));
    appElementHtmlFile.createSync(recursive: true);
    appElementHtmlFile.writeAsStringSync(_appElementHtmlContent());

    final appElementDartFile =new io.File(path.join(exampleDirectory, 'app_element.dart'));
    appElementDartFile.createSync(recursive: true);
    appElementDartFile.writeAsStringSync(_appElementDartContent());
  }

  String _appElementDartContent() {
    return '''
@HtmlImport('app_element.html')
library app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/dummy.dart';

@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();
}
''';
  }

  String _appElementHtmlContent() {
return '''
<dom-module id="app-element">
  <template>
    <style>
      :host {
        display: block;
      }
    </style>
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
    </body>
  </html>
''';
  }
}

class UpdateStatus {
  final String statusFilePath;
  io.File _statusFile;
  final List<RepositoryStatus> repositories = <RepositoryStatus>[];

  UpdateStatus(this.statusFilePath);

  void load() {
    _statusFile = new io.File(statusFilePath);
    if (_statusFile.existsSync()) {
      final yaml = loadYaml(_statusFile.readAsStringSync());
      repositories.addAll(yaml['repositories']
          .where((repo) => repo['skip'] != true)
          .map((repo) => new RepositoryStatus.fromYaml(repo)));
    } else {
      print('info: update status file "$statusFilePath" doesn\'t exist.');
    }
  }

  void persist() {
    final result = {
      'repositories': repositories.map((repo) => repo.toJson()).toList()
    };
    final json = const JsonEncoder.withIndent('  ').convert(result);
    _statusFile.writeAsStringSync(json, mode: io.FileMode.WRITE_ONLY);
  }
}

class RepositoryStatus {
  final String name;
  final List<FileStatus> files;
  final bool skip;
  final String skipReason;
  RepositoryChange change = RepositoryChange.unknown;

  factory RepositoryStatus.fromYaml(Map yaml) {
    final repository = yaml['repository'];
    List<FileStatus> files = <FileStatus>[];
    List filesYaml = yaml['files'];
    if (filesYaml != null) {
      files.addAll(
          filesYaml.map((file) => new FileStatus.fromYaml(repository, file)));
    }
    return new RepositoryStatus(repository,
        files: files,
        skip: yaml['skip'] ?? false,
        skipReason: yaml['skip_reason']);
  }

  RepositoryStatus(this.name,
      {List<FileStatus> files, bool skip, this.skipReason})
      : files = files ?? <FileStatus>[],
        skip = skip ?? false;

  operator ==(other) => other is RepositoryStatus && other.name == name;

  @override
  int get hashCode => name.hashCode;

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
  String newSha;
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
    if (newSha != null) result['new_sha'] = newSha;
    if (change != FileChange.none.toString()) result['change'] =
        change.toString();
    if (compareView != null) result['compare_view'] = compareView;
    return result;
  }
}

enum FileChange { unknown, none, modified, added, deleted }
