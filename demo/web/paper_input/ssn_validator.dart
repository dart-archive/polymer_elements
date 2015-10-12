/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
library polymer_elements_demo.web.web.paper_input.ssn_validator;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_validator_behavior.dart';

/// Silence analyzer
@PolymerRegister('ssn-validator')
class SsnValidator extends PolymerElement with IronValidatorBehavior {
  SsnValidator.created() : super.created();

  @reflectable
  @override
  bool validate(value) {
    // this regex validates incomplete ssn's (by design)
    return value == null || (value is String && value.isEmpty) || new RegExp(r'^[0-9]{0,3}-[0-9]{0,2}-[0-9]{0,4}$').hasMatch(value);
  }
}
