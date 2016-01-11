// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_card_test;

import 'package:polymer_elements/paper_card.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  PaperCard f;

  group('a11y', () {
    setUp(() {
      f = fixture('basic');
    });

    test('aria-label set on card', () {
      expect(f.getAttribute('aria-label'), equals(f.heading));
    });

    test('aria-label can be updated', () {
      expect(f.getAttribute('aria-label'), equals(f.heading));
      f.heading = 'batman';
      expect(f.getAttribute('aria-label'), equals('batman'));
    });
  });

  group('header image', () {
    var f, img;
    setUp(() {
      f = fixture('basic');
      img = f.querySelector('iron-image');
    });

    test('is iron-image', (){
      expect(img, isNotNull);
    });

    test('width properly setup', () {
      expect(img.offsetWidth, 0);
      f.image = 'some-img-url';
      expect(img.src, f.image);
      expect(img.offsetWidth, f.offsetWidth);
    });

    test('preload properly setup', () {
      expect(img.preload, f.preloadImage);
      f.preloadImage = !f.preloadImage;
      expect(img.preload, f.preloadImage);
    });

    test('fade properly setup', () {
      expect(img.fade, f.fadeImage);
      f.fadeImage = !f.fadeImage;
      expect(img.fade, f.fadeImage);
    });
  });
}
