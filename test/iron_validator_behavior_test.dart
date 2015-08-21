@TestOn('browser')
library polymer_elements.test.iron_validator_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_meta.dart';
import 'package:polymer_elements/iron_validator_behavior.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('registered in <iron-meta>', () {
      SimpleValidator validator = fixture('basic');
      expect(new IronMeta()
            ..type = 'validator'
            ..byKey('simple-validator'), isNotNull,
          reason: 'simple-validator found in <iron-meta>');
    });
  });
}

@jsProxyReflectable
@PolymerRegister('simple-validator')
class SimpleValidator extends PolymerElement with IronValidatorBehavior {
  SimpleValidator.created() : super.created();
}
