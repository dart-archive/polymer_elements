@HtmlImport('x_pretty_json.html')
library x_pretty_json;

import 'dart:convert' show JsonEncoder;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

@PolymerRegister('x-pretty-json')
class XPrettyJson extends PolymerElement {
  XPrettyJson.created() : super.created();
  @property Map object;

  @eventHandler
  String prettify(Map object) {
    if (object == null) {
      return '';
    }

    return new JsonEncoder.withIndent('  ').convert(object);
  }
}
