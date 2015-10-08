// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `fade_in_animation`.
@HtmlImport('fade_in_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.fade_in_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<fade-in-animation>` animates the opacity of an element from 0 to 1.
///
/// Configuration:
/// ```
/// {
///   name: 'fade-in-animation',
///   node: <node>
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('fade-in-animation')
class FadeInAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  FadeInAnimation.created() : super.created();
  factory FadeInAnimation() => new Element.tag('fade-in-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
