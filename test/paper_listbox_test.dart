// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_listbox_test;

import 'package:polymer_elements/paper_listbox.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'dart:async';
import 'dart:html';

main() async {
  await initWebComponents();

  group('<paper-listbox>', () {
    PaperListbox listbox;

    setUp(() {
      listbox = fixture('basic');
    });

    test('selected item has an appropriate className', () async {
      await wait(1);
      expect(listbox.selectedItem.classes, contains('iron-selected'));
    });

    test('has listbox aria role', () {
      expect(listbox.getAttribute('role'), 'listbox');
    });
  });
}
