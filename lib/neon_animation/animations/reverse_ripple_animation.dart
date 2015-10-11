// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `reverse_ripple_animation`.
@HtmlImport('reverse_ripple_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.reverse_ripple_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_shared_element_animation_behavior.dart';
import '../../neon_animation_behavior.dart';

/// `<reverse-ripple-animation>` scales and transform an element such that it appears to ripple down from this element, to either
/// a shared element, or a screen position.
///
/// If using as a shared element animation in `<neon-animated-pages>`, use this animation in an `exit`
/// animation in the source page and in an `entry` animation in the destination page. Also, define the
/// reverse-ripple elements in the `sharedElements` property (not a configuration property, see
/// `Polymer.NeonSharedElementAnimatableBehavior`).
/// If using a screen position, define the `gesture` property.
/// Configuration:
/// ```
/// {
///   name: 'reverse-ripple-animation`.
///   id: <shared-element-id>, /* set this or gesture */
///   gesture: {x: <page-x>, y: <page-y>}, /* set this or id */
///   timing: <animation-timing>,
///   toPage: <node>, /* define for the destination page */
///   fromPage: <node>, /* define for the source page */
/// }
/// ```
@CustomElementProxy('reverse-ripple-animation')
class ReverseRippleAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior, NeonSharedElementAnimationBehavior {
  ReverseRippleAnimation.created() : super.created();
  factory ReverseRippleAnimation() => new Element.tag('reverse-ripple-animation');

  complete() =>
      jsElement.callMethod('complete', []);

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
