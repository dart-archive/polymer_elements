// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_from_left_animation`.
@HtmlImport('slide_from_left_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_from_left_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-from-left-animation>` animates the transform of an element from
/// `translateX(-100%)` to `none`.
/// The `transformOrigin` defaults to `0 50%`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-from-left-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-from-left-animation')
class SlideFromLeftAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideFromLeftAnimation.created() : super.created();
  factory SlideFromLeftAnimation() => new Element.tag('slide-from-left-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
