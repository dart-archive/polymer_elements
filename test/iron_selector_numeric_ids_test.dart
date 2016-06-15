// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_multi_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('select by a numeric property', () {
    IronSelector s;
    DomRepeat t;

    setUp(() {
      s = fixture('numeric_ids');
      t = new PolymerDom(s).querySelector("template[id='t']");
      t.items = [{ "id": 0, "name":'item0'}, {"id": 1, "name": 'item1'}, {"id": 2, "name": 'item2'}];
    });

    tearDown(() {
      t.items = [];
    });

    test('select a value of zero', () {
      t.render();
      s.selected = 1;
      expect(s.selected, 1);

      // select item with a name value of 0
      s.children[0].dispatchEvent(new CustomEvent('tap', canBubble: true));
      expect(s.selected, 0);
    });
  });
}
