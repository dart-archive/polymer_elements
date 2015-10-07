// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `date_validator`.
@HtmlImport('date_validator_nodart.html')
library polymer_elements.lib.src.gold_cc_expiration_input.date_validator;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_validator_behavior.dart';


@CustomElementProxy('date-validator')
class DateValidator extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronValidatorBehavior {
  DateValidator.created() : super.created();
  factory DateValidator() => new Element.tag('date-validator');

  validate(date) =>
      jsElement.callMethod('validate', [date]);
}
