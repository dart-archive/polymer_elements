// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_request_test;

import 'dart:js';
import 'package:polymer_elements/iron_request.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<iron-request>', () {
    var successfulRequestOptions;
    IronRequest request;

    setUp(() {
      request = fixture('TrivialRequest');
      successfulRequestOptions = {
        'url': 'fixtures/responds_to_get_with_json.json'
      };
    });

    group('basic usage', () {
      test('creates network requests, requiring only `url`', () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response, isNotNull);
        });
      });

      test('sets async to true by default', () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        expect(request.xhr['status'], 0);
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.xhr['status'], 200);
        });
      });

      test('can be aborted', () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        request.abort();
        return jsPromiseToFuture(request.completes).then((_) {
          throw 'Request did not abort appropriately!';
        }).catchError((e) {
          expect(request.response, isNull);
        });
      });

      test('default responseType is text', () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response is String, isTrue);
        }).catchError((e) {
          throw 'Response was not a Object';
        });
      });

      test('default responseType of text is not applied, when async is false',
            () async {
        var options = new Map.from(successfulRequestOptions);
        options['async'] = false;

        request.send(new JsObject.jsify(options));

        await jsPromiseToFuture(request.completes);
        expect(request.xhr['responseType'], isNull);
      }, skip: 'Failing due to setting timeout on non-async request?');

      test('responseType can be configured via handleAs option', () {
        var options = new Map.from(successfulRequestOptions);
        options['handleAs'] = 'json';
        request.send(new JsObject.jsify(options));
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response is JsObject, isTrue);
        }).catchError((e) {
          throw 'Response was not type Object';
        });
      });

      test('setting jsonPrefix correctly strips it from the response', () {
        var options = {
          'url': 'fixtures/responds_to_get_with_prefixed_json.json',
          'handleAs': 'json',
          'jsonPrefix': '])}while(1);</x>'
        };

        request.send(new JsObject.jsify(options));

        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response['success'], true);
        });
      });

      test('responseType cannot be configured via handleAs option, '
          'when async is false', () {
        var options = new Map.from(successfulRequestOptions);
        options['handleAs'] = 'json';
        options['async'] = false;

        request.send(new JsObject.jsify(options));

        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response is String, isTrue);
        });
      }, skip: 'Failing due to setting timeout on non-async request?');

      // TODO(jakemac): Port the 'headers are sent up' and
      // 'headers are deduped by lowercasing' tests once we can mock the server.
    });

    // TODO(jakemac): Tests for various status codes. We will need to mock out
    // the server for this though.
    // https://github.com/dart-lang/polymer_elements/issues/15
  });
}
