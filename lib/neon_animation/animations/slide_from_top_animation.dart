// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_from_top_animation`.
@HtmlImport('slide_from_top_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_from_top_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-from-top-animation>` animates the transform of an element from `translateY(-100%)` to
/// `none`. The `transformOrigin` defaults to `50% 0`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-from-top-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-from-top-animation')
class SlideFromTopAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideFromTopAnimation.created() : super.created();
  factory SlideFromTopAnimation() => new Element.tag('slide-from-top-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
