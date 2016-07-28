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

  // Not registered or subscribed to start
  // Register worker
  // Get a subscription
  // Trigger a push? Hard to test...
  PlatinumPushMessaging el = document.querySelector('platinum-push-messaging');

  suite('Element state', () {
    setup(when((done) {
      // Beginning state should be disabled
      el.disable().then((_)=>done(),onError:(_)=> done());
    }));

    test('Default properties', () {
      $assert.isUndefined(el.subscription, 'subscription');
      $assert.isFalse(el.enabled, 'enabled');
      $assert.isTrue(el.supported, 'supported');
    });

    testAsync('No worker registered', (done) {
      jsPromiseToFuture(el.jsElement.callMethod('_getRegistration')).then((registration) {
        $assert.isUndefined(registration);
      }).then((_) => done(), onError: (_) => done());
    });

    testAsync('Enable', (done) {
      el.enable().then((_) {
        expect(el.subscription,new  isInstanceOf<PushSubscription>(), reason:'subscription');
        $assert.isTrue(el.enabled, 'enabled');
      }).then((_) => done(), onError:(_) => done());
    });

    testAsync('Disable', (done) {
      el.disable().then((_) {
        $assert.isUndefined(el.subscription, 'subscription');
        $assert.isFalse(el.enabled, 'enabled');
      }).then((_) => done(), onError:(_) => done());
    });
  });
}
