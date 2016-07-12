// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_query_params`.
@HtmlImport('iron_query_params_nodart.html')
library polymer_elements.lib.src.iron_location.iron_query_params;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';


@CustomElementProxy('iron-query-params')
class IronQueryParams extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronQueryParams.created() : super.created();
  factory IronQueryParams() => new Element.tag('iron-query-params');

  get paramsObject => jsElement[r'paramsObject'];
  set paramsObject(value) { jsElement[r'paramsObject'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  String get paramsString => jsElement[r'paramsString'];
  set paramsString(String value) { jsElement[r'paramsString'] = value; }

  paramsObjectChanged() =>
      jsElement.callMethod('paramsObjectChanged', []);

  paramsStringChanged() =>
      jsElement.callMethod('paramsStringChanged', []);
}
