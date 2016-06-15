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

  isHidden(element) {
    var rect = element.getBoundingClientRect();
    return (rect.width == 0 && rect.height == 0);
  }

  group('<paper-fab>', () {
    PaperFab f1;
    PaperFab f2;
    PaperFab f3;
    PaperFab f4;
    PaperFab f5;

    setUp(() {
      f1 = fixture('TrivialFab').querySelector('#fab1');
      f2 = fixture('SrcFab');
      f3 = fixture('icon-fab');
      f4 = fixture('icon-src-fab');
      f5 = fixture('label-fab');
    });

    test('applies an icon specified by the `icon` attribute', () {
      expect((f1.$['icon'] as IronIcon).jsElement['usesSrcAttribute'],isFalse);
      expect(Polymer.dom(f1.$['icon'].jsElement['root']).querySelector('svg'),
          isNotNull);
    });

    test('applies an icon specified by the `src` attribute', () {
      expect(f2.$['icon'].jsElement.callMethod('_usesIconset'), false);
      expect(f2.$['icon'].jsElement['_img'], isNotNull);
    });

    test('renders correctly independent of line height', () {
      expect(
          middleOfNode(f1.$['icon']).isApproximatelyEqualTo(middleOfNode(f1)),
          isTrue);
    });


    test('fab displays icon with `icon` and `label` attributes', when((done) async {
    await wait(1);
    var icon = f3.$$('iron-icon');
    var text = f3.$$('span');
    $expect(icon).not.to.be.$null;
    $assert.isFalse(isHidden(icon));
    $assert.isTrue(isHidden(text));
    $expect(icon.icon).to.be.equal(f3.icon);
    $expect(f3.getAttribute('aria-label')).to.be.equal(f3.label);
    done();

    }));

    test('fab displays icon with `src` and `label` attributes', when((done) async {
    await wait(1);
    var icon = f4.$$('iron-icon');
    var text = f4.$$('span');
    $expect(icon).not.to.be.$null;
    $assert.isFalse(isHidden(icon));
    $assert.isTrue(isHidden(text));
    $expect(icon.src).to.be.equal(f4.src);
    $expect(f4.getAttribute('aria-label')).to.be.equal(f4.label);
    done();

    }));

    test('fab displays label with `label` attribute correctly', when((done) async {
    await wait(1);
    var icon = f5.$$('iron-icon');
    var text = f5.$$('span');
    $expect(text).not.to.be.$null;
    $assert.isTrue(isHidden(icon));
    $assert.isFalse(isHidden(text));
    $expect(text.innerHtml).to.be.equal(f5.label);
    $expect(f5.getAttribute('aria-label')).to.be.equal(f5.label);
    done();
    }));

  });
}
