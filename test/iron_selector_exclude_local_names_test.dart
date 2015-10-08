// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_exclude_local_names_test;

import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('exclude local names', () {
    IronSelector test1;
    IronSelector test2;

    setUp(() {
      test1 = fixture('test1');
      test2 = fixture('test2');
    });

    test('default `excludedLocalNames`', () {
      expect(test1.excludedLocalNames['template'], isNotNull);
      expect(test2.excludedLocalNames['template'], isNotNull);
    });

    test('custom `excludedLocalNames`', () {
      test1.excludedLocalNames['foo'] = 1;
      expect(test1.excludedLocalNames['foo'], isNotNull);
      expect(test2.excludedLocalNames['foo'], isNull);
    });

    test('items', () {
      test1.excludedLocalNames['span'] = 1;
      test2.excludedLocalNames['div'] = 1;

      var NOT_FOUND = -1;
      var items1 = test1.items.map((el) => el.localName);
      var items2 = test2.items.map((el) => el.localName);

      expect(items1.contains('span'), isFalse);
      expect(items2.contains('div'), isFalse);
    });
  });
}
