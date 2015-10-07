// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `slide_left_animation`.
@HtmlImport('slide_left_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.slide_left_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<slide-left-animation>` animates the transform of an element from `none` to `translateX(-100%)`.
/// The `transformOrigin` defaults to `0 50%`.
///
/// Configuration:
/// ```
/// {
///   name: 'slide-left-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('slide-left-animation')
class SlideLeftAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  SlideLeftAnimation.created() : super.created();
  factory SlideLeftAnimation() => new Element.tag('slide-left-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
