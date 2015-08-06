@TestOn('browser')
library polymer_elements.test.platinum_sw_register_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/platinum_sw_register.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  PlatinumSwRegister element = querySelector('platinum-sw-register');
  JsObject serviceWorker = context['navigator']['serviceWorker'];

  if (serviceWorker == null) {
    group('Unsupported', () {
      test('state is properly set', () {
        expect(element.state, 'unsupported');
      });
    });
  } else {
    group('Supported', () {
      group('Registration & Installation', () {
        test('creates an active service worker', () async {
          var registration = await jsPromiseToFuture(serviceWorker['ready']);
          expect(registration['active'], isNotNull);
        });

        test('state is set to "installed"', () {
          expect(element.state, 'installed');
        });
      });
    });
  }
}
