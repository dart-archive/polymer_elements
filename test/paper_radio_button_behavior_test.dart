// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_radio_button_behavior_test;

import 'package:test/test.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_checked_element_behavior.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:polymer_elements/iron_validatable_behavior.dart';
import 'package:polymer_elements/paper_checked_element_behavior.dart';
import 'package:polymer_elements/paper_inky_focus_behavior.dart';
import 'package:polymer_elements/paper_ripple_behavior.dart';
import 'package:polymer/polymer.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('basic', () {
    TestRadioButton button;

    setUp(() {
      button = fixture('basic');
      blur(button);
    });

    test('normal (no states)', () {
      expect(button.focused, isFalse);
      expect(button.hasRipple(), isFalse);
    });

    test('receives focus', () {
      focus(button);

      expect(button.focused, isTrue);
      expect(button.hasRipple(), isTrue);
    });
  });
}

@PolymerRegister('test-radio-button')
class TestRadioButton extends PolymerElement
    with
        IronA11yKeysBehavior,
        IronButtonState,
        IronControlState,
        PaperRippleBehavior,
        PaperInkyFocusBehavior,
        IronFormElementBehavior,
        IronValidatableBehavior,
        IronCheckedElementBehavior,
        PaperCheckedElementBehavior {
  TestRadioButton.created() : super.created();
}
