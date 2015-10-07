// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_from_right_animation`.
@HtmlImport('slide_from_right_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_from_right_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-from-right-animation>` animates the transform of an element from
/// `translateX(100%)` to `none`.
/// The `transformOrigin` defaults to `0 50%`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-from-right-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-from-right-animation')
class SlideFromRightAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideFromRightAnimation.created() : super.created();
  factory SlideFromRightAnimation() => new Element.tag('slide-from-right-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
