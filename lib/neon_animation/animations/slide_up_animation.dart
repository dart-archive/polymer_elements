// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_up_animation`.
@HtmlImport('slide_up_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_up_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-up-animation>` animates the transform of an element from `translateY(0)` to
/// `translateY(-100%)`. The `transformOrigin` defaults to `50% 0`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-up-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-up-animation')
class SlideUpAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideUpAnimation.created() : super.created();
  factory SlideUpAnimation() => new Element.tag('slide-up-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
