// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_down_animation`.
@HtmlImport('slide_down_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_down_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-down-animation>` animates the transform of an element from `none` `translateY(100%)`.
/// The `transformOrigin` defaults to `50% 0`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-down-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-down-animation')
class SlideDownAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideDownAnimation.created() : super.created();
  factory SlideDownAnimation() => new Element.tag('slide-down-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
