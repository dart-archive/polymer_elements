/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('x_pretty_json.html')
library polymer_elements.demo.web.firebase_element.x_pretty_json;

import 'dart:convert' show JsonEncoder;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

@PolymerRegister('x-pretty-json')
class XPrettyJson extends PolymerElement {
  XPrettyJson.created() : super.created();
  @property Map object;

  @eventHandler
  String prettify(Object object) {
    if (object == null) {
      return '';
    }

    return new JsonEncoder.withIndent('  ').convert(object);
  }
}
