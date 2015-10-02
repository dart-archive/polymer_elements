/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_icon_button_demo.html')
library polymer_elements_demo.web.paper_icon_button.paper_icon_button_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/color.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronIcons], [Color], [PaperIconButton], [DemoElements],
@PolymerRegister('paper-icon-button-demo')
class PaperIconButtonDemo extends PolymerElement {
  PaperIconButtonDemo.created() : super.created();

  @eventHandler
  void clickHandler(dom.Event event, [_]) {
    var button =
        ((Polymer.dom(event) as PolymerEvent).localTarget as PaperIconButton);
    if (button.attributes.containsKey('disabled')) {
      dom.window.console
          .error('should not be able to click disabled button');
    } else {
      print('click');
    }
    dom.window.console.debug(button);
  }
}
