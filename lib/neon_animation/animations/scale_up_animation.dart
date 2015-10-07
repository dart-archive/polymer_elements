// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `scale_up_animation`.
@HtmlImport('scale_up_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.scale_up_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<scale-up-animation>` animates the scale transform of an element from 0 to 1. By default it
/// scales in both the x and y axes.
///
/// Configuration:
/// ```
/// {
///   name: 'scale-up-animation',
///   node: <node>,
///   axis: 'x' | 'y' | '',
///   transformOrigin: <transform-origin>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('scale-up-animation')
class ScaleUpAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  ScaleUpAnimation.created() : super.created();
  factory ScaleUpAnimation() => new Element.tag('scale-up-animation');

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
