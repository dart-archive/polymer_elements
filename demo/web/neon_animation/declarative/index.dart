/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
import 'dart:html' as dom;
import 'package:polymer/polymer.dart';
import 'neon_animation_declarative_demo.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/demo_pages.dart';
import 'package:polymer_elements/neon_animated_pages.dart';
import 'package:polymer_elements/neon_animatable.dart';
import 'package:polymer_elements/neon_animation/animations/slide_from_left_animation.dart';
import 'package:polymer_elements/neon_animation/animations/slide_from_right_animation.dart';
import 'package:polymer_elements/neon_animation/animations/slide_right_animation.dart';
import 'package:polymer_elements/neon_animation/animations/slide_left_animation.dart';

var scope;

/// Silence analyzer [NeonAnimationDeclarativeDemo]
main() async {
  await initPolymer();

//  scope = dom.document.querySelector('template[is="dom-bind"]');
//  scope['selected'] = 0;
//
//  scope['onPrevClick'] = onPrevClick;
//  scope['onNextClick'] = onNextClick;
}

//@reflectable
//void onPrevClick([_, __]) {
//  scope['entryAnimation'] = 'slide-from-left-animation';
//  scope['this.exitAnimation'] = 'slide-right-animation';
//  scope['selected'] = scope['selected'] == 0 ? 4 : (scope['selected'] - 1);
//}
//
//@reflectable
//void onNextClick([_, __]) {
//  scope['entryAnimation'] = 'slide-from-right-animation';
//  scope['exitAnimation'] = 'slide-left-animation';
//  scope['selected'] = scope['selected'] == 4 ? 0 : (scope['selected'] + 1);
//}
