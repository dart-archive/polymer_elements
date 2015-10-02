/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
library polymer_elements_demo.web.web.iron_validatable_behavior.cats_only;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_validator_behavior.dart';

/// Silence analyzer
@PolymerRegister('cats-only')
class CatsOnly extends PolymerElement with IronValidatorBehavior {
  CatsOnly.created() : super.created();

  @eventHandler
  @override
  bool validate(values) {
    if (values is Map) {
      return values.values.every((e) => e == 'cats');
    } else {
      String value = values is List ? values.join('') : values;
      return new RegExp(r'^(c|ca|cat|cats)?$').hasMatch(value);
    }
  }
}
