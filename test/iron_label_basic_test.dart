// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_label_basic_test;

import 'dart:async';
import 'dart:html';

import 'package:polymer_elements/iron_label.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('id generated on creation', () {
      IronLabel e = document.createElement('iron-label');
      expect(e.id, 'iron-label-0');
    });

    test('id not overwritten if given', () {
      IronLabel label = fixture('ExplicitId');
      expect(label.id, 'explicit', reason: 'explict id is kept');
    });

    test('ids are unique', () {
      var labels = fixture('UniqueIds');
      expect(labels[0].id, isNot(labels[1].id));
    });

    // TODO(jakemac): investigate (probably not important though)
    // a11ygroup('TrivialWrapper');
    // a11ygroup('MultiElementWrapper');
    // a11ygroup('ExplicitId');
    // a11ygroup('TrivialSelector');
  });

  group('targeting', () {
    expectedTarget(HtmlElement expected, IronLabel label) {
      expect(expected, isNotNull, reason: 'expected is defined');
      expect(label, isNotNull, reason: 'label is defined');
      var actual = label.jsElement.callMethod('_findTarget');
      expect(actual, expected, reason: 'target is expected');
      expect(expected.attributes.containsKey('aria-labelledby'), isTrue,
          reason: 'has aria labelledby');
      expect(expected.getAttribute('aria-labelledby'), label.id,
          reason: 'aria-labelledby points to iron-label');
      if (label.labelFor != null) {
        expect(label.getAttribute('for'), label.labelFor,
            reason: 'for property reflected');
      }
    }

    test('Trivial', () {
      var label = fixture('TrivialWrapper');
      var expected = Polymer.dom(label).firstElementChild;
      expectedTarget(expected, label);
    });

    test('Multiple', () {
      var label = fixture('MultiElementWrapper');
      var expected = Polymer.dom(label).querySelector('[iron-label-target]');
      expectedTarget(expected, label);
    });

    test('selected target via selector', () {
      var container = fixture('TrivialSelector');
      var label = Polymer.dom(container).firstElementChild;
      var expected = label.nextElementSibling;
      expectedTarget(expected, label);
    });
  });

  group('dynamic targeting', () {
    var container, label, nested, one;

    setUp(() {
      container = fixture('DynamicLabel');
      label = Polymer.dom(container).querySelector('#label');
      nested = Polymer.dom(label).firstElementChild;
      one = Polymer.dom(container).querySelector('#one');
    });

    test('nested is target', () {
      expect(nested.getAttribute('aria-labelledby'), label.id);
      expect(one.attributes.containsKey('aria-labelledby'), isFalse);
    });

    test('nested -> #one', () {
      label.labelFor = 'one';
      expect(one.getAttribute('aria-labelledby'), label.id);
      expect(nested.attributes.containsKey('aria-labelledby'), isFalse);
    });
  });
}
