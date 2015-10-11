// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('simple_element.html')
library polymer_elements.test.fixtures.simple_element;

import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('simple-element')
class SimpleElement extends PolymerElement with IronFormElementBehavior {
  SimpleElement.created() : super.created();

  @property
  bool invalid = false;

  @property
  String value;

  @reflectable
  bool validate() {
    var valid = value != null && value.isNotEmpty;
    set('invalid', !valid);
    return valid;
  }
}
