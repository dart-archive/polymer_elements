library polymer_elements_examples.tool.update;

import 'dart:async' show Completer, Future, Stream;
import 'dart:convert' show JsonEncoder, JSON;
import 'dart:io' as io;
import 'package:crypto/crypto.dart' show CryptoUtils;
import 'package:github/server.dart'
    show
        Authentication,
        GitHub,
        GitHubFile,
        RepositoriesService,
        Repository,
        RepositoryContents,
        RepositorySlug,
        initGitHub;
import 'package:path/path.dart' as path;
import 'package:quiver/core.dart' show hash2;

const webDirPath = 'web';

// TODO(zoechi) unicode characters in file content aren't written correctly (see for example paper_badge demo)

main() async {
  final UpdateStatus updateStatus = new UpdateStatus('tool/updatestatus.json')
    ..load();

  String gitHubToken = _readGitHubToken('tool/.github_token');
  final gitHub = new StatusComparer(updateStatus, gitHubToken);
  print('compare');
  await gitHub.compare();
  print('download');
  await gitHub.downloadAdded();
  print('persist');
  await updateStatus.persist();
}

/// Read the GitHub token used to authenticate the application on GitHub from
/// a file.
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

/// Compares previous [UpdateStatus] with current GitHub status.
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

  /// Updates [updateStatus] with information acquired from GitHub.
  Future compare() async {
    for (final org in organizations) {
      await org.compare();
    }
    organizations.sort((a, b) =>
        a.organizationStatus.name.compareTo(b.organizationStatus.name));
    organizations.forEach((o) => o.organizationStatus.sortRepositories());
  }

  /// Downloads files added according to the result of [compare].
  Future downloadAdded() async {
    List<Future> tasks = <Future>[];
    for (final org in organizations) {
      tasks.add(org.downloadAdded());
    }
    await Future.wait(tasks);
  }
}

/// Creates a file name `some_element_demo` from a tag name `some-element-demo`
String _tagNameToFileName(String tagName) => tagName.replaceAll('-', '_');

/// Creates a library name `web.some_element.some_element_demo` from a path
/// `web/some_element/some_element_demo`
String _pathToLibraryName(String path) => '${path.split('/').join('.')}.';

/// Creates a path like `web/some_element/some_file.ext` from a path like
/// `web/some-element/some-file.ext`
String _dartifyPath(String path) => path.toLowerCase().replaceAll('-', '_');

/// Creates a class name `SomeElementDemo` from a tag name
/// `some-element-demo`.
String _tagNameToClassName(String tagName) =>
    '${tagName[0].toUpperCase()}${tagName.substring(1).replaceAllMapped(new RegExp('(?:-)(.?)'), (match) => match.group(1).toUpperCase())}';

/// Uses OrganizationStatus and checks if the listed organizations have added,
/// changed or removed repositories.
class GitHubOrganizationComparer {
  final OrganizationStatus organizationStatus;
  final GitHub gitHubClient;

  GitHubOrganizationComparer(this.organizationStatus, this.gitHubClient) {}

  /// Fetch repositories from a GitHub organization.
  Stream<Repository> _loadRepositories() {
    return new RepositoriesService(gitHubClient)
        .listOrganizationRepositories(organizationStatus.name);
  }

  /// Fetch files information from a GitHub repositories `demo` subdirectory.
  Future<RepositoryContents> _loadDemoFiles(Repository repository,
      {String path: 'demo'}) async {
    final service = new RepositoriesService(gitHubClient);
    final contents = await service.getContents(repository.slug(), path);
    final files = <GitHubFile>[];
    if (contents.tree != null) {
      for (final file in contents.tree) {
        if (file.type == 'file') {
          files.add(file);
        } else if (file.type == 'dir') {
          files
              .addAll((await _loadDemoFiles(repository, path: file.path)).tree);
        } else {
          print('Unsupported file GitHub type "${file.type}".');
        }
      }
      contents.tree = files;
    }
    return contents;
  }

