// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_badge_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_badge.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('badge is positioned correctly', () async {
      DivElement f = fixture('basic');
      await new Future(() {});
      PaperBadge badge = f.querySelector('paper-badge');
      HtmlElement actualbadge = new PolymerDom(badge.root).querySelector('.badge');
      expect(badge.target.getAttribute('id'), 'target');
      badge.updatePosition();

      await wait(1);
      expect(actualbadge.text.trim(), '1');

      Rectangle divRect = f.querySelector('#target').getBoundingClientRect();
      expect(divRect.width, equals(100));
      expect(divRect.height, equals(20));

      Rectangle contentRect = badge.getBoundingClientRect();
      expect(contentRect.width, equals(20));
      expect(contentRect.height, equals(20));
      // The target div is 100 x 20, and the badge is centered on the
      // top right corner.
      expect(contentRect.left, equals(100 - 10));
      expect(contentRect.top, equals(0 - 10));
      // Also check the math, just in case.
      expect(contentRect.left, equals(divRect.width - 10));
      expect(contentRect.top, equals(divRect.top - 10));
    });

    test('badge is positioned correctly after initially being hidden', when((done) {
      var f = fixture('initially-hidden');
      PaperBadge badge = f.querySelector('paper-badge');
      DivElement actualbadge = Polymer.dom(badge.root).querySelector('.badge');

      $expect(badge.target.getAttribute('id')).to.be.equal('target');

      // Badge is initially hidden.
      var contentRect = badge.getBoundingClientRect();
      $expect(contentRect.width).to.be.equal(0);
      $expect(contentRect.height).to.be.equal(0);

      badge.attributes.remove('hidden');

      $async(() {
        $assert.equal(actualbadge.text.trim(), "1");

        Rectangle divRect = f.querySelector('#target').getBoundingClientRect();
        $expect(divRect.width).to.be.equal(100);
        $expect(divRect.height).to.be.equal(20);

        contentRect = badge.getBoundingClientRect();
        $expect(contentRect.width).to.be.equal(20);
        $expect(contentRect.height).to.be.equal(20);

        // The target div is 100 x 20, and the badge is centered on the
        // top right corner.
        $expect(contentRect.left).to.be.equal(100 - 10);
        $expect(contentRect.top).to.be.equal(0 - 10);

        // Also check the math, just in case.
        $expect(contentRect.left).to.be.equal(divRect.width - 10);
        $expect(contentRect.top).to.be.equal(divRect.top - 10);

        done();
      });
    }));

    test('badge is positioned correctly after being dynamically set', () async {
      DivElement f = fixture('dynamic');
      await new Future(() {});
      PaperBadge badge = f.querySelector('paper-badge');
      badge.updatePosition();

      expect(badge.target.getAttribute('id'), isNot('target'));

      Completer done = new Completer();

      await wait(1);
      Rectangle contentRect = badge.getBoundingClientRect();
      expect(contentRect.left, isNot(100 - 11));
      badge.forId = 'target';
      expect(badge.target.getAttribute('id'), 'target');
      badge.updatePosition();

      await wait(1);
      Rectangle divRect = f.querySelector('#target').getBoundingClientRect();
      expect(divRect.width, equals(100));
      expect(divRect.height, equals(20));

      contentRect = badge.getBoundingClientRect();
      expect(contentRect.width, equals(20));
      expect(contentRect.height, equals(20));
      // The target div is 100 x 20, and the badge is centered on the
      // top right corner.
      expect(contentRect.left, equals(100 - 10));
      expect(contentRect.top, equals(0 - 10));
      // Also check the math, just in case.
      expect(contentRect.left, equals(divRect.width - 10));
      expect(contentRect.top, equals(divRect.top - 10));
    });
  });

  test('badge is positioned correctly when nested in a target element', () async {
    var f = fixture('nested');
    await new Future(() {});
    var badge = f.querySelector('paper-badge');

    expect(badge.target.getAttribute('id'), 'target');

    badge.updatePosition();

    await wait(1);
    var divRect = f.querySelector('#target').getBoundingClientRect();
    expect(divRect.width, 100);
    expect(divRect.height, 20);

    var contentRect = badge.getBoundingClientRect();
    expect(contentRect.width, 20);
    expect(contentRect.height, 20);

    // The target div is 100 x 20, and the badge is centered on the
    // top right corner.
    expect(contentRect.left, 100 - 10);
    expect(contentRect.top, 0 - 10);

    // Also check the math, just in case.
    expect(contentRect.left, divRect.width - 10);
    expect(contentRect.top, divRect.top - 10);
  });

  test('badge displays icons correctly', () async {
    var f = fixture('icon-badge');
    var badge = f.querySelector('paper-badge');

    await wait(1);
    var icon = new PolymerDom(badge.root).querySelector('iron-icon') as IronIcon;
    expect(icon, isNotNull);
    expect(icon.icon, badge.icon);
    expect(badge.getAttribute('aria-label'), badge.label);
  });

  group('badge is inside a custom element', () {
    test('badge is positioned correctly', () async {
      HtmlElement f = fixture('custom');
      await new Future(() {});

      PaperBadge badge = f.querySelector('paper-badge');
      HtmlElement actualbadge = new PolymerDom(badge.root).querySelector('.badge');
      badge.updatePosition();

      await wait(1);
      expect(actualbadge.text.trim(), '1');
      Rectangle divRect = f.querySelector("#button").getBoundingClientRect();
      expect(divRect.width, equals(100));
      expect(divRect.height, equals(20));

      Rectangle contentRect = badge.getBoundingClientRect();
      expect(contentRect.width, equals(20));
      expect(contentRect.height, equals(20));
      // The target div is 100 x 20, and the badge is centered on the
      // top right corner.
      expect(contentRect.left, equals(100 - 10));
      expect(contentRect.top, equals(0 - 10));
      // Also check the math, just in case.
      expect(contentRect.left, equals(divRect.width - 10));
      expect(contentRect.top, equals(divRect.top - 10));
    });
  });
}
