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
import 'fixtures/cats_only.dart';
import 'fixtures/dogs_only.dart';

main() async {
  await initPolymer();

  group('basic', () {
    test('setting `invalid` sets `aria-invalid=true`', () {
      TestValidatable node = fixture('basic');
      node.invalid = true;
      expect(node.getAttribute('aria-invalid'), 'true', reason: 'aria-invalid is set');
      node.invalid = false;
      expect(node.getAttribute('aria-invalid'), isNull, reason: 'aria-invalid is unset');
    });

    test('validate() is true if a validator isn\'t set', () {
      TestValidatable node = fixture('basic');
      var valid = node.validate(null);
      expect(valid, isTrue);
    });

    test('dart only check if validators are ok',(){
      List node = fixture('validators');
      CatsOnly catsOnly =node[0];
      DogsOnly dogsOnly = node[1];

      expect(catsOnly.validate("cats"),isTrue);
      expect(dogsOnly.validate("dogs"),isTrue);

      expect(catsOnly.validate("csats"),isFalse);
      expect(dogsOnly.validate("dogss"),isFalse);

    });

    test('changing the validator works', () async {
      List node = fixture('validators');
      CatsOnly catsOnly =node[0];
      DogsOnly dogsOnly = node[1];

      TestValidatable input = node[2];

      // Initially there's no validator, so everything is valid.
      $assert.isTrue(input.validate(''));
      $assert.isTrue(input.validate('cats'));

      // Only valid if the value is 'cats'.
      input.validator = 'cats-only';
      await wait(1);
      $assert.isFalse(input.validate('ca'));
      $assert.isTrue(input.validate('cats'));

      // Only valid if the value is 'dogs'.
      input.validator = 'dogs-only';
      $assert.isFalse(input.validate('cats'));
      $assert.isTrue(input.validate('dogs'));
    },skip: "is this actually working in js ???");
  });
}

@PolymerRegister('test-validatable')
class TestValidatable extends PolymerElement with IronValidatableBehavior {
  TestValidatable.created() : super.created();
}
