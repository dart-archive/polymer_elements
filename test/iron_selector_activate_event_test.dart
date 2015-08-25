// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_selector_activate_event_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('activate event', () {
    IronSelector s;

    setUp( () {
      s = fixture('test');
    });

    test('activates on tap', () {
      expect(s.selected, '0');

      // select Item 1
      s.children[1].dispatchEvent(new CustomEvent('tap', canBubble: true));
      expect(s.selected, 1);
    });

    test('activates on tap and fires iron-activate', () {
      var done = new Completer();
      expect(s.selected, '0');

      // attach iron-activate listener
      s.on['iron-activate'].take(1).listen((event) {
        expect(eventDetail(event)['selected'], 1);
        expect(eventDetail(event)['item'], s.children[1]);
        done.complete();
      });

      // select Item 1
      s.children[1].dispatchEvent(new CustomEvent('tap', canBubble: true));
      return done.future;
    });

    test('tap on already selected and fires iron-activate', () {
      var done = new Completer();
      expect(s.selected, '0');

      // attach iron-activate listener
      s.on['iron-activate'].take(1).listen((event) {
        expect(eventDetail(event)['selected'], 0);
        expect(eventDetail(event)['item'], s.children[0]);
        done.complete();
      });

      // select Item 0
      s.children[0].dispatchEvent(new CustomEvent('tap', canBubble: true));
      return done.future;
    });

    test('activates on mousedown', () {
      // set activateEvent to mousedown
      s.activateEvent = 'mousedown';
      // select Item 2
      s.children[2].dispatchEvent(new CustomEvent('mousedown', canBubble: true));
      expect(s.selected, 2);
    });

    test('activates on mousedown and fires iron-activate', () {
      var done = new Completer();
      // attach iron-activate listener
      s.on['iron-activate'].take(1).listen((event) {
        expect(eventDetail(event)['selected'], 2);
        expect(eventDetail(event)['item'], s.children[2]);
        done.complete();
      });

      // set activateEvent to mousedown
      s.activateEvent = 'mousedown';
      // select Item 2
      s.children[2].dispatchEvent(new CustomEvent('mousedown', canBubble: true));
      return done.future;
    });

    test('no activation', () {
      expect(s.selected, '0');
      // set activateEvent to null
      s.activateEvent = null;
      // select Item 2
      s.children[2].dispatchEvent(new CustomEvent('mousedown', canBubble: true));
      expect(s.selected, '0');
    });

    test('activates on tap and preventDefault', () {
      // attach iron-activate listener
      s.on['iron-activate'].take(1).listen((event) {
        event.preventDefault();
      });
      // select Item 2
      s.children[2].dispatchEvent(new CustomEvent('tap', canBubble: true));
      // shouldn't got selected since we preventDefault in iron-activate
      expect(s.selected, '0');
    });

  });
}
