// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `cascaded_animation`.
@HtmlImport('cascaded_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.cascaded_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_animation_behavior.dart';

/// `<cascaded-animation>` applies an animation on an array of elements with a delay between each.
/// the delay defaults to 50ms.
///
/// Configuration:
/// ```
/// {
///   name: 'cascaded-animation',
///   animation: <animation-name>,
///   nodes: <array-of-nodes>,
///   nodeDelay: <node-delay-in-ms>,
///   timing: <animation-timing>
/// }
/// ```
@CustomElementProxy('cascaded-animation')
class CascadedAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior {
  CascadedAnimation.created() : super.created();
  factory CascadedAnimation() => new Element.tag('cascaded-animation');

  complete() =>
      jsElement.callMethod('complete', []);

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
