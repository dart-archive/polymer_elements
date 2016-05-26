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
import 'fixtures/element_with_nested_input.dart';
import 'fixtures/element_with_nested_form_element.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:polymer_elements/iron_request.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_textarea.dart';


/// [SimpleElement] used.
main() async {
  await initPolymer();

  group('registration', () {
    IronForm f;
    test('elements can be registered', () async {
      f = fixture('Basic');
      await new Future(() {});

      expect(f.jsElement['_customElements']['length'], 1);
      expect(f.jsElement['elements']['length'], 1);
    });

    test('elements can be unregistered', () async {
      f = fixture('Basic');
      await new Future(() {});
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
    test('custom elements are validated if they don\'t have a name', () async {
      IronForm f = fixture('FormWithRequiredCustomElements');
      await new Future(() {});
      expect(f.jsElement['_customElements'].length, 1);


      SimpleElement simpleElement = f.jsElement['_customElements'][0];

      expect(f.validate(), isFalse);
      expect(simpleElement.invalid, isTrue);

      simpleElement.value = 'batman';

      expect(f.validate(), isTrue);
      expect(simpleElement.invalid, isFalse);

      // Since the elements don't have names, they don't get serialized.
      var json = f.serialize();
      expect(context['Object'].callMethod('keys', [json]).length, 0);
    });

    test('native elements are validated if they don\'t have a name', () {
      IronForm f = fixture('FormWithRequiredElements');
      expect(f.jsElement['elements']['length'], 1);

      InputElement input = f.jsElement['elements'][0];

      expect(input.name, isEmpty);

      expect(f.validate(), isFalse);
      expect(input.validity.valid, isFalse);

      input.value = 'robin';

      expect(f.validate(), isTrue);
      expect(input.validity.valid, isTrue);

      // Since the elements don't have names, they don't get serialized.
      var json = f.serialize();
      expect(context['Object']
                 .callMethod('keys', [json])
                 .length, 0);
    });

    test('custom elements are validated if they have a name', () async {
      IronForm f = fixture('FormWithRequiredCustomElements');
      await new Future(() {});
      expect(f.jsElement['_customElements'].length, 1);

      SimpleElement simpleElement = f.jsElement['_customElements'][0];
      simpleElement.name = 'zig';

      expect(f.validate(), isFalse);
      expect(simpleElement.invalid, isTrue);

      simpleElement.value = 'batman';

      expect(f.validate(), isTrue);
      expect(simpleElement.invalid, isFalse);

      // The elements have names, so they're serialized.
      var json = f.serialize();
      expect(context['Object'].callMethod('keys', [json]).length, 1);
    });

    test('native elements are validated if they have a name', () async {
      IronForm f = fixture('FormWithRequiredElements');
      await new Future(() {});
      expect(f.jsElement['elements']['length'], 1);

      InputElement input = f.jsElement['elements'][0];
      input.name = 'zag';

      expect(f.validate(), isFalse);
      expect(input.validity.valid, isFalse);

      input.value = 'robin';

      expect(f.validate(), isTrue);
      expect(input.validity.valid, isTrue);

      // The elements have names, so they're serialized.
      var json = f.serialize();
      expect(context['Object'].callMethod('keys', [json]).length, 1);
    });
  });



  group('serializing', () {
    IronForm f;
    test('serializes both custom and native elements', () async {
      f = fixture('Basic');
      await new Future(() {});

      expect(f.jsElement['_customElements']['length'], 1);
      expect(f.jsElement['elements']['length'], 1);

      var json = f.serialize();
      expect(keysOf(json).length, 2);
      expect(json['zig'], 'zag');
      expect(json['foo'], 'bar');
    });

    test('serializes elements with duplicate names', () async {
      f = fixture('Dupes');
      await new Future(() {});

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

    test('serializes a native select element with or without multiple selection', () {
      IronForm f = fixture('NativeSelect');

      expect(f.jsElement['_customElements']['length'], 0);
      expect(f.jsElement['elements']['length'], 2);

      var json = f.serialize();
      expect(context["Object"].callMethod('keys', [json])["length"], 2);

      // Single selection.
      expect(json['cheese'], 'yes');

      // Multiple selection.
      expect(json['numbers'].length, 2);
      expect(json['numbers'][0], 'one');
      expect(json['numbers'][1], 'three');
    });

    test('does not serialize disabled elements', () {
      f = fixture('Disabled');

      expect(f.jsElement['_customElements']['length'], 0);
      expect(f.jsElement['elements']['length'], 3);

      var json = f.serialize();
      expect(keysOf(json).length, 1);
      expect(json['foo'], 'bar1');
    });

    test('nested elements are only serialized once', () {
      IronForm f = fixture('NestedDupes');

      expect(f.jsElement['_customElements']['length'], 3);

      var json = f.serialize();
      expect(context["Object"].callMethod('keys', [json])["length"], 2);
      expect(json['foo'], 'bar');
      expect(json['zig'], 'zag');
    });


    test('nested elements can be submitted if parents aren\'t submittable', () {
      IronForm f = fixture('NestedSubmittable');

      var json = f.serialize();
      expect(context["Object"].callMethod('keys', [json])["length"], 1);
      expect(json['foo'], 'bar');
    });
  });

  group('resetting', () {
    test('form restores the default values if changes were made', () {
      Completer done = new Completer();
      IronForm form = fixture('FormForResetting');

       // Initial values.
      SimpleElement customElement = form.querySelector('simple-element');
      var input = form.querySelector('input[name="foo"]');
      var checkbox1 = form.querySelectorAll('input[type="checkbox"]')[0];
      var checkbox2 = form.querySelectorAll('input[type="checkbox"]')[1];
      PaperInput paperInput = form.querySelector('paper-input');
      PaperTextarea paperTextarea = form.querySelector('paper-textarea');

      expect(customElement.value, 'zag');
      expect(input.value, 'bar');
      expect(checkbox1.checked, isTrue);
      expect(checkbox2.checked, isFalse);
      expect(paperInput.value, 'zug');
      expect(paperInput.inputElement.value, 'zug');
      expect(paperTextarea.value, 'zog');
      expect(paperTextarea.inputElement.textarea.value, 'zog');

      // Change the values.
      customElement.set("value", 'not zag');
      input.value = 'not bar';
      checkbox1.checked = false;
      checkbox2.checked = true;
      paperInput.value = 'not zug';
      paperTextarea.value = 'not zog';

      expect(customElement.value, 'not zag');
      expect(input.value, 'not bar');
      expect(checkbox1.checked, isFalse);
      expect(checkbox2.checked, isTrue);
      expect(paperInput.value, 'not zug');
      expect(paperInput.inputElement.value, 'not zug');
      expect(paperTextarea.value, 'not zog');
      expect(paperTextarea.inputElement.textarea.value, 'not zog');

      form.on['iron-form-reset'].take(1).listen((Event event) {
        // Restored initial values.
        expect(customElement.value, 'zag');
        expect(input.value, 'bar');
        expect(checkbox1.checked, isTrue);
        expect(checkbox2.checked, isFalse);
        expect(paperInput.value, 'zug');
        expect(paperInput.inputElement.value, 'zug');
        expect(paperTextarea.value, 'zog');
        expect(paperTextarea.inputElement.textarea.value, 'zog');
        done.complete();
      });

      form.reset();

      return done.future;
    });

    test('form restores the default values if no changes were made', () {
      Completer done = new Completer();
      IronForm form = fixture('FormForResetting');

      // Initial values.
      SimpleElement customElement = form.querySelector('simple-element');
      var input = form.querySelector('input[name="foo"]');
      var checkbox1 = form.querySelectorAll('input[type="checkbox"]')[0];
      var checkbox2 = form.querySelectorAll('input[type="checkbox"]')[1];
      PaperInput paperInput = form.querySelector('paper-input');
      PaperTextarea paperTextarea = form.querySelector('paper-textarea');

      expect(customElement.value, 'zag');
      expect(input.value, 'bar');
      expect(checkbox1.checked, isTrue);
      expect(checkbox2.checked, isFalse);
      expect(paperInput.value, 'zug');
      expect(paperInput.inputElement.value, 'zug');
      expect(paperTextarea.value, 'zog');
      expect(paperTextarea.inputElement.textarea.value, 'zog');

      form.on['iron-form-reset'].take(1).listen((Event event) {
        // Restored initial values.
        expect(customElement.value, 'zag');
        expect(input.value, 'bar');
        expect(checkbox1.checked, isTrue);
        expect(checkbox2.checked, isFalse);
        expect(paperInput.value, 'zug');
        expect(paperInput.inputElement.value, 'zug');
        expect(paperTextarea.value, 'zog');
        expect(paperTextarea.inputElement.textarea.value, 'zog');
        done.complete();
      });

      form.reset();

      return done.future;
    });

    test('validation messages are cleared', () {
      Completer done = new Completer();
      var form = fixture('FormWithRequiredCustomElements');

      SimpleElement customElement = form.querySelector('simple-element');

      expect(form.validate(), isFalse);
      expect(customElement.invalid, isTrue);

      form.on['iron-form-reset'].take(1).listen((Event event){
        // Cleared validation messages.
        expect(customElement.invalid, isFalse);
        done.complete();
      });

      form.reset();

      return done.future;
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

    test('can modify the request in the presubmit', () {
      Completer done = new Completer();
      form = fixture('FormGet');

      var submitted = false;
      var presubmitted = false;

      form.on['iron-form-submit'].take(1).listen((_) {
        submitted = true;
      });

      form.on['iron-form-presubmit'].take(1).listen((_) {
        presubmitted = true;
        form.request.params = {'batman': true};
      });

      form.on['iron-form-response'].take(1).listen((event) {
        event = convertToDart(event);
        expect(submitted, isTrue);
        expect(presubmitted, isTrue);

        // We have changed the json parameters
        var url = event.detail.xhr['responseURL'];
        expect(url, contains('batman=true'));

        var response = event.detail.response;
        expect(response, isNotNull);
        expect((response is JsObject), isTrue);
        expect(response['success'], isTrue);
        done.complete();
      });

      form.submit();
      //server.respond();
      return done.future;
    });

    test('can do a custom submission in the presubmit', () {
      Completer done = new Completer();
      form = fixture('FormGet');

      var presubmitted = false;

      // Since we are not using the normal form submission, these events should
      // never be called.
      int formResponseHandler_callCount = 0;
      form.on['iron-form-response'].take(1).listen((_) {
        formResponseHandler_callCount++;
      });
      int formSubmitHandler_callCount = 0;
      form.on['iron-form-submit'].take(1).listen((_) {
        formSubmitHandler_callCount++;
      });

      form.on['iron-form-presubmit'].take(1).listen((Event event) {
        presubmitted = true;
        event.preventDefault();

        // Your custom submission logic could go here (like using Firebase).
        // In this case, fire a custom event as a an example.
        form.fire('custom-form-submit');
      });

      form.on['custom-form-submit'].take(1).listen((Event event) {
        expect(presubmitted, isTrue);
        expect(formResponseHandler_callCount, 0);
        expect(formSubmitHandler_callCount, 0);
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
        var url = convertToDart(event).detail.xhr['responseURL'];
        expect(url, contains('zig=zag'));

        var response = convertToDart(event).detail.response;
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
        var response = convertToDart(event).detail.response;
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
