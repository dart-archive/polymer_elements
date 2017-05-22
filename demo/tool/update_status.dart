/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('update_status.html')
library polymer_elements_demo.web.update_status;

import 'dart:html' as dom;
import 'dart:async' show Future;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/paper_tooltip.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/paper_styles.dart';

/// Silence analyzer [UpdateStatus], [IronAjax], [PaperIconButton], [PaperItem],
/// [PaperDrawerPanel], [PaperHeaderPanel], [PaperMenu], [IronList],
/// [PaperToolbar], [PaperTooltip],
@PolymerRegister('update-status')
class UpdateStatus extends PolymerElement {
  UpdateStatus.created() : super.created();

  @property Map data;

  @Property(
      computed: 'getOrganizations(data)', observer: 'organizationsChanged')
  List<String> organizations;

  @property String selectedOrganization;

  @Property(
      computed: 'getRepositories(data, selectedOrganization, repositoryFilter)',
      observer: 'repositoriesChanged')
  List<Map> repositories;

  @property Object selectedRepository;

  @Property(
      computed:
          'getRepositoryData(data, selectedOrganization, selectedRepository)')
  Map repositoryData;

  @property Map selectedFile;

  @property String repositoryFilter = 'any-changes';

  @reflectable
  void organizationsChanged(newValue, oldValue) {
    final IronList list = $['organizations'];
    if (newValue == null || newValue.isEmpty) {
      list.clearSelection();
    } else {
      list.selectItem(newValue.first);
    }
  }

  @reflectable
  bool isRepositorySelected() => selectedOrganization != null;

  @reflectable
  void repositoriesChanged(newValue, oldValue) {
    new Future(() {
      final IronList list = $$('#repositories');
      if (newValue == null || newValue.isEmpty) {
        list.clearSelection();
      } else {
        list.selectItem(newValue.first);
      }
    });
  }

  @reflectable
  List<String> getOrganizations(Map data) {
    if (data == null) {
      return [];
    }
    return data['organizations'].map((org) => org['organization']).toList();
  }

  @reflectable
  List<Map> getRepositories(
      Map data, String organization, String repositoryFilter) {
    if (data == null || organization == null) {
      return [];
    }
    Iterable repositories = data['organizations'].firstWhere(
        (org) => org['organization'] == organization)['repositories'];
    if (repositoryFilter != null &&
        repositoryFilter.isNotEmpty &&
        repositoryFilter != 'all' &&
        repositoryFilter != 'any-changes') {
      repositories = repositories.where(
          (repo) => repo['change'] == 'RepositoryChange.${repositoryFilter}');
    } else if (repositoryFilter == 'any-changes') {
      repositories = repositories.where((repo) =>
          repo['change'] != 'RepositoryChange.none' ||
              (repo['files'] as List)
                  .where((file) => file['change'] != 'FileChange.none')
                  .isNotEmpty);
    }
    return repositories.map((repo) => convertToJs(repo)).toList();
  }

  @reflectable
  Object getRepositoryData(Map data, String organization, Object repository) {
    return convertToJs(_getRepositoryData(data, organization, repository));
  }

  Map _getRepositoryData(Map data, String organization, Object repository) {
    if (data == null || organization == null || repository == null) {
      return {};
    }
    return data['organizations']
            .firstWhere((org) => org['organization'] == organization)[
        'repositories'].firstWhere(
        (repo) => repo['repository'] == (repository as Map)['repository']);
  }

  @reflectable
  String fileChangeIcon(String change) {
    switch (change) {
      case 'FileChange.none':
        return '';
      case 'FileChange.modified':
        return 'icons:change-history';
      case 'FileChange.added':
        return 'icons:add-circle';
      case 'FileChange.deleted':
        return 'icons:remove-circle';
      default:
        return 'icons:autorenew';
    }
  }

  @reflectable
  String repositoryChangeIcon(String change) {
    switch (change) {
      case 'RepositoryChange.none':
        return '';
      case 'RepositoryChange.added':
        return 'icons:add-circle';
      case 'RepositoryChange.deleted':
        return 'icons:remove-circle';
      default:
        return 'icons:autorenew';
    }
  }

  @reflectable
  void organizationClickHandler(dom.Event event, [_]) {}

  @reflectable
  void repositoryClickHandler(dom.Event event, [_]) {}

  @reflectable
  void fileClickHandler(dom.Event event, [_]) {}
}
