// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `scale_down_animation`.
@HtmlImport('scale_down_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.scale_down_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<scale-down-animation>` animates the scale transform of an element from 1 to 0. By default it
/// scales in both the x and y axes.
///
/// Configuration:
/// ```
/// {
///   name: 'scale-down-animation',
///   node: <node>,
///   axis: 'x' | 'y' | '',
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('scale-down-animation')
class ScaleDownAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  ScaleDownAnimation.created() : super.created();
  factory ScaleDownAnimation() => new Element.tag('scale-down-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
