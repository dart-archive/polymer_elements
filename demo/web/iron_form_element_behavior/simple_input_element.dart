/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
library polymer_elements_demo.web.web.iron_form_element_behavior.simple_element;

import 'dart:html' as dom;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_form_element_behavior.dart';

/// Silence analyzer
/// Info: name part `-input` added to disambiguate from
///   iron_form/simple_element
@PolymerRegister('simple-input-element', extendsTag: 'input')
class SimpleInputElement extends dom.InputElement
    with PolymerMixin, PolymerBase, JsProxy, IronFormElementBehavior {
  SimpleInputElement.created() : super.created() {
    polymerCreated();
  }
}