  /// Update [organizationStatus] using information acquired from GitHub and
  /// set whether repositories and files have been added, removed or updated.
  Future compare() async {
    final repoService = new RepositoriesService(gitHubClient);
    final repositories = await _loadRepositories().toList(); //.listen((repository) async {
    for(final repository in repositories) {
      final slug = new RepositorySlug(organizationStatus.name, repository.name);
      var oldRepositoryStatus = organizationStatus.repositories
          .where((repoStatus) => repoStatus.name == repository.name);
      RepositoryStatus newRepositoryStatus;
      if (oldRepositoryStatus.isNotEmpty) {
        // repository already know locally
        print('known repository: ${oldRepositoryStatus.first.name}');
        newRepositoryStatus = oldRepositoryStatus.first
          ..change = RepositoryChange.none;
      } else {
        // previously unknown repository
        newRepositoryStatus =
            new RepositoryStatus(organizationStatus.name, repository.name)
              ..change = RepositoryChange.added;
        organizationStatus.repositories.add(newRepositoryStatus);
        print('new repository: ${newRepositoryStatus.name}');
      }

      final contents = await _loadDemoFiles(repository);
      // for each file in the repository in demo/**
      if (contents.tree != null) {
        for (var item in contents.tree) {
          print('  ${repository.name} item: ${item.path}');
          if (item.type == 'file') {
            var oldFiles = newRepositoryStatus.files
                .where((file) => file.path == item.path);
            FileStatus newFile;
            final newCommit = await repoService.getCommit(slug, 'master');
            if (oldFiles.isNotEmpty) {
              // file already known locally
              newFile = oldFiles.first;
              // file unchanged
              if (newFile.sha == item.sha) {
                print('    known unchanged');
                newFile.change = FileChange.none;
                // update file which was added before commitSha was supported
                if (newFile.commitSha == null) {
                  newFile.commitSha = newCommit.sha;
                }
                // update files which were added before compareView was supported
                if (newFile.compareView == null) {
                  newFile.compareView = item.htmlUrl;
                }
              } else {
                // file modified
                print('    known modified');
                newFile
                  ..oldSha = newFile.sha
                  ..sha = item.sha
                  ..oldCommitSha = newFile.commitSha
                  ..commitSha = newCommit.sha
                  ..change = FileChange.modified
                  ..compareView = newFile.oldCommitSha == null
                      ? item.htmlUrl
                      : '${repository.htmlUrl}/compare/${newFile.oldCommitSha}...master';
              }
            } else {
              // new file
              newFile = new FileStatus(repository.name, item.path)
                ..sha = item.sha
                ..commitSha = newCommit.sha
                ..change = FileChange.added
                ..compareView = item.htmlUrl;
              newRepositoryStatus.files.add(newFile);
              print('    new file: ${newFile.path}');
            }
          }
        }
      }
      // all files where `file.change` still is `FileChange.unknown` were
      // deleted remotely
      newRepositoryStatus.files
          .where((file) => file.change == FileChange.unknown)
          .forEach((file) {
        file.change = FileChange.deleted;
        print('deleted file: ${file.path}');
      });
    }

    organizationStatus.repositories
        .where((repoStatus) => repoStatus.change == RepositoryChange.unknown)
        .forEach((repoStatus) => repoStatus.change = RepositoryChange.deleted);
  }

