// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.google_chart_test;

import 'dart:async';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/platinum_push_messaging.dart';
import 'dart:html';

main() async {
  await initPolymer();

  PlatinumPushMessaging el = document.querySelector('platinum-push-messaging');

  suite('Element state', () {
    test('Default properties', () {
      $assert.isUndefined(el.subscription, 'subscription');
      $assert.isFalse(el.enabled, 'enabled');
      $assert.isFalse(el.supported, 'supported');
    },skip: "does this make sense on dartium?");

    testAsync('Enable does nothing', (done) async {
      await el.enable();
      $assert.isUndefined(el.subscription, 'subscription');
      $assert.isFalse(el.enabled, 'enabled');
      done();
    });

    testAsync('Disable does nothing', (done) async {
      await el.disable();
      $assert.isUndefined(el.subscription, 'subscription');
      $assert.isFalse(el.enabled, 'enabled');
      done();
    });
  });
}
