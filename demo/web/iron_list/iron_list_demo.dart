/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_list_demo.html')
library polymer_elements_demo.web.iron_list.iron_list_demo;

import 'dart:html' as dom;
import 'dart:math' as math;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [Polymer], [IronFlexLayout], [PaperToolbar], [PaperScrollHeaderPanel], [PaperIconButton], [IronAjax], [IronIcons], [IronList], [DemoElements],
@PolymerRegister('iron-list-demo')
class IronListDemo extends PolymerElement with PolymerBase {
  IronListDemo.created() : super.created();

  @property var data;

  @reflectable
  String iconForItem(Map item) =>
      item != null ? (item['integer'] < 50 ? 'star-border' : 'star') : '';

  @Listen('paper-header-transform')
  void headerTransformHandler(dom.CustomEvent event, [_]) {
    dom.Element title = this.querySelector('.title');
    Map detail = event.detail;
    var deltaHeight = detail['height'] - detail['condensedHeight'];
    var scale =
        math.max(0.6, (deltaHeight - detail['y']) / (deltaHeight / 0.4) + 0.6);

    transform('scale(${scale}) translateZ(0)', title);
  }
}
