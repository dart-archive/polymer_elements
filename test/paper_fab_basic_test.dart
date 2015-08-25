// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_fab_basic_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/paper_fab.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_icons.dart' as iron_icons;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initWebComponents();

  group('<paper-fab>', () {
    PaperFab f1;
    PaperFab f2;

    setUp(() {
      f1 = fixture('TrivialFab').querySelector('#fab1');
      f2 = fixture('SrcFab');
    });

    test('applies an icon specified by the `icon` attribute', () {
      expect(f1.src, isEmpty);
      expect(Polymer.dom(f1.$['icon'].jsElement['root']).querySelector('svg'),
          isNotNull);
    });

    test('applies an icon specified by the `src` attribute', () {
      expect(f2.$['icon'].jsElement.callMethod('_usesIconset'), false);
      expect(f2.$['icon'].jsElement['_img'], isNotNull);
    });


    test('renders correctly independent of line height', () {
      expect(middleOfNode(f1.$['icon']).isApproximatelyEqualTo(middleOfNode(f1)), isTrue);
    });
  });
}
