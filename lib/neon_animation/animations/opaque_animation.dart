// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `opaque_animation`.
@HtmlImport('opaque_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.opaque_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<opaque-animation>` makes an element `opacity:1` for the duration of the animation. Used to prevent
/// webkit/safari from drawing a frame before an animation for elements that animate from display:none.
@CustomElementProxy('opaque-animation')
class OpaqueAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  OpaqueAnimation.created() : super.created();
  factory OpaqueAnimation() => new Element.tag('opaque-animation');

  complete([config]) => //(config) =>
      jsElement.callMethod('complete', [config]);

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