  /// Download additional files found since the last check.
  Future downloadAdded() async {
    for (final repo in organizationStatus.repositories) {
      for (final file in repo.files.where((file) =>
          file.change == FileChange.added ||
              file.change == FileChange.modified)) {
        final contents = await new RepositoriesService(gitHubClient)
            .getContents(new RepositorySlug(organizationStatus.name, repo.name),
                file.path);
        String filePath = _dartifyPath(path.join(webDirPath, repo.name,
            path.relative(contents.file.path, from: 'demo')));
        final fileContent =
            CryptoUtils.base64StringToBytes(contents.file.content);
        if (file.change == FileChange.added) {
          // Only content of the `demo/index.html` file is processed by
          // extracting parts and creating new files from the parts. All other
          // files are just copied (to the `__new__` or `__updated__`
          // subdirectory.
          if (contents.file.name.toLowerCase() == 'index.html') {
            _generateDartFiles(
                '${repo.name}-demo',
                path.join(webDirPath, _tagNameToFileName(repo.name)),
                new String.fromCharCodes(fileContent));
          }
          filePath = path.join(
              path.dirname(filePath), '__new__', path.basename(filePath));
        } else {
          filePath = path.join(
              path.dirname(filePath), '__updated__', path.basename(filePath));
        }
        final destination = new io.File(filePath);
        if (!destination.existsSync()) {
          destination.createSync(recursive: true);
          destination.writeAsBytesSync(fileContent);
          print('${destination} created.');
        }
      }
    }
  }

  /// Extract the content of the `<body ...>content</body>` tag.
  final RegExp _bodyRegExp =
      new RegExp(r'(?:<body.*?>)((.|\s|\n)*?)(?:</body>)');

  /// Extract the content of the `<style ...>content</style>` tag.
  final RegExp _styleRegExp =
      new RegExp(r'(?:<style.*?>)((.|\s|\n)*?)(?:</style>)');

  /// Find `<link rel="import">...` tags.
  final RegExp _importRegExp = new RegExp(r'(?:<link.*?import.*?>)');

  /// Extract the href url from an `<link rel="import" href="...">` tag.
  final RegExp _importHrefRegExp =
      new RegExp(r'''(?:href=['"])(.*?\.html)(?:['"])''');

  /// Extract the base name without extension from a file name.
  final _htmlFileNameBaseRegExp = new RegExp(r'(.*)(?:\.html$)');

  /// Return the base name like `some_file` from a file name like
  /// `some_file.html`.
  String removeHtmlExtension(String fileName) => fileName.replaceAllMapped(
      _htmlFileNameBaseRegExp, (match) => match.group(1));

  /// Extract the element imports from the passed [indexHtmlContent] and return
  /// it as 2 lists of import tags where the first list contains the tags
  /// of **polymer_elements** tags and the second list contains the tags
  /// referring to local elements which are part of the elements demo code.
  List<List<String>> _getHtmlImports(String indexHtmlContent) {
    final elementsImports = <String>[];
    final localImports = <String>[];
    final importsMatch = _importRegExp.allMatches(indexHtmlContent);
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
    return [elementsImports, localImports];
  }

