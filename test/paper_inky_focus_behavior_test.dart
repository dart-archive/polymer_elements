@TestOn('browser')
library polymer_elements.test.paper_inky_focus_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_elements/paper_inky_focus_behavior.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  
  group('basic', () {
    var button;
    var ink;

    setUp(() {
      button = fixture('basic');
      ink = button.querySelector('paper-ripple');
      blur(button);
    });

    test('normal (no states)', () {
      expect(button.focused, isFalse);
      expect(ink.jsElement['_animating'], isFalse);
      expect(ink.ripples.length, 0);
    });

    test('receives focus', () {
      focus(button);

      expect(button.focused, isTrue);
      expect(ink.jsElement['_animating'], isTrue);
      expect(ink.ripples.length, 1);
    });

  });
}

@jsProxyReflectable
@PolymerRegister('test-radio-button')
class TestRadioButton extends PolymerElement
    with
        IronA11yKeysBehavior,
        IronButtonState,
        IronControlState,
        PaperInkyFocusBehavior {
  TestRadioButton.created() : super.created();
}
