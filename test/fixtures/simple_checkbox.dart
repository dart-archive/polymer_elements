// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library polymer_elements.test.fixtures.simple_checkbox;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_checked_element_behavior.dart';
import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:polymer_elements/iron_validatable_behavior.dart';

@PolymerRegister('simple-checkbox')
class SimpleCheckbox extends PolymerElement
    with
        IronFormElementBehavior,
        IronValidatableBehavior,
        IronCheckedElementBehavior {
  SimpleCheckbox.created() : super.created();
}
