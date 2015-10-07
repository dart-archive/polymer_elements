// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `zip_validator`.
@HtmlImport('zip_validator_nodart.html')
library polymer_elements.lib.src.gold_zip_input.zip_validator;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_validator_behavior.dart';


@CustomElementProxy('zip-validator')
class ZipValidator extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronValidatorBehavior {
  ZipValidator.created() : super.created();
  factory ZipValidator() => new Element.tag('zip-validator');

  validate(value) =>
      jsElement.callMethod('validate', [value]);
}
