@TestOn('browser')
library polymer_elements.test.paper_input_container_test;

import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'common.dart';

String getTransform(node) {
  var style = node.getComputedStyle();
  return style.transform == null ? style.webkitTransform : style.transform;
}

main() async {
  await initWebComponents();

  group('label position', () {
    test('label is visible by default', () {
      PaperInputContainer container = fixture('basic');
      expect(
          container.querySelector('#l').getComputedStyle().visibility,
          equals('visible'));
    });


    test('label is floated if value is initialized to not null', () {
      PaperInputContainer container = fixture('has-value');
      expect(getTransform(container.querySelector('#l')), isNot(equals('none')));
    });


    test(
        'label is invisible if no-label-float and value is initialized to not null',
        () {
      PaperInputContainer container = fixture('no-float-has-value');
      expect(
          container.querySelector('#l').getComputedStyle().visibility,
          equals('hidden'));
    });

    test('label is floated if always-float-label is true', () {
      PaperInputContainer container = fixture('always-float');
      expect(getTransform(container.querySelector('#l')),
          isNot(equals('none')));
    });
  });

  group('focused styling', () {
    test('label is colored when input is focused and has value', () async {
      PaperInputContainer container = fixture('has-value');
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent =
          Polymer.dom(container.jsElement['root']).querySelector('.input-content');
      focus(input);
      await requestAnimationFrame();
      expect(container.focused, isTrue);
      expect(inputContent.classes.contains('label-is-highlighted'), isTrue);
    });

    test('label is not colored when input is focused and has null value', () async {
      PaperInputContainer container = fixture('basic');
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent =
          Polymer.dom(container.jsElement['root']).querySelector('.input-content');
      focus(input);
      await requestAnimationFrame();
      expect(inputContent.classes.contains('label-is-highlighted'), isFalse);
    });

    test('underline is colored when input is focused', () async {
      PaperInputContainer container = fixture('basic');
      var input = Polymer.dom(container).querySelector('#i');
      var line = Polymer.dom(container.jsElement['root']).querySelector('.underline');
      expect(line.classes.contains('is-highlighted'),isFalse);
      focus(input);
      await requestAnimationFrame();
      expect(line.classes.contains('is-highlighted'),isTrue);
    });

  });


  group('validation', () {
    test('styled when the input is set to an invalid value with auto-validate',
        () {
      PaperInputContainer container = fixture('auto-validate-numbers');
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent =
          Polymer.dom(container.jsElement['root']).querySelector('.input-content');
      var line = Polymer.dom(container.jsElement['root']).querySelector('.underline');
      input.bindValue = 'foobar';
      expect(container.invalid, isTrue);
      expect(inputContent.classes.contains('is-invalid'),isTrue);
      expect(line.classes.contains('is-invalid'),isTrue);
    });

    test(
        'styled when the input is set to an invalid value with auto-validate, with validator',
        () {
      PaperInputContainer container = fixture('auto-validate-validator');
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent =
          Polymer.dom(container.jsElement['root']).querySelector('.input-content');
      var line = Polymer.dom(container.jsElement['root']).querySelector('.underline');
      input.bindValue = '123123';
      expect(container.invalid, isTrue);
      expect(inputContent.classes.contains('is-invalid'),isTrue);
      expect(line.classes.contains('is-invalid'),isTrue);
    });

    test(
        'styled when the input is set initially to an invalid value with auto-validate, with validator',
        () {
      PaperInputContainer container =
          fixture('auto-validate-validator-has-invalid-value');
      expect(container.invalid, isTrue);
      expect(Polymer.dom(container.jsElement['root']).querySelector('.underline').classes
          .contains('is-invalid'), isTrue);
    });


    test(
        'styled when the input is set to an invalid value with manual validation',
        () {
      PaperInputContainer container = fixture('manual-validate-numbers');
      IronInput input = Polymer.dom(container).querySelector('#i');
      var inputContent =
          Polymer.dom(container.jsElement['root']).querySelector('.input-content');
      var line = Polymer.dom(container.jsElement['root']).querySelector('.underline');
      input.bindValue = 'foobar';
      input.validate();
      expect(container.invalid, isTrue);
      expect(inputContent.classes.contains('is-invalid'),isTrue);
      expect(line.classes.contains('is-invalid'),isTrue);
    });

  });


}
