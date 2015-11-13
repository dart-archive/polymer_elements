// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `neon_animatable`.
@HtmlImport('neon_animatable_nodart.html')
library polymer_elements.lib.src.neon_animation.neon_animatable;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'neon_animatable_behavior.dart';
import 'iron_resizable_behavior.dart';

/// `<neon-animatable>` is a simple container element implementing `Polymer.NeonAnimatableBehavior`. This is a convenience element for use with `<neon-animated-pages>`.
///
/// ```
/// <neon-animated-pages selected="0"
///                      entry-animation="slide-from-right-animation"
///                      exit-animation="slide-left-animation">
///   <neon-animatable>1</neon-animatable>
///   <neon-animatable>2</neon-animatable>
/// </neon-animated-pages>
/// ```
@CustomElementProxy('neon-animatable')
class NeonAnimatable extends HtmlElement with CustomElementProxyMixin, PolymerBase, NeonAnimatableBehavior, IronResizableBehavior {
  NeonAnimatable.created() : super.created();
  factory NeonAnimatable() => new Element.tag('neon-animatable');
}
