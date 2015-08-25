// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_meta_basic_test;

import 'package:polymer_elements/iron_meta.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronMeta meta;

    test('byKey', () {
      var meta = new IronMeta();
      expect(meta.byKey('info'), 'foo/bar');
    });

    test('list', () {
      var meta = new IronMeta();
      expect(meta.list.length, 1);
    });
  });
}
