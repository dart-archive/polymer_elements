// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_menu_button_test;

import 'dart:html';
import 'dart:js';
import 'dart:async';
import 'package:polymer_elements/paper_menu_button.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-menu-button>', () {
    PaperMenuButton menuButton;
    SpanElement trigger;
    SpanElement content;

    setUp(() {
      menuButton = fixture('TrivialMenuButton');
      trigger = menuButton.querySelector('span.dropdown-trigger');
      content = menuButton.querySelector('span.dropdown-content');
    });

    test('opens when trigger is clicked', () {
      Completer done = new Completer();

      Rectangle contentRect = content.getBoundingClientRect();
      expect(contentRect.width, equals(0));
      expect(contentRect.height, equals(0));

      tap(trigger);

      wait(1).then((_) {
        contentRect = content.getBoundingClientRect();
        expect(menuButton.opened, isTrue);
        expect(contentRect.width, greaterThan(0));
        expect(contentRect.height, greaterThan(0));
        done.complete();
      });

      return done.future;
    });

    test('closes when trigger is clicked again', () async {
      tap(trigger);

      await wait(100);
      tap(trigger);

      await wait(context['Polymer']['PaperMenuButton']['MAX_ANIMATION_TIME_MS']);
      Rectangle contentRect = content.getBoundingClientRect();
      expect(menuButton.opened, isFalse);
      expect(contentRect.width, equals(0));
      expect(contentRect.height, equals(0));
    }, skip: 'failing on the js side');

    test('closes when disabled while open', () {
      Rectangle contentRect;

      menuButton.opened = true;
      menuButton.disabled = true;
      expect(menuButton.opened, isFalse);

      contentRect = content.getBoundingClientRect();
      expect(contentRect.width, equals(0));
      expect(contentRect.height, equals(0));
    });

    test('has aria-haspopup attribute', () {
      expect(menuButton.getAttribute('aria-haspopup'), isNotNull);
    });
  });
}
