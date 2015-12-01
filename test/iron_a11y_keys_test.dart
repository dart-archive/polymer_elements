// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_a11y_keys_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_a11y_keys.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<iron-a11y-keys>', () {
    IronA11yKeys keys;

    setUp(() {
      keys = fixture('basic');
    });

    test('target is parentNode by default', () async {
      await wait(1);
      expect(keys.target, keys.parentNode);
    });

    group('keys attribute', () {
      test('causes an event listener to be added', () async {
        var done = new Completer();
        keys.keys = 'space';

        keys.addEventListener('keys-pressed', (_) {
          done.complete();
        });

        await new Future(() {});
        pressSpace(keys.parentNode);

        return done.future;
      });

      test('will not trigger events for non-specified keys', () async {
        var keysPressedCount = 0;

        keys.keys = 'space';

        keys.addEventListener('keys-pressed', (_) {
          keysPressedCount++;
        });

        await new Future(() {});
        pressSpace(keys.parentNode);
        pressEnter(keys.parentNode);

        expect(keysPressedCount, 1);
      });

      test('triggers events for space separated keys', () async {
        var keysPressed = '';

        keys.keys = 'a b c';

        keys.addEventListener('keys-pressed', (event) {
          keysPressed += new JsObject.fromBrowserObject(event)['detail']['key'];
        });

        await new Future(() {});
        pressAndReleaseKeyOn(keys.parentNode, 65);
        pressAndReleaseKeyOn(keys.parentNode, 66);
        pressAndReleaseKeyOn(keys.parentNode, 67);

        expect(keysPressed, 'abc');
      });
    });

    group('event listeners', () {
      test('listeners are only active when element is in document', () async {
        var keysPressedCount = 0;
        var parent = keys.parentNode;

        keys.keys = 'space';

        keys.addEventListener('keys-pressed', (_) {
          keysPressedCount++;
        });

        await new Future(() {});
        pressSpace(parent);
        expect(keysPressedCount, 1);

        (keys.parentNode as Element).children.remove(keys);
        flushAsynchronousOperations();

        pressSpace(parent);
        expect(keysPressedCount, 1);

        parent.append(keys);
        flushAsynchronousOperations();

        pressSpace(parent);
        expect(keysPressedCount, 2);
      });
    });
  });
}
