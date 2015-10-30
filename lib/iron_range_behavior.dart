// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_range_behavior`.
@HtmlImport('iron_range_behavior_nodart.html')
library polymer_elements.lib.src.iron_range_behavior.iron_range_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `iron-range-behavior` provides the behavior for something with a minimum to maximum range.
@BehaviorProxy(const ['Polymer', 'IronRangeBehavior'])
abstract class IronRangeBehavior implements CustomElementProxyMixin {

  /// The number that indicates the maximum value of the range.
  num get max => jsElement[r'max'];
  set max(num value) { jsElement[r'max'] = value; }

  /// The number that indicates the minimum value of the range.
  num get min => jsElement[r'min'];
  set min(num value) { jsElement[r'min'] = value; }

  /// Returns the ratio of the value.
  num get ratio => jsElement[r'ratio'];
  set ratio(num value) { jsElement[r'ratio'] = value; }

  /// Specifies the value granularity of the range's value.
  num get step => jsElement[r'step'];
  set step(num value) { jsElement[r'step'] = value; }

  /// The number that represents the current value.
  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
