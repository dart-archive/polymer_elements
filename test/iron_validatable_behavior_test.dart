@TestOn('browser')
library polymer_elements.test.iron_validatable_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_validatable_behavior.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('setting `invalid` sets `aria-invalid=true`', () {
      TestValidatable node = fixture('basic');
      node.invalid = true;
      expect(node.getAttribute('aria-invalid'), 'true',
          reason: 'aria-invalid is set');
      node.invalid = false;
      expect(node.getAttribute('aria-invalid'), isNull,
          reason: 'aria-invalid is unset');
    });

    test('validate() is true if a validator isn\'t set', () {
      TestValidatable node = fixture('basic');
      var valid = node.validate(null);
      expect(valid, isTrue);
    });
  });
}

@jsProxyReflectable
@PolymerRegister('test-validatable')
class TestValidatable extends PolymerElement with IronValidatableBehavior {
  TestValidatable.created() : super.created();
}
