// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_ajax_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/iron_request.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
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
        expect(keys.length, 0);
      });
    });

    // TODO(jakemac): update this once we can actually spy on requests
    group('when url isn\'t set yet', () {
      test('we don\'t fire any automatic requests', () {
        ajax = fixture('BlankUrl');

        return wait(1).then((_) {
          // Explicitly asking for the request to fire works.
          ajax.generateRequest();

          // Explicitly setting url to '' works too.
          ajax = fixture('BlankUrl');
          ajax.url = '';
          return wait(1);
        });
      });
    });

    group('when properties are changed', () {
      test('generates simple-request elements that reflect the change', () {
        var done = new Completer();

        ajax.on['request'].take(1).listen((event) {
          expect(
              new JsObject.fromBrowserObject(event)['detail']['options']
                  ['method'],
              'GET');

          ajax.method = 'POST';
          ajax.url = 'fixtures/responds_to_post_with_json.json';

          // If we don't do this inside a future, then the outer stream isn't
          // cancelled yet and it gets called twice. Possible sdk bug, or
          // working as intended?
          new Future(() {}).then((_) {
            ajax.on['request'].take(1).listen((event) {
              expect(
                  new JsObject.fromBrowserObject(event)['detail']['options']
                      ['method'],
                  'POST');
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
      test('yields an iron-request instance', () {
        expect(ajax.generateRequest() is IronRequest, isTrue);
      });

      test('correctly adds params to a URL that already has some', () {
        ajax.url += '?a=b';
        ajax.params = {'c': 'd'};
        expect(ajax.requestUrl,
            'fixtures/responds_to_get_with_json.json?a=b&c=d');
      });

      test('encodes params properly', () {
        ajax.params = {'a b,c': 'd e f'};

        expect(ajax.queryString, 'a%20b%2Cc=d%20e%20f');
      });

      test('encodes array params properly', () {
        ajax.params = {'a b': ['c','d e', 'f']};

        expect(ajax.queryString, 'a%20b=c&a%20b=d%20e&a%20b=f');
      });

      test('reflects the loading state in the `loading` property', () {
        IronRequest request = ajax.generateRequest();

        expect(ajax.loading, true);

        return jsPromiseToFuture(request.completes)
            .then((_) => wait(1))
            .then((_) {
          expect(ajax.loading, false);
        });
      });
    });

    group('when there are multiple requests', () {
      List<IronRequest> requests;
      IronAjax echoAjax;
      Future allRequestsDone;

      setUp(() {
        echoAjax = fixture('GetEcho');
        requests = <IronRequest>[];

        for (var i = 0; i < 3; ++i) {
          echoAjax.params = {'order': i + 1};
          requests.add(ajax.generateRequest());
        }
        allRequestsDone =
            Future.wait(requests.map((r) => jsPromiseToFuture(r.completes)));
      });

      test('holds all requests in the `activeRequests` Array', () async {
        expect(requests, ajax.activeRequests);
      });

      test('empties `activeRequests` when requests are completed', () async {
        expect(ajax.activeRequests.length, 3);
        await allRequestsDone;
        await wait(1);
        expect(ajax.activeRequests.length, 0);
      });

      // TODO(jakemac): add 'avoids race conditions with last response' and
      // '`loading` is true while the last one is loading' tests once we can
      // mock server responses.
    });

    group('when params are changed', () {
      test('generates a request that reflects the change', () {
        ajax = fixture('ParamsGet');
        var done = new Completer();

        ajax.on['request'].take(1).listen((event) {
          expect(convertToDart(event).detail['options']['url'],
              'fixtures/responds_to_get_with_json.json?a=a');

          // If we don't do this inside a future, then the outer stream isn't
          // cancelled yet and it gets called twice.
          new Future(() {}).then((_) {
            ajax.on['request'].take(1).listen((event) {
              expect(convertToDart(event).detail['options']['url'],
                  'fixtures/responds_to_get_with_json.json?b=b');
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
        ajax.on['request'].take(1).listen((_) async {
          await ajax.on['response'].first;
          ajax.on['request'].take(1).listen((_) {
            done.complete();
          });
          ajax.set('params.foo', 'xyz');
        });
        ajax.params = {'foo': 'bar'};
        return done.future;
      });

      test('does not send requests if url is not a string', () {
        ajax.on['request'].take(1).listen((_) {
          throw 'A request was generated but url is null!';
        });

        ajax.url = null;
        ajax.handleAs = 'text';

        return wait(1);
      });

      test('deduplicates multiple changes to a single request', () {
        var done = new Completer();

        ajax.on['response'].take(1).listen((_) {
          expect(ajax.activeRequests.length, 1);
          done.complete();
        });

        ajax.handleAs = 'text';
        ajax.params = {'foo': 'bar'};
        ajax.headers = {'X-Foo': 'Bar'};
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
          var options = new JsObject.fromBrowserObject(event)['detail']
              ['options'];
          expect(options['body'], requestBody);
          expect(request.xhr['status'], 200);
          done.complete();
        });

        ajax.body = requestBody;
        request = ajax.generateRequest();

        return done.future;
      });

      test('if `contentType` is set to form encode, the body is encoded', () {
        ajax.body = {'foo': 'bar\nbip', 'biz bo': 'baz blar'};
        ajax.contentType = 'application/x-www-form-urlencoded';
        IronRequest request = ajax.generateRequest();

        // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/16
        // expect(server.requests[0], isNotNull);
        // expect(server.requests[0].requestBody,
        //    'foo=bar%0D%0Abip&biz+bo=baz+blar');
      });

      test('if `contentType` is json, the body is json encoded', () {
        var requestObj = {
          'foo': 'bar',
          'baz': [1, 2, 3]
        };
        ajax.body = requestObj;
        ajax.contentType = 'application/json';
        ajax.generateRequest();

        // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/16
        // expect(server.requests[0], isNotNull);
        // expect(server.requests[0].requestBody,
        //     JSON.encode(requestObj));
      });

      group('the examples in the documentation work', () {
        test('json content, body attribute is an object', () {
          ajax.setAttribute('body', '{"foo": "bar baz", "x": 1}');
          ajax.contentType = 'application/json';
          ajax.generateRequest();

          // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/16
          // expect(server.requests[0], isNotNull);
          // expect(server.requests[0].requestBody,
          //     '{"foo":"bar baz","x":1}');
        });

        test('form content, body attribute is an object', () {
          ajax.setAttribute('body', '{"foo": "bar baz", "x": 1}');
          ajax.contentType = 'application/x-www-form-urlencoded';
          ajax.generateRequest();

          // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/16
          // expect(server.requests[0], isNotNull);
          // expect(server.requests[0].requestBody,
          //     'foo=barbaz&x=1');
        });
      });

      group('and `contentType` is explicitly set to form encode', () {
        test('we encode a custom object', () {
          var requestObj = new Foo('baz');
          ajax.body = requestObj;
          ajax.contentType = 'application/x-www-form-urlencoded';
          ajax.generateRequest();

          // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/16
          // expect(server.requests[0], isNotNull);
          // expect(server.requests[0].requestBody, 'bar=baz');
        }, skip: 'https://github.com/dart-lang/polymer-dart/issues/618');
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
        ajax.jsElement.callMethod('_requestOptionsChanged');
        ajax.jsElement.callMethod('_requestOptionsChanged');
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
        responseHandler = (_) {
          callCount++;
        };
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
      test('response type is string', () {
        ajax.url = 'fixtures/responds_to_get_with_json.json';
        ajax.handleAs = 'text';

        request = ajax.generateRequest();
        return jsPromiseToFuture(request.completes).then((_) {
          expect(ajax.lastResponse is String, isTrue);
        });
      });
    });

    group('when a request fails', () {
      test('we give an error with useful details', () {
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
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/14');

      test('we give a useful error even when the domain doesn\'t resolve', () async {
        ajax.url = 'http://nonexistant.example.com/';
        var eventFired = false;
        ajax.on['error'].take(1).listen((event) {
          event = convertToDart(event);
          expect(event.detail['request'], isNotNull);
          expect(event.detail['error'], isNotNull);
          eventFired = true;
        });
        var request = ajax.generateRequest();
        return jsPromiseToFuture(request.completes).then((_) {
          throw 'Expected the request to fail!';
        }, onError: (error) {
          expect(request.succeeded, isFalse);
          expect(error, isNotNull);
          return wait(100);
        }).then((_) {
          expect(eventFired, isTrue);
          expect(ajax.lastError, isNotNull);
        });
      });
    });

    group('when handleAs parameter is `json`', () {
      test('response type is string', () async {
        ajax.url = 'fixtures/responds_to_get_with_json.json';
        ajax.handleAs = 'json';

        request = ajax.generateRequest();
        await jsPromiseToFuture(request.completes);
        expect(ajax.lastResponse, isNotNull);
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

    group('when making a POST over the wire', () {
      IronAjax ajax;

      setUp(() {
        ajax = fixture('RealPost');
      });

      test('FormData is handled correctly', () {
        var requestBody = new FormData();
        requestBody.append('a', 'foo');
        requestBody.append('b', 'bar');

        ajax.body = requestBody;
        return jsPromiseToFuture(ajax.generateRequest().completes).then((_) {
          expect(ajax.lastResponse['headers']['Content-Type'],
              matches(r'^multipart/form-data; boundary=.*$'));

          expect(ajax.lastResponse['form']['a'], 'foo');
          expect(ajax.lastResponse['form']['b'], 'bar');
        });
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/82');

      test('json is handled correctly', () {
        ajax.body = JSON.encode({'a': 'foo', 'b': 'bar'});
        ajax.contentType = 'application/json';
        return jsPromiseToFuture(ajax.generateRequest().completes).then((_) {
          expect(ajax.lastResponse['headers']['Content-Type'],
              matches(r'^application\/json(;.*)?$'));
          expect(ajax.lastResponse['json']['a'], 'foo');
          expect(ajax.lastResponse['json']['b'], 'bar');
        });
      });

      test('urlencoded data is handled correctly', () {
        ajax.body = 'a=foo&b=bar';
        return jsPromiseToFuture(ajax.generateRequest().completes).then((_) {
          expect(ajax.lastResponse['headers']['Content-Type'],
              matches(r'^application/x-www-form-urlencoded(;.*)?$'));

          expect(ajax.lastResponse['form']['a'], 'foo');
          expect(ajax.lastResponse['form']['b'], 'bar');
        });
      });

      test('xml is handled correctly', () {
        var xmlDoc = document.implementation.createDocument(null, "foo", null);
        var node = xmlDoc.createElement("bar");
        node.setAttribute("name", "baz");
        xmlDoc.documentElement.append(node);
        ajax.body = xmlDoc;
        return jsPromiseToFuture(ajax.generateRequest().completes).then((_) {
          expect(ajax.lastResponse['headers']['Content-Type'],
              matches(r'^application\/xml(;.*)?$'));
          expect(ajax.lastResponse['data'],
              matches(r'<foo\s*><bar\s+name="baz"\s*\/><\/foo\s*>'));
        });
      });
    });

    group('when setting timeout', () {
      test('it is present in the request xhr object',  () {
        ajax.url = 'responds_to_get_with_json.json';
        ajax.timeout = 5000; // 5 Seconds

        request = ajax.generateRequest();
        expect(request.xhr['timeout'], 5000); // 5 Seconds
      });

      test('it fails once that timeout is reached',  () {
        var ajax = fixture('Delay');
        ajax.timeout = 1; // 1 Millisecond

        request = ajax.generateRequest();
        return jsPromiseToFuture(request.completes).then((_) {
          throw 'Expected the request to throw an error.';
        }, onError: (_) {
          expect(request.succeeded, isFalse);
          expect(request.xhr['status'], 0);
          expect(request.timedOut, isTrue);
          return wait(1);
        }).then((_) {
          expect(ajax.loading, isFalse);
          expect(ajax.lastResponse, isNull);
          expect(ajax.lastError, isNotNull);
        });
      });
    });
  });
}

class Foo extends JsProxy {
  @reflectable
  String bar;

  Foo(this.bar);
}
