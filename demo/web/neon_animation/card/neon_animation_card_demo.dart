/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('neon_animation_card_demo.html')
library polymer_elements_demo.web.neon_animation.card.neon_animation_card_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:polymer_elements/neon_animated_pages.dart';
import 'package:polymer_elements/neon_animation.dart';
import 'x_card.dart';
import 'x_cards_list.dart';

/// Silence analyzer [DemoElements], [XCard], [XCardsList], [NeonAnimatedPages]
@PolymerRegister('neon-animation-card-demo')
class NeonAnimationCardDemo extends PolymerElement {
  NeonAnimationCardDemo.created() : super.created();

  @eventHandler
  void onPolymerClick(dom.Event event, [_]) {
    ($['list'] as XCardsList).sharedElements = {
      'ripple': event.target,
      'reverse-ripple': event.target
    };
    ($['pages'] as NeonAnimatedPages).selected = 1;
  }

  @eventHandler
  void onAngularClick(dom.Event event, [_]) {
    ($['list'] as XCardsList).sharedElements = {
      'ripple': event.target,
      'reverse-ripple': event.target
    };
    ($['pages'] as NeonAnimatedPages).selected = 2;
  }

  @eventHandler
  onBackClick(dom.Event event, [_]) {
    ($['pages'] as NeonAnimatedPages).selected = 0;
  }
}
