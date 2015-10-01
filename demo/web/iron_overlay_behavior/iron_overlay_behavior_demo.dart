/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_overlay_behavior_demo.html')
library polymer_elements_demo.web.iron_overlay_behavior.iron_overlay_behavior_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'simple_overlay.dart';

/// Silence analyzer [IronFlexLayout], [PaperStyles], [DemoElements], [SimpleOverlay],
@PolymerRegister('iron-overlay-behavior-demo')
class IronOverlayBehaviorDemo extends PolymerElement {
  IronOverlayBehaviorDemo.created() : super.created();

  @eventHandler
  void clickHandler(dom.Event event, [_]) {
    if (!(event.target as dom.Element).attributes.containsKey('data-dialog')) {
      return;
    }

    var id = (event.target as dom.Element).attributes['data-dialog'];
    SimpleOverlay dialog = $[id];
    if (dialog != null) {
      dialog.open();
    }
  }
}
