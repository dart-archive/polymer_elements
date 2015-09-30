/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('expand_animation.html')
library polymer_elements_demo.web.web.iron_dropdown.expand_animation;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/neon_animatable_behavior.dart';

/// Silence analyzer
@PolymerRegister('expand-animation')
class ExpandAnimation extends PolymerElement with NeonAnimatableBehavior{
  ExpandAnimation.created() : super.created();

  @eventHandler
  configure(config) {
//    var node = config.node;
//
//    var height = node.getBoundingClientRect().height;
//
//    this._effect = new KeyframeEffect(node, [{
//      height: (height / 2) + 'px'
//    }, {
//      height: height + 'px'
//    }], this.timingFromConfig(config));
//
//    return this._effect;
  }
}
