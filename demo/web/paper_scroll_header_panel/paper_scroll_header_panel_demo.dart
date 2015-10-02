/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_scroll_header_panel_demo.html')
library polymer_elements_demo.web.paper_scroll_header_panel.paper_scroll_header_panel_demo;

import 'dart:math' as math;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_scroll_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'sample_content.dart';

/// Silence analyzer [PaperScrollHeaderPanel], [PaperToolbar], [IronIcons], [PaperIconButton], [DemoElements], [SampleContent],
@PolymerRegister('paper-scroll-header-panel-demo')
class PaperScrollHeaderPanelDemo extends PolymerElement {
  PaperScrollHeaderPanelDemo.created() : super.created();

  @Listen('paper-header-transform')
  void headerTransform(_,  detail) {
    var m = detail['height'] - detail['condensedHeight'];
    var scale = math.max(0.75, (m - detail['y']) / (m / 0.25)  + 0.75);

    transform('scale(${scale}) translateZ(0)', $['title']);
  }
}
