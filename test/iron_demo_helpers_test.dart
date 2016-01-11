// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_demo_helpers_test;

import 'dart:async';
import 'dart:html';

import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/demo_snippet.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';

import 'common.dart';

main() async {
  await initWebComponents();

  group('display', () {
    var emptyHeight;

    setUp(() {
      DemoSnippet emptyDemo = fixture('empty-demo');
      emptyHeight = emptyDemo.getBoundingClientRect().height;
    });

    test('can render native elements', () {
      DemoSnippet element = fixture('native-demo');

      // Render the distributed children.
      PolymerDom.flush();

      var rect = element.getBoundingClientRect();
      expect(rect.height, greaterThan(emptyHeight));

      // The demo is rendered in the light dom, so it should exist, and
      // it should respect the demo element's attributes, and not make up
      // new ones.
      var input = Polymer.dom(element).querySelector('input');
      expect(input, isNotNull);
      expect(input.disabled, isTrue);
      expect(input.checked, isFalse);

      var markdownElement = element.$['marked'];
      expect(markdownElement.markdown, '```\n\n<input disabled>\n\n```');
    });

    test('can render custom elements', () {
      DemoSnippet element = fixture('custom-demo');

      // Render the distributed children.
      PolymerDom.flush();

      var rect = element.getBoundingClientRect();
      expect(rect.height, greaterThan(emptyHeight));

      // The demo is rendered in the light dom, so it should exist, and
      // it should respect the demo element's attributes, and not make up
      // new ones.
      PaperCheckbox checkbox =
          Polymer.dom(element).querySelector('paper-checkbox');
      expect(checkbox, isNotNull);
      expect(checkbox.disabled, isTrue);
      expect(checkbox.checked, isFalse);

      var markdownElement = element.$['marked'];
      expect(markdownElement.markdown,
          '```\n\n<paper-checkbox disabled></paper-checkbox>\n\n```');
    }, skip: 'Local dom is also being printed');
  });

  group('parsing', () {
    var element;

    setUp(() {
      var element = fixture('demo-with-attributes');
    });

    test('preserves attributes', () {
      var element = fixture('demo-with-attributes');

      // Render the distributed children.
      PolymerDom.flush();

      var markdownElement = element.$['marked'];
      expect(markdownElement.markdown,
          '```\n\n<input disabled type="date">\n\n```');
    });
  });
}
