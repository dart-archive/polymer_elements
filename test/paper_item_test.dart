// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_item_test;

import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_icon_item.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'sinon/sinon.dart' as sinon;

main() async {
  await initWebComponents();

  group('paper-item basic', () {
    PaperItem item;
    sinon.Spy clickHandler;

    setUp(() {
      item = fixture('item').querySelector('paper-item');
      clickHandler = sinon.spy();
      item.addEventListener('click', clickHandler.eventListener);
    });

    test('space triggers a click event', () async {
      pressSpace(item);
      await wait(1);
      // You need two ticks, one for the MockInteractions event, and one
      // for the button event.
      await wait(1);
      expect(clickHandler.callCount, 1);
    });

    test('click triggers a click event', () async {
      tap(item);
      await wait(1);
      expect(clickHandler.callCount, 1);
    });
  });

  group('paper-icon-item basic', () {
    PaperIconItem item;
    sinon.Spy clickHandler;

    setUp(() {
      item = fixture('iconItem').querySelector('paper-icon-item');
      clickHandler = sinon.spy();
      item.addEventListener('click', clickHandler.eventListener);
    });

    test('space triggers a click event', () async {
      pressSpace(item);
      await wait(1);
      // You need two ticks, one for the MockInteractions event, and one
      // for the button event.
      await wait(1);
      expect(clickHandler.callCount, 1);
    });

    test('enter triggers a click event', when((done) {
      pressEnter(item);
      $async(() {
        // You need two ticks, one for the MockInteractions event, and one
        // for the button event.
        $async(() {
          $expect(clickHandler.callCount).to.be.equal(1);
          done();
        }, 1);
      }, 1);
    }));
  });

  group('clickable element inside item', () {
    test('paper-item: space in child native input does not trigger a click event', () async {
      var f = fixture('item-with-input');
      var outerItem = f.querySelector('paper-item');
      var innerInput = f.querySelector('input');

      var itemClickHandler = sinon.spy();
      outerItem.addEventListener('click', itemClickHandler.eventListener);

      innerInput.focus();
      pressSpace(innerInput);
      await wait(1);
      expect(itemClickHandler.callCount, 0);
    });

    test('paper-item: space in child paper-input does not trigger a click event', () async {
      var f = fixture('item-with-paper-input');
      var outerItem = f.querySelector('paper-item');
      var innerInput = f.querySelector('paper-input');

      var itemClickHandler = sinon.spy();
      outerItem.addEventListener('click', itemClickHandler.eventListener);

      innerInput.focus();
      pressSpace(innerInput);
      await wait(1);
      expect(itemClickHandler.callCount, 0);
    });

    test('paper-icon-item: space in child input does not trigger a click event', () async {
      var f = fixture('iconItem-with-input');
      var outerItem = f.querySelector('paper-icon-item');
      var innerInput = f.querySelector('input');

      var itemClickHandler = sinon.spy();
      outerItem.addEventListener('click', itemClickHandler.eventListener);

      pressSpace(innerInput);
      await wait(1);
      expect(itemClickHandler.callCount, 0);
    });
  });

  group('item a11y tests', () {
    PaperItem item;
    PaperIconItem iconItem;
    setUp(() {
      item = fixture('item').querySelector('paper-item');
      iconItem = fixture('iconItem').querySelector('paper-icon-item');
    });

    test('item has role="listitem"', () {
      expect(item.attributes['role'], equals('option'), reason: 'should have role="item"');
    });

    test('icon item has role="listitem"', () {
      expect(iconItem.getAttribute('role'), equals('option'), reason: 'should have role="item"');
    });

    // TODO(jakemac): Investigate these
    // a11ygroup('item');
    // a11ygroup('iconItem');
  });
}