  _writeFile(io.File file, String content) {
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
    }
  }

  /// Generates the boilerplate (`index.html`, `index.dart`,
  /// `some_element_demo.dart`, `some_element_demo.html`) from the
  /// `demo/index.html` file found in the GitHub repository as starting point
  /// for the Dart port. It also creates additional polymer element stubs for
  /// local element imports found in `index.html`.
  /// Contents of other files than `index.html` found in the GitHub repo is
  /// ignored. These additional files are just copied as is to the `__new__`
  /// or `__updated__` subdirectory.
  void _generateDartFiles(
      String tagName, String exampleDirectory, String indexHtmlContent) {
    String bodyContent = '';
    var match = _bodyRegExp.firstMatch(indexHtmlContent);
    if (match != null && match.groupCount == 2) bodyContent = match.group(1);

    final imports = _getHtmlImports(indexHtmlContent);
    final elementsImports = imports[0];
    final localImports = imports[1];

    // Create `some_helper_element.dart` and `some_helper_element.html` stubs.
    localImports.forEach((import) {
      // TODO(zoechi) find element file and copy body
      final tagName = import;
      final fileName = _tagNameToFileName(tagName);

      // `some_helper_element.html`
      final elementHtmlFile =
          new io.File(path.join(exampleDirectory, '${fileName}.html'));
      _writeFile(elementHtmlFile, _elementHtmlContent(tagName, '', ''));

      // `some_helper_element.dart`
      final elementDartFile =
          new io.File(path.join(exampleDirectory, '${fileName}.dart'));
      _writeFile(
          elementDartFile,
          _elementDartContent(tagName,
              library:
                  'polymer_elements_demo.web.${_pathToLibraryName(exampleDirectory)}'));
    });

    String styleContent = '';
    match = _styleRegExp.firstMatch(indexHtmlContent);
    if (match != null && match.groupCount == 2) styleContent = match.group(1);

    // Create `index.html`
    final indexHtmlFile =
        new io.File(path.join(exampleDirectory, 'index.html'));
    _writeFile(indexHtmlFile, _indexHtmlContent(tagName, '', ''));

    // Create `index.dart`
    final indexDartFile =
        new io.File(path.join(exampleDirectory, 'index.dart'));
    _writeFile(indexDartFile, _indexDartContent(tagName));

    // Create `some_element_demo.html`
    final appElementHtmlFile = new io.File(
        path.join(exampleDirectory, '${_tagNameToFileName(tagName)}.html'));
    _writeFile(
        appElementHtmlFile,
        _elementHtmlContent(tagName, bodyContent, styleContent,
            importDemoElements: true));

    // Create `some_element_demo.dart`
    final appElementDartFile = new io.File(
        path.join(exampleDirectory, '${_tagNameToFileName(tagName)}.dart'));
    _writeFile(
        appElementDartFile,
        _elementDartContent(tagName,
            library:
                'polymer_elements_demo.${_pathToLibraryName(exampleDirectory)}',
            elementsImports: elementsImports,
            localImports: localImports,
            importDemoElements: true));
  }

  /// Creates the Dart code for a Polymer element.
  /// [tagName] in the form `some-element-demo` is used to create the file name
  /// (`some_element_demo.ext`) and the class name (SomeElementDemo) of the
  /// element.
  /// If [elementsImports] are passed as list of tag names, import statements
  ///   for **polymer_element** elements are generated.
  /// If [localImports] are passed as list of tag names, import statements
  ///   for elements in `web/some_element_demo/*` are generated.
  /// [library] is the library name used for the elements Dart code. The
  ///   elements name is automatically added. The passed value therefore needs
  ///   to contain the leading `.`.
  String _elementDartContent(String tagName,
      {String library: '',
      List<String> elementsImports,
      List<String> localImports,
      bool importDemoElements: false}) {
    final fileName = _tagNameToFileName(tagName);
    String className = _tagNameToClassName(tagName);
    List<String> imports = <String>[];
    String silenceClasses = '';
    if (elementsImports != null) {
      for (final import in elementsImports) {
        // demo-pages gets replaced by statically added `demo-elements`
        if (import != 'demo-pages') {
          imports.add(
              "import 'package:polymer_elements/${_tagNameToFileName(import)}.dart';");
          silenceClasses += ' [${_tagNameToClassName(import)}],';
        }
      }
    }
    if (importDemoElements) {
      imports.add(
          "import 'package:polymer_elements_demo/styles/demo_elements.dart';");
      silenceClasses += ' [DemoElements],';
    }
    if (localImports != null) {
      for (final import in localImports) {
        imports.add("import '${_tagNameToFileName(import)}.dart';");
        silenceClasses += ' [${_tagNameToClassName(import)}],';
      }
    }
    return '''
${_dartLicense}
@HtmlImport('${fileName}.html')
library ${library}${fileName};

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
${imports.join('\n')}

/// Silence analyzer${silenceClasses}
@PolymerRegister('${tagName}')
class ${className} extends PolymerElement {
  ${className}.created() : super.created();
}
''';
  }

  /// Creates the HTML for a Polymer element.
  /// [style] is inserted as content into the `<template><style>` tag.
  /// [body] is inserted as content into the `<template>` tag.
  /// If the [importDemoElements] is `true` an import to the
  ///   `lib/style/demo_elements.dart` element is added.
  String _elementHtmlContent(String tagName, String body, String style,
      {bool importDemoElements: false}) {
    String styleTag = '';
    if (style != null && style.isNotEmpty) {
      styleTag = '''
    <style>
      $style
    </style>
''';
    }
    if (importDemoElements) {
      styleTag += '<style include="demo-elements"></style>';
    }

    return '''
${_htmlLicense}
<dom-module id="${tagName}">
  <template>
    ${styleTag}
  ${body}
  </template>
</dom-module>
''';
  }

  /// Creates the Dart code for a default `index.dart` file.
  /// [tagName] is the demo element like `some-element-demo`.
  String _indexDartContent(String tagName) {
    return '''
${_dartLicense}
import 'package:polymer/polymer.dart';
import '${_tagNameToFileName(tagName)}.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/demo_pages.dart';

/// Silence analyzer [${_tagNameToClassName(tagName)}]
main() async {
  await initPolymer();
}
''';
  }

  /// Creates the HTML for the `index.html` file.
  /// [tagName] is the demo element tag like `some-element-demo`
  /// [body] is inserted into the `<body>` tag.
  /// [style] is inserted into a `<style is="custom-style">` tag in `<head>`.
  String _indexHtmlContent(String tagName, String body, String style) {
    body ??= '';

    var styleTag = style == null || style.isEmpty
        ? ''
        : '''
  <style is="custom-style">${style}
        </style>''';

    return '''
<!DOCTYPE html>
${_htmlLicense}
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, initial-scale=1, user-scalable=yes">

    <title>$tagName</title>

    <script src="packages/web_components/webcomponents-lite.min.js"></script>
    ${styleTag}
  </head>
  <body unresolved>
    <${tagName}></${tagName}>
    ${body}
    <script type="application/dart" src="index.dart"></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
''';
  }
}

