// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_selected_attribute_test;

import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('selected attributes', () {
    IronSelector s;

    setUp(() {
      s = fixture('test');
    });

    test('custom selectedAttribute', () {
      // set selectedAttribute
      s.selectedAttribute = 'myattr';
      // check selected attribute (should not be there)
      expect(s.children[4].attributes.containsKey('myattr'), isFalse);
      // set selected
      s.selected = 4;
      // now selected attribute should be there
      expect(s.children[4].attributes.containsKey('myattr'), isTrue);
    });
  });
}
