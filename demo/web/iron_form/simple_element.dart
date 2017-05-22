/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('simple_element.html')
library polymer_elements_demo.web.web.iron_form.simple_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:polymer_elements/iron_validatable_behavior.dart';


/// Silence analyzer
@PolymerRegister('simple-element')
class SimpleElement extends PolymerElement with IronFormElementBehavior, IronValidatableBehavior {
  SimpleElement.created() : super.created();

  @property String value;

  @Listen('input')
  inputHandler([_, __]) =>
    set('value',($['input'] as dom.TextInputElement).value);

  // Overidden from Polymer.IronValidatableBehavior. Will set the `invalid`
  // attribute automatically, which should be used for styling.
  // TODO(zoechi) should override `_getValidity()` from IronValidatableBehavior but that is not available in Dart
  @override
  bool getValidity() =>
    value != null && value.isNotEmpty;
}
