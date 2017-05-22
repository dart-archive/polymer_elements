/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('ssn_input.html')
library polymer_elements_demo.web.web.paper_input.ssn_input;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_validatable_behavior.dart';

/// Silence analyzer
@PolymerRegister('ssn-input')
class SsnInput extends PolymerElement with IronValidatableBehavior {
  SsnInput.created() : super.created();

  @Property(notify: true) String value;
  @property String ssn1;
  @property String ssn2;
  @property String ssn3;
  ready() {
    set('validator', 'ssn-validator');
  }
  @Observe('ssn1,ssn2,ssn3')
  computeValue(String ssn1, String ssn2, String ssn3) =>
      set('value', '${ssn1.trim()}-${ssn2.trim()}-${ssn3.trim()}');
}
