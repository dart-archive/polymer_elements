// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('element_with_nested_form_element.html')
library polymer_elements.test.fixtures.element_with_nested_form_element;

import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import "simple_element.dart";

@PolymerRegister('element-with-nested-form-element')
class ElementWithNestedFormElement extends PolymerElement with IronFormElementBehavior {
  ElementWithNestedFormElement.created() : super.created();

  @property
  String name;

}
