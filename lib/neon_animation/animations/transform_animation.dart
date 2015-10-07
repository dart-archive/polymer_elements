// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `transform_animation`.
@HtmlImport('transform_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.transform_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<transform-animation>` animates a custom transform on an element. Use this to animate multiple
/// transform properties, or to apply a custom transform value.
///
/// Configuration:
/// ```
/// {
///   name: 'transform-animation',
///   node: <node>,
///   transformOrigin: <transform-origin>,
///   transformFrom: <transform-from-string>,
///   transformTo: <transform-to-string>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('transform-animation')
class TransformAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  TransformAnimation.created() : super.created();
  factory TransformAnimation() => new Element.tag('transform-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
