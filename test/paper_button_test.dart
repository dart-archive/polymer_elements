// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_button_test;

import 'dart:async';
import 'package:polymer_elements/paper_button.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-button>', () {
    PaperButton button;
    setUp(() async {
      button = fixture('TrivialButton');
      await new Future(() {});
    });

    test('can be raised imperatively', () {
      Completer done = new Completer();
      button.raised = true;
      expect(button.getAttribute('raised'), isNotNull);
      wait(1).then((_) {
        try {
          expect(button.elevation, equals(1));
          done.complete();
        } catch (e) {
          done.complete(e);
        }
      });
    });

    test('can be disabled imperatively', () {
      button.disabled = true;
      expect(button.getAttribute('aria-disabled'), equals('true'));
      expect(button.getAttribute('disabled'), isNotNull);
    });

    test('can be triggered with space', () {
      Completer done = new Completer();
      button.addEventListener('click', (_) {
        done.complete();
      });
      pressSpace(button);

      return done.future;
    });

    test('can be triggered with enter', () {
      Completer done = new Completer();
      button.addEventListener('click', (_) {
        done.complete();
      });
      pressEnter(button);

      return done.future;
    });
  });

  group('<paper-button>', () {
    var button;

    setUp(() {
      button = fixture('TrivialButton');
    });

    test('has aria role "button"', () {
      expect(button.getAttribute('role'), 'button');
    });

    // TODO(jakemac): What is this?
    // a11ySuite('TrivialButton');
  });
}
