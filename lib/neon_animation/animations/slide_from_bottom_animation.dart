// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_from_bottom_animation`.
@HtmlImport('slide_from_bottom_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_from_bottom_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-from-bottom-animation>` animates the transform of an element from `none` to `translateY(100%)`.
/// The `transformOrigin` defaults to `50% 0`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-from-bottom-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-from-bottom-animation')
class SlideFromBottomAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideFromBottomAnimation.created() : super.created();
  factory SlideFromBottomAnimation() => new Element.tag('slide-from-bottom-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
