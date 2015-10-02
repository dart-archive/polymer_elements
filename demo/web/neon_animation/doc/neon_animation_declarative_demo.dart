/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('neon_animation_declarative_demo.html')
library polymer_elements_demo.web.neon_animation.card.neon_animation_declarative_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:polymer_elements/neon_animated_pages.dart';
import 'package:polymer_elements/neon_animation.dart';

/// Silence analyzer [DemoElements], [NeonAnimatedPages]
@PolymerRegister('neon-animation-declarative-demo')
class NeonAnimationDeclarativeDemo extends PolymerElement {
  NeonAnimationDeclarativeDemo.created() : super.created();

  @property int selected = 0;

  @eventHandler
  void onPrevClick ([_, __]) {
    entryAnimation = 'slide-from-left-animation';
    exitAnimation = 'slide-right-animation';
    set('selected', selected == 0 ? 4 : (this.selected - 1));
  }

  @eventHandler
  void onNextClick([_, __]) {
    entryAnimation = 'slide-from-right-animation';
    exitAnimation = 'slide-left-animation';
    set('selected', selected == 4 ? 0 : (this.selected + 1));
  }
}
