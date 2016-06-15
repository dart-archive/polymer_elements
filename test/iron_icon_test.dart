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

    group('when loading async', () {
      test('will get icon after iconset is added', () {
        var icon = fixture('UsingAsyncIconset');
        expect(hasIcon(icon), isFalse);

        var done = window.on['iron-iconset-added'].first.then((_) {
          expect(hasIcon(icon), isTrue,
              reason: 'icon didn\'t load after iconset loaded');
        });
        fixture('AsyncIconset');

        return done;
      });
    });

    group('when switching between src and icon properties', () {
      var icon;

      setUp(() {
        var elements = fixture('IconFromIconset');
        icon = elements[1];
      });

      test('will display the icon if both icon and src are set', () {
        icon.src = '../demo/location.png';
        icon.icon = 'example:location';
        expect(hasIcon(icon), isTrue);
        expect(iconElementFor(icon), isNull);

        // Check if it works too it we change the affectation order
        icon.icon = 'example:location';
        icon.src = '../demo/location.png';
        expect(hasIcon(icon), isTrue);
        expect(iconElementFor(icon), isNull);
      });

      test('will display the icon when src is defined first and then reset', () {
        icon.src = '../demo/location.png';
        icon.icon = null;
        icon.src = null;
        icon.icon = 'example:location';
        expect(hasIcon(icon), isTrue);
        expect(iconElementFor(icon), isNull);
      });

      test('will display the src when icon is defined first and then reset', () {
        icon.src = null;
        icon.icon = 'example:location';
        icon.src = '../demo/location.png';
        icon.icon = null;
        expect(hasIcon(icon), isFalse);
        expect(iconElementFor(icon), isNotNull);
      });

      test('will display nothing if both properties are unset', () {
        icon.src = '../demo/location.png';
        icon.icon = 'example:location';
        icon.src = null;
        icon.icon = null;
        expect(hasIcon(icon), isFalse);
        expect(iconElementFor(icon), isNull);
      });
    });
    group('ancestor direct updates', () {
      test('handle properties set before ready', () {
        var holder = fixture('ParentForceUpdate');
      });
    });


  });
}
