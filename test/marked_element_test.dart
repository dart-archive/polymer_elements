// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.marked_element_test;

import 'dart:html';
import 'package:polymer_elements/marked_element.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

String escapeHTML(string) {
  SpanElement span = document.createElement('span');
  span.text = string;
  return span.innerHtml;
}

class NoValidation implements NodeValidator {
  const NoValidation();

  bool allowsElement(Element element) {
    return true;
  }

  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }
}

const noValidation = const NoValidation();

main() async {
  await initWebComponents();

  group('<marked-element>', () {
    group('respects camelCased HTML', () {
      MarkedElement markedElement;
      DivElement proofElement;

      setUp(() {
        markedElement = fixture('CamelCaseHTML');
        proofElement = document.createElement('div');
      });

      test('in code blocks', () {
        proofElement.setInnerHtml('<div camelCase></div>',
            validator: noValidation);
        // If Markdown content were put into a `<template>` or directly into the DOM, it would be
        // rendered as DOM and be converted from camelCase to lowercase per HTML parsing rules. By
        // using `<script>` descendants, content is interpreted as plain text.
        expect(proofElement.innerHtml, equals('<div camelcase=""></div>'));
        expect(markedElement.$['content'].innerHtml,
            contains(escapeHTML('<div camelCase>')));
      });
    });

    group('respects bad HTML', () {
      MarkedElement markedElement;
      DivElement proofElement;

      setUp(() {
        markedElement = fixture('BadHTML');
        proofElement = document.createElement('div');
      });

      test('in code blocks', () {
        proofElement.setInnerHtml('<p><div></p></div>');
        // If Markdown content were put into a `<template>` or directly into the DOM, it would be
        // rendered as DOM and close unbalanced tags. Because they are in code blocks they should
        // remain as typed.
        expect(proofElement.innerHtml, equals('<p></p><div><p></p></div>'));
        expect(markedElement.$['content'].innerHtml,
            contains(escapeHTML('<p><div></p></div>')));
      });
    });
  });
}
