// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_ripple_behavior_test;

import 'package:test/test.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_elements/paper_ripple_behavior.dart';
import 'package:polymer/polymer.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('PaperRippleBehavior', () {
    var ripple;

    setUp(() {
      ripple = fixture('basic');
    });

    test('no ripple at startup', () {
      expect(ripple.hasRipple(), isFalse);
    });

    test('calling getRipple returns ripple', () {
      expect(ripple.getRipple(), isNotNull);
    });

    test('focus generates ripple', () {
      focus(ripple);
      expect(ripple.hasRipple(), isTrue);
    });

    test('down generates ripple', () {
      down(ripple);
      expect(ripple.hasRipple(), isTrue);
      up(ripple);
    });
  });
}

@PolymerRegister('test-ripple')
class TestRipple extends PolymerElement
    with
        IronA11yKeysBehavior,
        IronButtonState,
        IronControlState,
        PaperRippleBehavior {
  TestRipple.created() : super.created();
}
