// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_ajax_test;

import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/iron_request.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<iron-ajax>', () {
    IronAjax ajax;
    IronRequest request;

    setUp(() {
      ajax = fixture('TrivialGet');
    });

    group('when making simple GET requests for JSON', () {
      test('has sane defaults that love you', () {
        request = ajax.generateRequest();
        var done = new Completer();

        ajax.on['response'].take(1).listen((_) {
          expect(request.response, isNotNull);
          expect(request.response['success'], isTrue);
          done.complete();
        });

        return done.future;
      });

      test('will be asynchronous by default', () {
        expect(ajax.toRequestOptions()['async'], isTrue);
      });
    });

    group('when setting custom headers', () {
      test('are present in the request headers', () {
        ajax.headers['custom-header'] = 'valid';
        JsObject options = ajax.toRequestOptions();

        expect(options['headers'], isNotNull);
        expect(options['headers']['custom-header'] is String, isTrue);
        expect(options['headers'].hasProperty('custom-header'), isTrue);
      });

      test('non-objects in headers are not applied', () {
        ajax.headers = 'invalid';
        JsObject options = ajax.toRequestOptions();
        var keys = context['Object'].callMethod('keys', [options['headers']]);
        expect(keys.length, 1);
      });
    });

    group('when properties are changed', () {
      test('generates simple-request elements that reflect the change', () {
        var done = new Completer();

        ajax.on['request'].take(1).listen((event) {
          expect(new JsObject.fromBrowserObject(event)['detail']['options']['method'], 'GET');

          ajax.method = 'POST';
          ajax.url = 'fixtures/responds_to_post_with_json.json';

          // If we don't do this inside a future, then the outer stream isn't
          // cancelled yet and it gets called twice. Possible sdk bug, or
          // working as intended?
          new Future(() {}).then((_) {
            ajax.on['request'].take(1).listen((event) {
              expect(new JsObject.fromBrowserObject(event)['detail']['options']['method'], 'POST');
              done.complete();
            });

            request = ajax.generateRequest();
          });
        });

        request = ajax.generateRequest();

        return done.future;
      });
    });

    group('when generating a request', () {
      test('yields a iron-request instance', () {
        expect(ajax.generateRequest() is IronRequest, isTrue);
      });
    });

    group('when there are multiple requests', () {
      var requests;

      setUp(() {
        requests = <IronRequest>[];

        for (var i = 0; i < 3; ++i) {
          requests.add(ajax.generateRequest());
        }
      });

      test('holds all requests in the `activeRequests` Array', () {
        expect(requests, ajax.activeRequests);
      });
    });

    group('when params are changed', () {
      test('generates a request that reflects the change', () {
        ajax = fixture('ParamsGet');
        var done = new Completer();

        ajax.on['request'].take(1).listen((event) {
          expect(new JsObject.fromBrowserObject(event)['detail']['options']['url'], 'fixtures/responds_to_get_with_json.json?a=a');

          // If we don't do this inside a future, then the outer stream isn't
          // cancelled yet and it gets called twice.
          new Future(() {}).then((_) {
            ajax.on['request'].take(1).listen((event) {
              expect(new JsObject.fromBrowserObject(event)['detail']['options']['url'], 'fixtures/responds_to_get_with_json.json?b=b');
              done.complete();
            });

            ajax.params = {'b': 'b'};
            request = ajax.generateRequest();
          });
        });

        request = ajax.generateRequest();
        return done.future;
      });
    });

    group('when `auto` is enabled', () {
      setUp(() {
        ajax = fixture('AutoGet');
      });

      test('automatically generates new requests', () {
        var done = new Completer();
        ajax.on['request'].take(1).listen((_) {
          done.complete();
        });
        return done.future;
      });

      test('does not send requests if url is not a string', () {
        ajax.on['request'].take(1).listen((_) {
          throw 'A request was generated but url is null!';
        });

        ajax.url = null;
        ajax.handleAs = 'text';

        return new Future(() {});
      });

      test('deduplicates multiple changes to a single request', () {
        var done = new Completer();

        ajax.on['response'].take(1).listen((_) {
          expect(ajax.activeRequests.length, 1);
          done.complete();
        });

        ajax.handleAs = 'text';
        ajax.params = { 'foo': 'bar' };
        ajax.headers = { 'X-Foo': 'Bar' };
        return done.future;
      });
    });

    group('the last response', () {
      setUp(() {
        request = ajax.generateRequest();
      });

      test('is accessible as a readonly property', () async {
        await jsPromiseToFuture(request.completes);
        expect(ajax.lastResponse, request.response);
      });


      test('updates with each new response', () async {
        await jsPromiseToFuture(request.completes);

        expect(request.response, isNotNull);
        expect(ajax.lastResponse, request.response);

        ajax.handleAs = 'text';
        request = ajax.generateRequest();

        await jsPromiseToFuture(request.completes);

        expect(request.response is String, isTrue);
        expect(ajax.lastResponse, request.response);
      });
    });

    group('when making POST requests', () {
      setUp(() {
        ajax = fixture('TrivialPost');
      });

      test('POSTs the value of the `body` attribute', () {
        var requestBody = JSON.encode({'foo': 'bar'});
        var done = new Completer();

        ajax.on['request'].take(1).listen((event) {
          var options =
              new JsObject.fromBrowserObject(event)['detail']['options'];
          expect(options['body'], requestBody);
          expect(request.xhr['status'], 200);
          done.complete();
        });

        ajax.body = requestBody;
        request = ajax.generateRequest();

        return done.future;
      });
    });

    group('when debouncing requests', () {
      setUp(() {
        ajax = fixture('DebouncedGet');
      });

      test('only requests a single resource', () {
        var done = new Completer();
        var timesCalled = 0;
        ajax.on['request'].take(2).listen((_) {
          timesCalled++;
        });
        ajax.requestOptionsChanged();
        ajax.requestOptionsChanged();
        new Future.delayed(new Duration(milliseconds: 200), () {
          expect(timesCalled, 1);
          done.complete();
        });
        return done.future;
      });
    });

    group('when a response handler is bound', () {
      var responseHandler;
      var callCount;

      setUp(() {
        callCount = 0;
        responseHandler = (_) { callCount++; };
        ajax.on['response'].listen(responseHandler);
      });

      test('calls the handler after every response', () {
        ajax.generateRequest();
        ajax.generateRequest();

        return jsPromiseToFuture(ajax.lastRequest.completes).then((_) {
          expect(callCount, 2);
        });
      });
    });

    group('when the response type is `json`', () {
      test('finds the JSON on any platform', () {
        request = ajax.generateRequest();
        return jsPromiseToFuture(request.completes).then((_) {
          expect(ajax.lastResponse, isNotNull);
        });
      });
    });

    group('when handleAs parameter is `text`', () {
      test('response type is string',  () {
        ajax.url = 'fixtures/responds_to_get_with_json.json';
        ajax.handleAs = 'text';

        request = ajax.generateRequest();
        return jsPromiseToFuture(request.completes).then((_) {
          expect(ajax.lastResponse is String, isTrue);
        });
      });
    });

    group('when a request fails', () {
      test('the error event has useful details', () {
        var done = new Completer();

        ajax.on['error'].take(1).listen((event) {
          var detail = new JsObject.fromBrowserObject(event)['detail'];
          expect(detail['request'], isNotNull);
          expect(detail['error'], isNotNull);
          done.complete();
        });

        ajax.on['response'].take(1).listen((event) {
          throw 'response event should not be fired';
        });

        ajax.url = 'fixtures/responds_to_get_with_text.txt';
        ajax.handleAs = 'json';
        var request = ajax.generateRequest();

        return done.future;
      });
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/14');

    group('when handleAs parameter is `json`', () {

      test('response type is string',  () {
        var done = new Completer();
        ajax.url = 'fixtures/responds_to_get_with_json.json';
        ajax.handleAs = 'json';

        request = ajax.generateRequest();
        jsPromiseToFuture(request.completes).then((_) {
          expect(ajax.lastResponse, isNotNull);
          done.complete();
        });

        return done.future;
      });

      test('fails when getting invalid json data', () {
        var done = new Completer();

        ajax.url = '/responds_to_get_with_text';
        ajax.handleAs = 'json';

        request = ajax.generateRequest();
        jsPromiseToFuture(request.completes).catchError((e) {
          expect(e, isNotNull);
          done.complete();
        });

        return done.future;
      });

    });

  });

}
