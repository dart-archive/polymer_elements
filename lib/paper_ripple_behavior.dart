// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_ripple_behavior`.
@HtmlImport('paper_ripple_behavior_nodart.html')
library polymer_elements.lib.src.paper_behaviors.paper_ripple_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_ripple.dart';

/// `Polymer.PaperRippleBehavior` dynamically implements a ripple
/// when the element has focus via pointer or keyboard.
///
/// NOTE: This behavior is intended to be used in conjunction with and after
/// `Polymer.IronButtonState` and `Polymer.IronControlState`.
@BehaviorProxy(const ['Polymer', 'PaperRippleBehavior'])
abstract class PaperRippleBehavior implements CustomElementProxyMixin {

  /// If true, the element will not produce a ripple effect when interacted
  /// with via the pointer.
  bool get noink => jsElement[r'noink'];
  set noink(bool value) { jsElement[r'noink'] = value; }

  /// Ensures this element contains a ripple effect. For startup efficiency
  /// the ripple effect is dynamically on demand when needed.
  /// [optTriggeringEvent]: (optional) event that triggered the
  ///     ripple.
  ensureRipple(optTriggeringEvent) =>
      jsElement.callMethod('ensureRipple', [optTriggeringEvent]);

  /// Returns the `<paper-ripple>` element used by this element to create
  /// ripple effects. The element's ripple is created on demand, when
  /// necessary, and calling this method will force the
  /// ripple to be created.
  getRipple() =>
      jsElement.callMethod('getRipple', []);

  /// Returns true if this element currently contains a ripple effect.
  bool hasRipple() =>
      jsElement.callMethod('hasRipple', []);
}
