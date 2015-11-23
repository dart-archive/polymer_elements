// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_input_char_counter_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_input_char_counter.dart';
import 'package:polymer_elements/paper_textarea.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'common.dart';

/// Used imports: [PaperInput]
main() async {
  await initWebComponents();

  group('basic', () {
    test('character counter shows the value length', () async {
      PaperInputContainer container = fixture('counter');
      await new Future(() {});
      InputElement input = Polymer.dom(container).querySelector('#i');
      PaperInputCharCounter counter =
          Polymer.dom(container).querySelector('#c');
      expect(counter.jsElement['_charCounterStr'], equals(input.value.length));
    });

    test('character counter shows the value length with maxlength', () async {
      PaperInputContainer container = fixture('counter-with-max');
      await new Future(() {});
      InputElement input = Polymer.dom(container).querySelector('#i');
      PaperInputCharCounter counter =
          Polymer.dom(container).querySelector('#c');
      expect(counter.jsElement['_charCounterStr'],
          equals("${input.value.length}/${input.maxLength}"));
    });

    test('character counter shows the value length with maxlength', () async {
      PaperTextarea input = fixture('textarea-with-max');
      await new Future(() {});
      forceXIfStamp(input);
      PaperInputCharCounter counter = Polymer
          .dom(input.jsElement['root'])
          .querySelector('paper-input-char-counter');
      expect(counter, isNotNull);
      expect(counter.jsElement['_charCounterStr'], equals(
          '${input.value.length}/' +
              '${input.inputElement.textarea.getAttribute('maxlength')}'));
    });

    test('character counter counts new lines in textareas correctly', () async {
      PaperTextarea input = fixture('textarea');
      await new Future(() {});
      input.value = 'foo\nbar';
      forceXIfStamp(input);
      PaperInputCharCounter counter = Polymer
          .dom(input.jsElement['root'])
          .querySelector('paper-input-char-counter');
      expect(counter, isNotNull);
      // A new line counts as two characters.
      expect(
          counter.jsElement['_charCounterStr'], equals(input.value.length + 1));
    });
  });
}
