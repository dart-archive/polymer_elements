// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_right_animation`.
@HtmlImport('slide_right_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_right_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-right-animation>` animates the transform of an element from `none` to `translateX(100%)`.
/// The `transformOrigin` defaults to `0 50%`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-right-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-right-animation')
class SlideRightAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideRightAnimation.created() : super.created();
  factory SlideRightAnimation() => new Element.tag('slide-right-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
