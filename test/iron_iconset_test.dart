// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_iconset_test;

import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_iconset.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

/// Used imports: [IronIconset]
main() async {
  await initWebComponents();

  group('<iron-iconset>', () {
    group('basic behavior', () {
      var iconset;
      var meta;

      setUp(() {
        var elements = fixture('TrivialIconset');
        iconset = elements[0];
        meta = elements[1];
      });

      test('it can be accessed via iron-meta', () {
        expect(meta.byKey('foo'), iconset);
      });

      test('it fires an iron-iconset-added event on the window', () {
        return window.on['iron-iconset-added'].first.then((ev) {
          ev = convertToDart(ev);
          expect(ev, isNotNull);
          expect(ev.detail, iconset);
        });
      });
    });
    group('when src, width, iconSize and icons are assigned', () {
      var iconset;
      var div;

      setUp(() {
        var elements = fixture('StandardIconset');
        iconset = elements[0];
        div = elements[1];
      });
      /*
      test('appends a child to the target element', () {
        expect(div.firstElementChild).to.not.be.ok;
        iconset.applyIcon(div, 'location');
        expect(div.firstElementChild).to.be.ok;
      });
  */
      test('sets the background image of the target element', () {
        var iconStyle;
        iconset.applyIcon(div, 'location', null, null);
        iconStyle = div.getComputedStyle();
        expect(iconStyle.backgroundImage,
            contains(new RegExp(r'''url\(.*demo\/my-icons.png["']?\)''')));
      });

      test('offsets the background image to the icon\'s position', () {
        var iconStyle;
        iconset.applyIcon(div, 'bus', null, null);
        iconStyle = div.getComputedStyle();
        expect(iconStyle.backgroundPosition,
            contains(new RegExp(r'0(px|%) -24px')));
      });
    });
    group('when an iconset is themed', () {
      var iconset;
      var div;

      setUp(() {
        var elements = fixture('ThemedIconset');
        iconset = elements[0];
        div = elements[1];
      });

      test('can use a theme when applying icon', () {
        iconset.applyIcon(div, 'bus', 'large', null);
        expect(div, isNotNull);
      });

      test('adjusts the icon by the theme offset', () {
        var iconStyle;
        iconset.applyIcon(div, 'bus', 'large', null);
        iconStyle = div.getComputedStyle();
        expect(
            iconStyle.backgroundPosition, contains(new RegExp(r'-10px -34px')));
      });
    });
  });
}
