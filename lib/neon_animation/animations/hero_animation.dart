// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `hero_animation`.
@HtmlImport('hero_animation_nodart.html')
library polymer_elements.lib.src.neon_animation.animations.hero_animation;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../neon_shared_element_animation_behavior.dart';
import '../../neon_animation_behavior.dart';

/// `<hero-animation>` is a shared element animation that scales and transform an element such that it
/// appears to be shared between two pages. Use this in `<neon-animated-pages>`. The source page
/// should use this animation in an 'exit' animation and set the `fromPage` configuration property to
/// itself, and the destination page should use this animation in an `entry` animation and set the
/// `toPage` configuration property to itself. They should also define the hero elements in the
/// `sharedElements` property (not a configuration property, see
/// `Polymer.NeonSharedElementAnimatableBehavior`).
///
/// Configuration:
/// ```
/// {
///   name: 'hero-animation',
///   id: <shared-element-id>,
///   timing: <animation-timing>,
///   toPage: <node>, /* define for the destination page */
///   fromPage: <node>, /* define for the source page */
/// }
/// ```
@CustomElementProxy('hero-animation')
class HeroAnimation extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimationBehavior, NeonSharedElementAnimationBehavior {
  HeroAnimation.created() : super.created();
  factory HeroAnimation() => new Element.tag('hero-animation');

  complete([config]) => //(config) =>
      jsElement.callMethod('complete', [config]);

  configure(config) =>
      jsElement.callMethod('configure', [config]);
}