/// Manages the status of organizations, repositories and files.
/// Serializes and deserializes the `updatestatus.json` file to and from
///   model classes.
class UpdateStatus {
  final String statusFilePath;
  io.File _statusFile;
  final List<OrganizationStatus> organizations = <OrganizationStatus>[];

  /// [statusFilePath] is the path to the status file ('updatestatus.json')
  ///   to work with.
  UpdateStatus(this.statusFilePath);

  /// Loads the passed [statusFilePath] and creates model instances from the
  /// organizations, repositories and files listed in the file.
  void load() {
    _statusFile = new io.File(statusFilePath);
    if (_statusFile.existsSync()) {
      final json = JSON.decode(_statusFile.readAsStringSync());
      final List organizationsJson = json['organizations'];
      if (organizationsJson != null) {
        organizations.addAll(organizationsJson
            .map((repo) => new OrganizationStatus.fromJson(repo)));
      }
    } else {
      print('info: update status file "$statusFilePath" doesn\'t exist.');
    }
  }

  /// Write the current status to the [statusFilePath] file. All previous
  /// content will be overridden.
  /// Ensure [load] was called previously to include the previous content.
  void persist() {
    final result = {
      'organizations': organizations.map((repo) => repo.toJson()).toList(),
      'transformers': generateTransformerEntryPoints()
    };
    final json = const JsonEncoder.withIndent('  ').convert(result);
    _statusFile.writeAsStringSync(json, mode: io.FileMode.WRITE_ONLY);
  }

  /// Adds information to the model which results in "entry_points" sections
  /// in [statusFilePath] when persisted with [persist].
  Map generateTransformerEntryPoints() {
    List<String> webComponentsEntryPoints = <String>[];
    List<String> reflectableEntryPoints = <String>[];
    for (final org in organizations) {
      for (final repo in org.repositories) {
        final fileName = _tagNameToFileName(repo.name);
        webComponentsEntryPoints.add('web/${fileName}/index.html');
        reflectableEntryPoints.add('web/${fileName}/index.dart');
      }
    }
    return {
      'web_components': webComponentsEntryPoints,
      'reflectable': reflectableEntryPoints
    };
  }
}

