/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_list_selection_demo.html')
library polymer_elements_demo.web.iron_list.iron_list_selection_demo;

import 'dart:html' as dom;
import 'dart:js' as js;
import 'dart:math' as math;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/paper_toolbar.dart';
//import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_badge.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [Polymer], [IronFlexLayout], [PaperToolbar], [PaperIconButton], [IronIcon], [IronAjax], [IronIcons], [IronList], [PaperMenu], [PaperItem], [PaperBadge], [DemoElements],
@PolymerRegister('iron-list-selection-demo')
class IronListSelectionDemo extends PolymerElement with PolymerBase {
  IronListSelectionDemo.created() : super.created();

  @property List data;

  @property List selectedItems = [];
  @Property(observer: 'showSelectionChanged') bool showSelection = true;

  @reflectable
  String iconForItem(bool isSelected) => isSelected ? 'star-border' : 'star';

  @reflectable
  String computedClass(bool isSelected) {
    var classes = 'item';
    if (isSelected) {
      classes += ' selected';
    }
    return classes;
  }

  @reflectable
  void unselect(dom.CustomEvent event, [_]) {
    dom.Element element = event.target;
    while (element != null && !element.attributes.keys.contains('item-index')) {
      element = element.parent;
    }
    if (element != null) {
      int index = int.parse(element.attributes['item-index']);
      removeAt('selectedItems', index);
    }
  }

  @reflectable
  void toggleStarredView([_, __]) {
    set('showSelection', !this.showSelection);
  }

  @reflectable
  void showSelectionChanged([_, __]) {
    $['selectedItemsList'].fire('resize');
  }

  @reflectable
  String getAriaLabel(Map item, bool selected) =>
      selected ? 'Deselect ' + item['name'] : 'Select ${item['name']}';
}
