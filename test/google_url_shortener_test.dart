// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.google_url_shortener_test;

import 'dart:async';
import 'package:polymer_elements/google_url_shortener.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  GoogleUrlShortener shortener;

  group('<google-url-shortener>', () {
    setUp(() {
      shortener = fixture('shortener');
    });

    test('fires google-url-shortener-ready event', () {
      var done = new Completer();
      shortener.on['google-url-shortener-ready'].take(1).listen((event) {
        expect(event.detail, isNotNull);
        done.complete();
      });
      return done.future;
    });

    test('specified property has the correct values', () {
      expect(shortener.longUrl, isNotNull);
      expect(shortener.longUrl, 'https://www.google.com');
    });

    test('fires google-url-shorten event for shorten call', () {
      var done = new Completer();
      shortener.on['google-url-shorten'].take(1).listen((event) {
        var detail = event.detail;
        expect(detail, isNotNull);
        expect(detail['shortUrl'], isNotNull);
        done.complete();
      });
      shortener.shorten();
      return done.future;
    }, skip: 'Flaky due to unauthenticated use limits');

    test('fires google-url-shorten-error event for bad URL', () {
      var done = new Completer();
      shortener.on['google-url-shorten-error'].take(1).listen((event) {
        var detail = event.detail;
        expect(detail, isNotNull);
        expect(detail['error'], isNotNull);
        done.complete();
      });
      shortener.longUrl = 'invalid value...';
      shortener.shorten();
      return done.future;
    });
  });
}
