// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `date_input`.
@HtmlImport('date_input_nodart.html')
library polymer_elements.lib.src.gold_cc_expiration_input.date_input;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_validatable_behavior.dart';
import 'iron_input.dart';
import 'iron_flex_layout.dart';
import 'paper_input_container.dart';
import 'default_theme.dart';
import 'typography.dart';
import 'date_validator.dart';


@CustomElementProxy('date-input')
class DateInput extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronValidatableBehavior {
  DateInput.created() : super.created();
  factory DateInput() => new Element.tag('date-input');

  String get ariaLabelPrefix => jsElement[r'ariaLabelPrefix'];
  set ariaLabelPrefix(String value) { jsElement[r'ariaLabelPrefix'] = value; }

  /// Set to true to autofocus the month input element.
  bool get autofocus => jsElement[r'autofocus'];
  set autofocus(bool value) { jsElement[r'autofocus'] = value; }

  /// The date object used by the validator. Has two properties, month and year.
  get date => jsElement[r'date'];
  set date(value) { jsElement[r'date'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Set to true to disable the month and year input elements.
  bool get disabled => jsElement[r'disabled'];
  set disabled(bool value) { jsElement[r'disabled'] = value; }

  /// Bound to the month and year input elements' `inputmode` property.
  String get inputmode => jsElement[r'inputmode'];
  set inputmode(String value) { jsElement[r'inputmode'] = value; }

  /// The month component of the date displayed.
  String get month => jsElement[r'month'];
  set month(String value) { jsElement[r'month'] = value; }

  /// Set to true to mark the month and year inputs as not editable.
  bool get readonly => jsElement[r'readonly'];
  set readonly(bool value) { jsElement[r'readonly'] = value; }

  /// Set to true to mark the input as required.
  bool get required => jsElement[r'required'];
  set required(bool value) { jsElement[r'required'] = value; }

  String get validator => jsElement[r'validator'];
  set validator(String value) { jsElement[r'validator'] = value; }

  /// The year component of the date displayed.
  String get year => jsElement[r'year'];
  set year(String value) { jsElement[r'year'] = value; }

  validate([_]) => //() =>
      jsElement.callMethod('validate', []);
}
