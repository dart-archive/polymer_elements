// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_form_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_form.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/simple_element.dart';

/// [SimpleElement] used.
main() async {
  await initPolymer();

  group('registration', () {
    IronForm f;
    test('elements can be registered', () {
      f = fixture('Basic');

      expect(f.jsElement['_customElements']['length'], 1);
      expect(f.jsElement['elements']['length'], 1);
    });

    test('elements can be unregistered', () {
      f = fixture('Basic');
      var element = f.querySelector('simple-element');

      expect(f.jsElement['_customElements']['length'], 1);
      expect(f.jsElement['elements']['length'], 1);

      f.children.remove(element);

      return wait(200).then((_) {
        expect(f.jsElement['_customElements']['length'], 0);
        expect(f.jsElement['elements']['length'], 1);
      });
    });
  });
  
  group('validation', () {
    test('elements are validated if they don\'t have a name', () {
      IronForm f = fixture('FormWithRequiredElements');
      expect(f.jsElement['_customElements'].length, 1);
      expect(f.jsElement['elements']['length'], 1);

      SimpleElement simpleElement = f.jsElement['_customElements'][0];
      InputElement input = f.jsElement['elements'][0];

      expect(f.validate(), isFalse);
      expect(simpleElement.invalid, isTrue);
      expect(input.validity.valid, isFalse);

      simpleElement.value = 'batman';
      input.value = 'robin';

      expect(f.validate(), isTrue);
      expect(simpleElement.invalid, isFalse);
      expect(input.validity.valid, isTrue);

      // Since the elements don't have names, they don't get serialized.
      var json = f.serialize();
      expect(context['Object'].callMethod('keys', [json]).length, 0);
    });

    test('elements are validated if they have a name', () {
      IronForm f = fixture('FormWithRequiredElements');
      expect(f.jsElement['_customElements'].length, 1);
      expect(f.jsElement['elements']['length'], 1);

      SimpleElement simpleElement = f.jsElement['_customElements'][0];
      InputElement input = f.jsElement['elements'][0];
      simpleElement.name = 'zig';
      input.name = 'zag';

      expect(f.validate(), isFalse);
      expect(simpleElement.invalid, isTrue);
      expect(input.validity.valid, isFalse);

      simpleElement.value = 'batman';
      input.value = 'robin';

      expect(f.validate(), isTrue);
      expect(simpleElement.invalid, isFalse);
      expect(input.validity.valid, isTrue);

      // The elements have names, so they're serialized.
      var json = f.serialize();
      expect(context['Object'].callMethod('keys', [json]).length, 2);
    });
  });

  group('serializing', () {
    IronForm f;
    test('serializes both custom and native elements', () {
      f = fixture('Basic');

      expect(f.jsElement['_customElements']['length'], 1);
      expect(f.jsElement['elements']['length'], 1);

      var json = f.serialize();
      expect(keysOf(json).length, 2);
      expect(json['zig'], 'zag');
      expect(json['foo'], 'bar');
    });

    test('serializes elements with duplicate names', () {
      f = fixture('Dupes');

      expect(f.jsElement['_customElements']['length'], 3);
      expect(f.jsElement['elements']['length'], 2);

      var json = f.serialize();
      expect(keysOf(json).length, 2);
      expect(json['foo']['length'], 2);
      expect(json['foo'][0], 'bar');
      expect(json['foo'][1], 'barbar');
      expect(json['zig']['length'], 3);
      expect(json['zig'][0], 'zig');
      expect(json['zig'][1], 'zag');
      expect(json['zig'][2], 'zug');
    });

    test('serializes elements with checked states', () {
      f = fixture('CheckedStates');

      expect(f.jsElement['_customElements']['length'], 0);
      expect(f.jsElement['elements']['length'], 4);

      var json = f.serialize();
      expect(keysOf(json).length, 1);
      expect(json['foo']['length'], 2);
      expect(json['foo'][0], 'bar1');
      expect(json['foo'][1], 'bar3');
    });

    test('does not serialize disabled elements', () {
      f = fixture('Disabled');

      expect(f.jsElement['_customElements']['length'], 0);
      expect(f.jsElement['elements']['length'], 3);

      var json = f.serialize();
      expect(keysOf(json).length, 1);
      expect(json['foo'], 'bar1');
    });
  });

  group('submitting', () {
    var form;

    test('does not submit forms with invalid native elements', () {
      var done = new Completer();
      form = fixture('InvalidForm');
      var nativeElement = form.querySelector('input');
      SimpleElement customElement = form.querySelector('simple-element');
      customElement.value = "foo";

      form.on['iron-form-submit'].take(1).listen((_) {
        throw 'Form should not be submitted!';
      });

      form.on['iron-form-invalid'].take(1).listen((_) {
        expect(nativeElement.validity.valid, isFalse);
        expect(customElement.invalid, isFalse);
        done.complete();
      });

      form.submit();
      return done.future;
    });

    test('can submit with method=get', () {
      var done = new Completer();
      form = fixture('FormGet');

      var submitted = false;
      form.on['iron-form-submit'].take(1).listen((_) {
        submitted = true;
      });

      form.on['iron-form-response'].take(1).listen((event) {
        expect(submitted, isTrue);

        var response = new JsObject.fromBrowserObject(event)['detail'];
        expect(response, isNotNull);
        expect(response is JsObject, isTrue);
        expect(response['success'], isTrue);
        done.complete();
      });

      form.submit();
      return done.future;
    });

    test('can submit with method=post', () {
      var done = new Completer();
      form = fixture('FormPost');

      var submitted = false;
      form.on['iron-form-submit'].take(1).listen((_) {
        submitted = true;
      });

      form.on['iron-form-response'].take(1).listen((event) {
        expect(submitted, isTrue);
        var response = event.detail;
        expect(response, isNotNull);
        expect(response is JsObject, isTrue);
        expect(response['success'], isTrue);
        done.complete();
      });

      form.submit();
      return done.future;
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/16');

    test('can relay errors', () {
      var done = new Completer();
      form = fixture('FormPost');
      form.action = "/responds_with_error";

      form.on['iron-form-error'].take(1).listen((event) {
        var error = convertToDart(event).detail;

        expect(error, isNotNull);
        expect(error is Map, isTrue);
        expect(error['error'], isNotNull);
        done.complete();
      });

      form.submit();
      return done.future;
    });
  });
}
