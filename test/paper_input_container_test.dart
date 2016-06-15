// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_input_container_test;

import 'dart:async';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'common.dart';
import 'dart:html';

String getTransform(node) {
  var style = node.getComputedStyle();
  return style.transform == null ? style.webkitTransform : style.transform;
}

main() async {
  await initWebComponents();

  suite('basic', () {
    test('can be created imperatively', () {
      PaperInputContainer container = document.createElement('paper-input-container');
      IronInput input = document.createElement('input', 'iron-input');
      input.className = 'paper-input-input';
      input.id = 'input';

      var label = document.createElement('label');
      label.innerHtml = 'label';

      new PolymerDom(container).append(label);
      new PolymerDom(container).append(input);

      document.body.children.add(container);
      $assert.isOk(container);
      document.body.children.remove(container);
    });
  });

  group('label position', () {
    test('label is visible by default', () async {
      PaperInputContainer container = fixture('basic');
      await new Future(() {});
      expect(container.querySelector('#l').getComputedStyle().visibility,
          equals('visible'));
    });

    test('label is floated if value is initialized to not null', () async {
      PaperInputContainer container = fixture('has-value');
      await new Future(() {});
      expect(
          getTransform(container.querySelector('#l')), isNot(equals('none')));
    });

    test(
        'label is invisible if no-label-float and value is initialized to not null',
        () async {
      PaperInputContainer container = fixture('no-float-has-value');
      await new Future(() {});
      expect(container.querySelector('#l').getComputedStyle().visibility,
          equals('hidden'));
    });

    test('label is floated if always-float-label is true', () async {
      PaperInputContainer container = fixture('always-float');
      await new Future(() {});
      expect(
          getTransform(container.querySelector('#l')), isNot(equals('none')));
    });
  });

  group('focused styling', () {
    test('label is colored when input is focused and has value', () async {
      PaperInputContainer container = fixture('has-value');
      await new Future(() {});
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent = container.$$('.input-content');
      focus(input);
      await requestAnimationFrame();
      expect(container.focused, isTrue);
      expect(inputContent.classes.contains('label-is-highlighted'), isTrue);
    });

    test('label is not colored when input is focused and has null value',
        () async {
      PaperInputContainer container = fixture('basic');
      await new Future(() {});
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent = container.$$('.input-content');
      focus(input);
      await requestAnimationFrame();
      expect(inputContent.classes.contains('label-is-highlighted'), isFalse);
    });

    test('underline is colored when input is focused', () async {
      PaperInputContainer container = fixture('basic');
      await new Future(() {});
      var input = Polymer.dom(container).querySelector('#i');
      var line = container.$$('.underline');
      expect(line.classes.contains('is-highlighted'), isFalse);
      focus(input);
      await requestAnimationFrame();
      expect(line.classes.contains('is-highlighted'), isTrue);
    });
  });

  group('validation', () {
    test('styled when the input is set to an invalid value with auto-validate',
        () async {
      PaperInputContainer container = fixture('auto-validate-numbers');
      await new Future(() {});
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent = container.$$('.input-content');
      var line = container.$$('.underline');
      input.bindValue = 'foobar';
      expect(container.invalid, isTrue);
      expect(inputContent.classes.contains('is-invalid'), isTrue);
      expect(line.classes.contains('is-invalid'), isTrue);
    });

    test(
        'styled when the input is set to an invalid value with auto-validate, with validator',
        () async {
      PaperInputContainer container = fixture('auto-validate-validator');
      await new Future(() {});
      var input = Polymer.dom(container).querySelector('#i');
      var inputContent = container.$$('.input-content');
      var line = container.$$('.underline');
      input.bindValue = '123123';
      expect(container.invalid, isTrue);
      expect(inputContent.classes.contains('is-invalid'), isTrue);
      expect(line.classes.contains('is-invalid'), isTrue);
    });

    test(
        'styled when the input is set initially to an invalid value with auto-validate, with validator',
        () async {
      PaperInputContainer container =
          fixture('auto-validate-validator-has-invalid-value');
      await new Future(() {});
      expect(container.invalid, isTrue);
      expect(container.$$('.underline').classes.contains('is-invalid'), isTrue);
    });

    test(
        'styled when the input is set to an invalid value with manual validation',
        () async {
      PaperInputContainer container = fixture('manual-validate-numbers');
      await new Future(() {});
      IronInput input = Polymer.dom(container).querySelector('#i');
      var inputContent = container.$$('.input-content');
      var line = container.$$('.underline');
      input.bindValue = 'foobar';
      input.validate();
      expect(container.invalid, isTrue);
      expect(inputContent.classes.contains('is-invalid'), isTrue);
      expect(line.classes.contains('is-invalid'), isTrue);
    });

    test('label is floated correctly with a prefix', () async {
      var container = fixture('prefix');
      var label = Polymer.dom(container).querySelector('#l');
      var input = Polymer.dom(container).querySelector('#i');

      // Label is initially visible.
      expect(label.getComputedStyle().visibility, 'visible',
          reason: 'label has visibility:visible');

      // After entering text, the label floats, and it is not indented.
      input.bindValue = 'foobar';
      await wait(1);
      expect(getTransform(label), isNot('none'), reason: 'label has transform');
      expect(label.getBoundingClientRect().left,
          container.getBoundingClientRect().left);
    });

    test('label is floated correctly with a prefix and prefilled value',
        () async {
      var container = fixture('prefix-has-value');
      var label = Polymer.dom(container).querySelector('#l');

      // The label floats, and it is not indented.
      await wait(1);
      expect(getTransform(label), isNot('none'), reason: 'label has transform');
      expect(label.getBoundingClientRect().left,
          container.getBoundingClientRect().left);
    });
  });
}
