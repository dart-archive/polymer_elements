// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `fade_out_animation`.
@HtmlImport('fade_out_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.fade_out_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<fade-out-animation>` animates the opacity of an element from 1 to 0.
///
/// Configuration:
/// ```
/// {
///   name: 'fade-out-animation',
///   node: <node>
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('fade-out-animation')
class FadeOutAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  FadeOutAnimation.created() : super.created();
  factory FadeOutAnimation() => new Element.tag('fade-out-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
