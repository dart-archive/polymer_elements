/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_card_demo.html')
library polymer_elements_demo.web.paper_card.paper_card_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_card.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/color.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperCard], [PaperButton], [PaperIconButton], [IronIcons], [IronFlexLayout], [Color], [DemoElements],
@PolymerRegister('paper-card-demo')
class PaperCardDemo extends PolymerElement {
  PaperCardDemo.created() : super.created();

  @eventHandler
  void decreaseShadow([_, __]) {
    PaperCard card = $['shadow_demo'];
    card.elevation = card.elevation > 0 ? card.elevation - 1 : 0;
  }

  @eventHandler
  void increaseShadow([_, __]) {
    PaperCard card = $['shadow_demo'];
    card.elevation = card.elevation < 5 ? card.elevation + 1 : 5;
  }
}
