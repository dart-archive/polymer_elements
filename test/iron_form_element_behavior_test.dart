// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_form_element_behavior_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_form_element_behavior.dart';
import 'package:test/test.dart';

import 'sinon/sinon.dart' as sinon;
import 'common.dart';

main() async {
  await initPolymer();

  group('basic', () {
    SimpleForm form;

    setUp(() {
      form = fixture('basic');
    });

    test('elements fire an event when attached', () async {
      var element = document.createElement('input', 'simple-element');

      int count = 0;
      var subscription = form.on['iron-form-element-register'].listen((_) {
        count++;
      });

      form.append(element);
      await wait(1);
      expect(count, 1);

      subscription.cancel();
    });

    test('elements fire an event when detached', () async {
      SimpleElement element = document.createElement('input', 'simple-element');
      form.append(element);
      element.jsElement['_parentForm'] = form;

      int count = 0;
      var subscription = form.on['iron-form-element-unregister'].listen((_) {
        count++;
      });

      element.remove();
      await wait(1);
      expect(count, 1);

      subscription.cancel();
    });
  });
}

@PolymerRegister('simple-element', extendsTag: 'input')
class SimpleElement extends InputElement
    with PolymerMixin, PolymerBase, IronFormElementBehavior {
  SimpleElement.created() : super.created() {
    polymerCreated();
  }
}

@PolymerRegister('simple-form', extendsTag: 'form')
class SimpleForm extends FormElement with PolymerMixin, PolymerBase {
  SimpleForm.created() : super.created() {
    polymerCreated();
  }
}