/// Information about the current state and the state after the last update of
/// repositories in a GitHub organization.
class OrganizationStatus {
  /// The name of the organization.
  final String name;
  final List<RepositoryStatus> repositories;
  OrganizationStatus(this.name, {List<RepositoryStatus> repositories})
      : repositories = repositories ?? <RepositoryStatus>[];

  factory OrganizationStatus.fromJson(Map json) {
    final organization = json['organization'];
    List<RepositoryStatus> repositories = <RepositoryStatus>[];
    List repositoriesJson = json['repositories'];
    if (repositoriesJson != null) {
      repositories.addAll(repositoriesJson
          .map((repo) => new RepositoryStatus.fromJson(organization, repo)));
    }
    return new OrganizationStatus(organization, repositories: repositories);
  }

  operator ==(other) => other is OrganizationStatus && other.name == name;

  @override
  int get hashCode => name.hashCode;

  void sortRepositories() {
    repositories.sort((a, b) => a.name.compareTo(b.name));
  }

  Map toJson() {
    final result = {
      'organization': name,
      'repositories': repositories.map((file) => file.toJson()).toList(),
    };
    return result;
  }
}

/// Information about the current state and the state after the last update of
/// files found in a GitHub repositories `demo` subdirectory.
class RepositoryStatus {
  /// The organization this repository is a part of.
  final String organization;

  /// The name of the repository.
  final String name;

  /// The files found in the `demo` subdirectory of the GitHub repository.
  final List<FileStatus> files;

  /// If the `skip` property in the `updatestatus.json` file for a repository is
  /// set to true, this repository will be ignored when files are downloaded
  /// and local stubs are created.
  final bool skip;

  /// Comment on why [skip] was set to `true`.
  final String skipReason;

  /// The current change status.
  RepositoryChange change = RepositoryChange.unknown;

  factory RepositoryStatus.fromJson(String organization, Map json) {
    final repository = json['repository'];
    List<FileStatus> files = <FileStatus>[];
    List filesJson = json['files'];
    if (filesJson != null) {
      files.addAll(
          filesJson.map((file) => new FileStatus.fromJson(repository, file)));
    }
    return new RepositoryStatus(organization, repository,
        files: files,
        skip: json['skip'] ?? false,
        skipReason: json['skip_reason']);
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

/// Status code for the change status of a repository.
enum RepositoryChange {
  // not yet examined
  unknown,
  // nothing changed
  none,
  // repository wasn't found previously
  added,
  // previously found repository not found anymore
  deleted
}

/// Information about the current state and the state after the last update of
/// a file found in a GitHub repositories `demo` subdirectory.
class FileStatus {
  final String repository;
  final String path;
  String sha;
  String oldSha;
  String commitSha;
  String oldCommitSha;
  FileChange change = FileChange.unknown;
  String compareView;

  FileStatus(this.repository, this.path);

  factory FileStatus.fromJson(String repository, Map json) {
    return new FileStatus(repository, json['file'])
      ..sha = json['sha']
      ..commitSha = json['commit_sha'];
  }

  operator ==(other) => other is FileStatus &&
      other.repository == repository &&
      other.path == path;

  @override
  int get hashCode => hash2(repository.hashCode, path.hashCode);

  Map toJson() {
    final result = {'file': path, 'sha': sha, 'commit_sha': commitSha};
    if (oldSha != null) result['old_sha'] = oldSha;
    if (oldCommitSha != null) result['old_commit_sha'] = oldCommitSha;
    if (change != FileChange.none.toString()) result['change'] =
        change.toString();
    if (compareView != null) result['compare_view'] = compareView;
    return result;
  }
}

/// Status code for the change status of a file.
enum FileChange {
  // not yet examined
  unknown,
  // nothing changed
  none,
  // the files sha has changed since the last update
  modified,
  // the file wasn't found previously
  added,
  // previously found file not found anymore
  deleted
}

const _licenseText = '''
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt''';

const _htmlLicense = '''
<!--
${_licenseText}
-->''';

const _dartLicense = '''
/*
${_licenseText}
*/''';
