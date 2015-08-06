@TestOn('browser')
library polymer_elements.test.platinum_push_messaging_test;

import 'dart:html';
import 'package:polymer_elements/platinum_push_messaging.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  PlatinumPushMessaging element =
      document.querySelector('platinum-push-messaging');

  if (element.supported) {
    group('Supported', () {
      setUp(() async {
        await jsPromiseToFuture(element.disable());
      });

      test('Default properties', () {
        expect(element.subscription, isNull);
        expect(element.enabled, isFalse);
        expect(element.supported, isTrue);
      });

      test('No worker registered', () async {
        var registration = await jsPromiseToFuture(
            element.jsElement.callMethod('_getRegistration'));
        expect(registration, isNull);
      });

      test('Enable', () async {
        await jsPromiseToFuture(element.enable());
        expect(element.enabled, isTrue);
        expect(element.subscription, isNotNull);
      }, skip: 'https://github.com/dart-lang/sdk/issues/22862');
    });
  } else {
    group('Unsupported', () {
      test('Default properties', () {
        expect(element.subscription, isNull);
        expect(element.enabled, isFalse);
        expect(element.supported, isFalse);
      });

      test('Enable does nothing', () async {
        await jsPromiseToFuture(element.enable());
        expect(element.subscription, isNull);
        expect(element.enabled, isFalse);
      });

      test('Disable does nothing', () async {
        await jsPromiseToFuture(element.disable());
        expect(element.subscription, isNull);
        expect(element.enabled, isFalse);
      });
    });
  }
}
