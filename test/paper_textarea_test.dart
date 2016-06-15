// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_textarea_test;

import 'dart:async';
import 'dart:html';

import 'package:polymer_interop/polymer_interop.dart';
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
      IronAutogrowTextarea ironTextarea =
          Polymer.dom(input.root).querySelector('iron-autogrow-textarea');
      input.value = 'nananana';
      ironTextarea.textarea.selectionStart = 2;
      ironTextarea.textarea.selectionEnd = 2;
      input.updateValueAndPreserveCaret('nanananabatman');
      expect(ironTextarea.textarea.selectionStart, equals(2));
      expect(ironTextarea.textarea.selectionEnd, equals(2));
    });

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


    // At the moment, it is very hard to correctly fire exactly
    // one focus/blur events on a paper-textarea. This is because
    // when a paper-textarea is focused, it needs to focus
    // its underlying native textarea, which will also fire a `blur`
    // event.
    test('focus events fired on host element', () {
    input.on['focus'].take(1).listen( (event) {
    $$assert(input.focused, 'input is focused');
    });
    focus(input);
    });

    test('focus events fired on host element if nested element is focused', () {
    input.on['focus'].take(1).listen( (event) {
    $$assert(input.focused, 'input is focused');
    });
    focus(input.inputElement.textarea);
    });

    test('blur events fired on host element', () {
    focus(input);
    input.on['blur'].take(1).listen( (event) {
    $$assert(!input.focused, 'input is blurred');
    });
    blur(input);
    });

    test('blur events fired on host element nested element is blurred', () {
    focus(input);
    input.on['blur'].take(1).listen( (event) {
    $$assert(!input.focused, 'input is blurred');
    });
    blur(input.inputElement.textarea);
    });

    test('focusing then bluring sets the focused attribute correctly', () {
    focus(input);
    $$assert(input.focused, 'input is focused');
    blur(input);
    $$assert(!input.focused, 'input is blurred');
    focus(input.inputElement.textarea);
    $$assert(input.focused, 'input is focused');
    blur(input.inputElement.textarea);
    $$assert(!input.focused, 'input is blurred');
    });
    
  });

  group('a11y', () {
    test('has aria-labelledby', () async {
      PaperTextarea input = fixture('label');
      await new Future(() {});
      expect(
          input.inputElement.textarea.attributes.containsKey('aria-labelledby'),
          isTrue);
      expect(
          input.inputElement.textarea.attributes['aria-labelledby'],
          equals(
              Polymer.dom(input.jsElement['root']).querySelector('label').id));
    });

    test('has aria-describedby for error message', () {
      PaperTextarea input = fixture('required');
      forceXIfStamp(input);
      expect(
          input.inputElement.textarea.attributes
              .containsKey('aria-describedby'),
          isTrue);
      expect(
          input.inputElement.textarea.attributes['aria-describedby'],
          equals(Polymer
              .dom(input.jsElement['root'])
              .querySelector('paper-input-error')
              .id));
    });

    test('has aria-describedby for character counter', () {
      PaperTextarea input = fixture('char-counter');
      forceXIfStamp(input);
      expect(
          input.inputElement.textarea.attributes
              .containsKey('aria-describedby'),
          isTrue);
      expect(
          input.inputElement.textarea.attributes['aria-describedby'],
          equals(Polymer
              .dom(input.jsElement['root'])
              .querySelector('paper-input-char-counter')
              .id));
    });

    test('has aria-describedby for character counter and error', () {
      PaperTextarea input = fixture('required-char-counter');
      forceXIfStamp(input);
      expect(
          input.inputElement.textarea.attributes
              .containsKey('aria-describedby'),
          isTrue);
      expect(
          input.inputElement.textarea.attributes['aria-describedby'],
          equals(Polymer
                  .dom(input.jsElement['root'])
                  .querySelector('paper-input-error')
                  .id +
              ' ' +
              Polymer
                  .dom(input.jsElement['root'])
                  .querySelector('paper-input-char-counter')
                  .id));
    });
  });
}
