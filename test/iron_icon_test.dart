// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_icon_test;

import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_iconset.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

/// Used imports: [IronIcon], [IronIconset]
iconElementFor(node) {
  node = node is Element ? node = new JsObject.fromBrowserObject(node) : node;
  var nodes = Polymer.dom(node['root']).childNodes;
  for (var i = 0; i < nodes.length; ++i) {
    if (nodes[i].nodeName.contains(new RegExp(r'DIV|IMG'))) {
      return nodes[i];
    }
  }
}

bool hasIcon(Element node) {
  return new RegExp(r'png').hasMatch(node.style.backgroundImage);
}

main() async {
  await initWebComponents();
  group('<iron-icon>', () {
    group('basic behavior', () {
      var icon;
      setUp(() {
        icon = fixture('TrivialIcon');
      });

      test('can be assigned an icon with the src attribute', () {
        expect(iconElementFor(icon), isNotNull);
        expect(iconElementFor(icon).src,
            contains(new RegExp(r'demo\/location\.png')));
      });

      test('can change its src dynamically', () {
        icon.src = 'foo.png';
        expect(iconElementFor(icon).src, contains(new RegExp(r'foo\.png')));
      });
    });

    group('when paired with an iconset', () {
      var icon;
      setUp(() {
        var elements = fixture('IconFromIconset');
        icon = elements[1];
      });

      test('can be assigned an icon from the iconset', () {
        expect(hasIcon(icon), isTrue);
      });

      test('can change its icon dynamically', () {
        var style = icon.style;
        expect(
            style.backgroundPosition, contains(new RegExp(r'0(%|px) 0(%|px)')));
        icon.icon = "example:blank";
        expect(
            style.backgroundPosition, contains(new RegExp(r'-24px 0(%|px)')));
      });
    });
    group('when no icon source is provided', () {
      test('will politely wait for an icon source without throwing', () {
        document.createElement('iron-icon');
        fixture('WithoutAnIconSource');
      });
    });
  });
}
