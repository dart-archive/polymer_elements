// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_swipeable_container_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_swipeable_container.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';
import 'sinon/sinon.dart' as sinon;

@PolymerRegister('test-element')
class TestElement extends PolymerElement {
  TestElement.created() : super.created();
}

main() async {
  await initPolymer();

  group('native elements', () {
    test('dragging less than halfway does not swipe', () async {
      var container = fixture('basic');
      var element = container.querySelector('#native');

      await wait(1);
      var swipeEventHandler = sinon.spy();
      container.addEventListener('iron-swipe', swipeEventHandler.eventListener);

      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
      track(element, 10, 0);

      await wait(1);
      expect(swipeEventHandler.callCount, 0);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
    });

    test('dragging more than halfway swipes it', () async {
      var done = new Completer();
      var container = fixture('basic');
      var element = container.querySelector('#native');

      await wait(1);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);

      container.on['iron-swipe'].first.then((event) {
        expect(Polymer.dom(container).queryDistributedElements('*').length, 1);
        done.complete();
      });

      track(element, 60, 0);
      return done.future;
    }, skip: 'fails in test runner');

    test('an element with disable-swipe cannot be swiped', () async {
      var container = fixture('child-no-swipe');
      var element = container.querySelector('#native');

      await wait(1);
      var swipeEventHandler = sinon.spy();
      container.addEventListener('iron-swipe', swipeEventHandler.eventListener);

      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
      track(element, 60, 0); // this amount would normally swipe.

      await wait(1);
      expect(swipeEventHandler.callCount, 0);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
    });
  });

  group('custom elements', () {
    test('dragging less than halfway does not swipe', () async {
      var container = fixture('basic');
      var element = container.querySelector('#custom');

      var swipeEventHandler = sinon.spy();
      container.addEventListener('iron-swipe', swipeEventHandler.eventListener);

      await wait(1);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
      track(element, 10, 0);

      await wait(1);
      expect(swipeEventHandler.callCount, 0);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
    });

    test('dragging more than halfway swipes it', () async {
      var done = new Completer();
      var container = fixture('basic');
      var element = container.querySelector('#custom');

      await wait(1);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);

      container.on['iron-swipe'].first.then((event) {
        expect(Polymer.dom(container).queryDistributedElements('*').length, 1);
        done.complete();
      });

      track(element, 60, 0);
      return done.future;
    }, skip: 'fails in test runner');

    test('an element with disable-swipe cannot be swiped', () async {
      var container = fixture('child-no-swipe');
      var element = container.querySelector('#custom');

      await wait(1);
      var swipeEventHandler = sinon.spy();
      container.addEventListener('iron-swipe', swipeEventHandler.eventListener);

      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
      track(element, 60, 0); // this amount would normally swipe.

      await wait(1);
      expect(swipeEventHandler.callCount, 0);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
    });
  });

  group('no swipe', () {
    test('dragging a native element more than halfway does not swipe',
        () async {
      var container = fixture('no-swipe');
      var element = container.querySelector('#native');

      var swipeEventHandler = sinon.spy();
      container.addEventListener('iron-swipe', swipeEventHandler.eventListener);

      await wait(1);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
      track(element, 60, 0);

      await wait(1);
      expect(swipeEventHandler.callCount, 0);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
    });

    test('dragging a custom element more than halfway does not swipe',
        () async {
      var container = fixture('no-swipe');
      var element = container.querySelector('#custom');

      var swipeEventHandler = sinon.spy();
      container.addEventListener('iron-swipe', swipeEventHandler.eventListener);

      await wait(1);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
      track(element, 60, 0);

      await wait(1);
      expect(swipeEventHandler.callCount, 0);
      expect(Polymer.dom(container).queryDistributedElements('*').length, 2);
    });
  });
}
