// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_input_error_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'package:polymer_elements/paper_input_error.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  group('basic', () {
    test('error message only appears when input is invalid', () {
      var container = fixture('auto-validate-numbers');
      IronInput input = Polymer.dom(container).querySelector('#i');
      PaperInputError error = Polymer.dom(container).querySelector('#e');
      expect(error.getComputedStyle().visibility, equals('hidden'));
      input.bindValue = 'foobar';
      expect(error.getComputedStyle().visibility, isNot(equals('hidden')));
    });

    test('error message add on is registered', () {
      PaperInputContainer container = document.getElementById('container');
      expect(container.jsElement['_addons'], isNotNull);
      expect(container.jsElement['_addons'].length, equals(1));
    });
  });
}
