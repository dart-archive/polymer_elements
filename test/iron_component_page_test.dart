// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_component_page_test;

import 'package:polymer_elements/iron_component_page.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('active-state', () {
    IronComponentPage testElement;
    setUp(() {
      testElement = fixture('basic');
    });

    test('basic', () {
      expect(testElement is IronComponentPage, isTrue);
    });
  });
}

