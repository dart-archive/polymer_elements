// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_list_hidden_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';
import 'fixtures/x_list.dart';

main() async {
  await initPolymer();

  group('hidden list', () {
    IronList list;
    XList container;

    setUp(() {
      container = fixture('trivialList');
      list = container.list;
    });

    test('list size', () async {
      list.items = buildDataSet(100);
      await wait(1);
      expect(list.offsetWidth, 0);
      expect(list.offsetHeight, 0);
    });

    test('resize', () {
      var done = new Completer();
      list.items = buildDataSet(100);
      list.fire('resize');

      expect(getFirstItemFromList(list).text, isNot('0'));
      context['Polymer']['RenderStatus'].callMethod('whenReady', [() async {
        container.attributes.remove('hidden');

        expect(getFirstItemFromList(list).text, isNot('0'));
        list.fire('resize');
        await wait(1);

        expect(list.jsElement['isAttached'], isTrue);
        expect(getFirstItemFromList(list).text, '0');
        done.complete();
      }]);

      return done.future;
    });
  });
}
