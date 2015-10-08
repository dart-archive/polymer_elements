// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `ripple_animation`.
@HtmlImport('ripple_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.ripple_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_shared_element_animation_behavior.dart';
import '../../neon_animation_behavior.dart';

/// `<ripple-animation>` scales and transform an element such that it appears to ripple from either
/// a shared element, or from a screen position, to full screen.
///
/// If using as a shared element animation in `<neon-animated-pages>`, use this animation in an `exit`
/// animation in the source page and in an `entry` animation in the destination page. Also, define the
/// hero elements in the `sharedElements` property (not a configuration property, see
/// `Polymer.NeonSharedElementAnimatableBehavior`).
///
/// If using a screen position, define the `gesture` property.
///
/// Configuration:
/// ```
/// {
///   name: 'ripple-animation`.
///   id: <shared-element-id>, /* set this or gesture */
///   gesture: {x: <page-x>, y: <page-y>}, /* set this or id */
///   timing: <animation-timing>,
///   toPage: <node>, /* define for the destination page */
///   fromPage: <node>, /* define for the source page */
/// }
/// ```
@CustomElementProxy('ripple-animation')
class RippleAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior, NeonSharedElementAnimationBehavior {
  RippleAnimation.created() : super.created();
  factory RippleAnimation() => new Element.tag('ripple-animation');

  complete() =>
      jsElement.callMethod('complete', []);

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
