@TestOn('browser')
library polymer_elements.test.paper_input_char_counter_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_input_char_counter.dart';
import 'package:polymer_elements/paper_textarea.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('character counter shows the value length', () {
      PaperInputContainer container = fixture('counter');
      InputElement input = Polymer.dom(container).querySelector('#i');
      PaperInputCharCounter counter =
          Polymer.dom(container).querySelector('#c');
      expect(counter.jsElement['_charCounterStr'], equals(input.value.length));
    });

    test('character counter shows the value length with maxlength', () {
      PaperInputContainer container = fixture('counter-with-max');
      InputElement input = Polymer.dom(container).querySelector('#i');
      PaperInputCharCounter counter =
          Polymer.dom(container).querySelector('#c');
      expect(counter.jsElement['_charCounterStr'],
          equals("${input.value.length}/${input.maxLength}"));
    });

    test('character counter shows the value length with maxlength', () {
      PaperTextarea input = fixture('textarea-with-max');
      forceXIfStamp(input);
      PaperInputCharCounter counter = Polymer
          .dom(input.jsElement['root'])
          .querySelector('paper-input-char-counter');
      expect(counter, isNotNull);
      expect(counter.jsElement['_charCounterStr'], equals(
          '${input.value.length}/' +
              '${input.inputElement.textarea.getAttribute('maxlength')}'));
    });

    test('character counter counts new lines in textareas correctly', () {
      PaperTextarea input = fixture('textarea');
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
