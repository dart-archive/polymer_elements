/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
//@HtmlImport('validatable_input.html')
library polymer_elements_demo.web.web.iron_validatable_behavior.validatable_input;

import 'dart:html' as dom;
//import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_validatable_behavior.dart';
import 'package:polymer_elements/iron_meta.dart';

/// Silence analyzer
@PolymerRegister('validatable-input', extendsTag: 'input')
class ValidatableInput extends dom.InputElement
    with PolymerMixin, PolymerBase, JsProxy, IronValidatableBehavior {
  ValidatableInput.created() : super.created() {
    polymerCreated();
  }

  @Listen('input')
  inputHandler([_, __]) => this.invalid = !validate(value);
}
