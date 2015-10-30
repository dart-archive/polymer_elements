// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `neon_animated_pages`.
@HtmlImport('neon_animated_pages_nodart.html')
library polymer_elements.lib.src.neon_animation.neon_animated_pages;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'iron_selectable.dart';
import 'neon_animation_runner_behavior.dart';
import 'neon_animatable_behavior.dart';
import 'neon_animation/animations/opaque_animation.dart';

/// Material design: [Meaningful transitions](https://www.google.com/design/spec/animation/meaningful-transitions.html)
///
/// `neon-animated-pages` manages a set of pages and runs an animation when switching between them. Its
/// children pages should implement `Polymer.NeonAnimatableBehavior` and define `entry` and `exit`
/// animations to be run when switching to or switching out of the page.
@CustomElementProxy('neon-animated-pages')
class NeonAnimatedPages extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior, IronSelectableBehavior, NeonAnimatableBehavior, NeonAnimationRunnerBehavior {
  NeonAnimatedPages.created() : super.created();
  factory NeonAnimatedPages() => new Element.tag('neon-animated-pages');

  String get activateEvent => jsElement[r'activateEvent'];
  set activateEvent(String value) { jsElement[r'activateEvent'] = value; }

  /// if true, the initial page selection will also be animated according to its animation config.
  bool get animateInitialSelection => jsElement[r'animateInitialSelection'];
  set animateInitialSelection(bool value) { jsElement[r'animateInitialSelection'] = value; }
}
