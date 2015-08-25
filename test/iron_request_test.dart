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
  
    group('basic usage',  () {
      test('creates network requests, requiring only `url`',  () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response, isNotNull);
        });
      });
      test('sets async to true by default',  () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        expect(request.xhr['status'], 0);
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.xhr['status'], 200);
        });
      });
      test('can be aborted',  () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        request.abort();
        return jsPromiseToFuture(request.completes).then((_) {
          throw 'Request did not abort appropriately!';
        }).catchError((e) {
          expect(request.response, isNull);
        });
      });
      test('default responseType is text',  () {
        request.send(new JsObject.jsify(successfulRequestOptions));
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response is String, isTrue);
        }).catchError((e) {
          throw 'Response was not a Object';
        });
      });
      test('responseType can be configured via handleAs option',  () {
        var options = new Map.from(successfulRequestOptions);
        options['handleAs'] = 'json';
        request.send(new JsObject.jsify(options));
        return jsPromiseToFuture(request.completes).then((_) {
          expect(request.response is JsObject, isTrue);
        }).catchError((e) {
          throw 'Response was not type Object';
        });
      });
    });

    // TODO(jakemac): Tests for various status codes. We will need to mock out
    // the server for this though.
    // https://github.com/dart-lang/polymer_elements/issues/15
  });

}
