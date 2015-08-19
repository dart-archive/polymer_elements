@TestOn('browser')
library polymer_elements.test.paper_textarea_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_textarea.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'package:polymer_elements/iron_autogrow_textarea.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('setting value sets the input value', () {
      PaperTextarea input = fixture('basic');
      input.value = 'foobar';
      expect(input.inputElement.bindValue, equals(input.value));
    });

    test('empty required input shows error', () {
      PaperTextarea input = fixture('required');
      forceXIfStamp(input);
      var error = Polymer
          .dom(input.jsElement['root'])
          .querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, equals('visible'));
    });

    test('caret position is preserved', () {
      PaperTextarea input = fixture('basic');
      IronAutogrowTextarea ironTextarea = Polymer
          .dom(input.root)
          .querySelector('iron-autogrow-textarea');
      input.value = 'nananana';
      ironTextarea.textarea.selectionStart = 2;
      ironTextarea.textarea.selectionEnd = 2;
      input.updateValueAndPreserveCaret('nanananabatman');
      expect(ironTextarea.textarea.selectionStart, equals(2));
      expect(ironTextarea.textarea.selectionEnd, equals(2));
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/37');

    test('input attributes are bound to textarea', () {
      PaperTextarea input = fixture('basic');
      var attrs = {
        'autocomplete': 'true',
        'autofocus': true,
        'inputmode': 'number',
        'name': 'foo',
        'placeholder': 'bar',
        'readonly': true,
        'required': true,
        'maxlength': 3
      };
      for (var attr in attrs.keys) {
        input.setAttribute(attr, "${attrs[attr]}");
      }
      for (var attr in attrs.keys) {
        var attrsAttr = attrs[attr];
        var inputAttr = input.inputElement.getAttribute(attr);
        if (attrsAttr is bool) {
          expect(inputAttr != null, attrsAttr);
        } else {
          expect(inputAttr, equals('$attrsAttr'));
        }
      }
    });

    test('always-float-label attribute works', () {
      var input = fixture('always-float-label');
      PaperInputContainer container = Polymer
          .dom(input.jsElement['root'])
          .querySelector('paper-input-container');
      var inputContent = Polymer
          .dom(container.jsElement['root'])
          .querySelector('.input-content');
      expect(inputContent.classes.contains('label-is-floating'), isTrue);
    });
  });

  group('focus/blur events', () {
    PaperTextarea input;
    setUp(() {
      input = fixture('basic');
    });
    test('focus/blur events fired on host element', () {
      var nFocusEvents = 0;
      var nBlurEvents = 0;
      input.on['focus'].listen((e) {
        nFocusEvents += 1;
        expect(input.focused, isTrue);
        blur(input.inputElement.textarea);
      });

      input.on['blur'].listen((e) {
        nBlurEvents += 1;
        expect(input.focused, isFalse);
      });

      focus(input.inputElement.textarea);
      expect(nFocusEvents >= 1, isTrue);
      expect(nBlurEvents >= 1, isTrue);
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () {
      PaperTextarea input = fixture('label');
      expect(
          input.inputElement.textarea.attributes.containsKey('aria-labelledby'),
          isTrue);
      expect(input.inputElement.textarea.attributes['aria-labelledby'], equals(
          Polymer.dom(input.jsElement['root']).querySelector('label').id));
    });

    test('has aria-describedby for error message', () {
      PaperTextarea input = fixture('required');
      forceXIfStamp(input);
      expect(input.inputElement.textarea.attributes
          .containsKey('aria-describedby'), isTrue);
      expect(input.inputElement.textarea.attributes['aria-describedby'], equals(
          Polymer
              .dom(input.jsElement['root'])
              .querySelector('paper-input-error').id));
    });

    test('has aria-describedby for character counter', () {
      PaperTextarea input = fixture('char-counter');
      forceXIfStamp(input);
      expect(input.inputElement.textarea.attributes
          .containsKey('aria-describedby'), isTrue);
      expect(input.inputElement.textarea.attributes['aria-describedby'], equals(
          Polymer
              .dom(input.jsElement['root'])
              .querySelector('paper-input-char-counter').id));
    });

    test('has aria-describedby for character counter and error', () {
      PaperTextarea input = fixture('required-char-counter');
      forceXIfStamp(input);
      expect(input.inputElement.textarea.attributes
          .containsKey('aria-describedby'), isTrue);
      expect(input.inputElement.textarea.attributes['aria-describedby'], equals(
          Polymer
                  .dom(input.jsElement['root'])
                  .querySelector('paper-input-error').id +
              ' ' +
              Polymer
                  .dom(input.jsElement['root'])
                  .querySelector('paper-input-char-counter').id));
    });
  });
}
