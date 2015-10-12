/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_list_external_content_demo.html')
library polymer_elements_demo.web.iron_list.iron_list_external_content_demo;

import 'dart:html' as dom;
import 'dart:math' as math;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_spinner.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [Polymer], [IronFlexLayout], [PaperToolbar], [PaperScrollHeaderPanel], [PaperSpinner], [PaperIconButton], [IronAjax], [IronIcons], [IronList], [DemoElements],
@PolymerRegister('iron-list-external-content-demo')
class IronListExternalContentDemo extends PolymerElement with PolymerBase {
  IronListExternalContentDemo.created() : super.created();

  // TODO(zoechi) paper-spinner doesn't show
  @property bool loading = false;
  @property List people;

  @reflectable
  String iconForItem(var item) => item != null ? (item['integer'] < 50 ? 'star-border' : 'star') : '';

  // Custom transformation: scale header's title
  @Listen('paper-header-transform')
  headerTransformHandler(dom.CustomEvent event, [_]) {
    var title = querySelector('.title');
    var middleContainer = querySelector('.middle-container');
    var bottomContainer = querySelector('.bottom-container');
    var detail = event.detail;
    var heightDiff = detail['height'] - detail['condensedHeight'];
    var yRatio = math.min(1, detail['y'] / heightDiff);
    var maxMiddleScale = 0.50;  // title max size when condensed. The smaller the number the smaller the condensed size.
    var scaleMiddle = math.max(maxMiddleScale, (heightDiff - detail['y']) / (heightDiff / (1-maxMiddleScale))  + maxMiddleScale);
    var scaleBottom = 1 - yRatio;

    // Move/translate middleContainer
    transform('translate3d(0,${yRatio * 100}%,0)', middleContainer);

    // Scale bottomContainer and bottom title to 0 and back
    transform('scale(${scaleBottom}) translateZ(0)', bottomContainer);

    // Scale middle Title
    transform('scale(${scaleMiddle}) translateZ(0)', title);
  }

  // Refresh Data
  @reflectable
  void refreshData([_, __]) {
    $['get_filltext_ajax'].generateRequest();
  }
}
