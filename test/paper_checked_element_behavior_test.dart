// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_checked_element_behavior_test;

import 'dart:async';
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
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('PaperCheckedElementBehavior', () {
    TestChecked checked;

    setUp(() {
      checked = fixture('basic');
    });

    test('element checked when tapped to check', () {
      tap(checked);
      expect(checked.checked, isTrue);
    });

    test('element checked when active', () {
      checked.active = true;
      expect(checked.checked, isTrue);
    });

    test('element not checked when disabled and made active', () {
      checked.disabled = true;
      checked.active = true;
      expect(checked.checked, isFalse);
    });

    test('element not checked when disabled and tapped', () {
      checked.disabled = true;
      tap(checked);
      expect(checked.checked, isFalse);
    });

    test('element ripple has checked attribute when element tapped to check',
        () {
      tap(checked);
      expect(checked.hasRipple(), isTrue);
      expect(checked.getRipple().getAttribute('checked'), isNotNull);
    });

    test(
        'element ripple does not have checked attribute when element tapped to '
        'uncheck', () {
      tap(checked);
      tap(checked);
      expect(checked.getRipple().getAttribute('checked'), isNull);
    });
  });
}

@PolymerRegister('test-checked')
class TestChecked extends PolymerElement
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
  TestChecked.created() : super.created();
}
