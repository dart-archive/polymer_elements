@TestOn('browser')
library polymer_elements.test.paper_spinner_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_spinner.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-spinner>', () {
    group('an accessible paper spinner', () {
      PaperSpinner spinner;
      setUp(() {
        spinner = fixture('PaperSpinner');
      });
      test('adds an ARIA label when `alt` is supplied', () {
        var ALT_TEXT = 'Loading the next gif...';
        spinner.alt = ALT_TEXT;
        expect(spinner.attributes['aria-label'], equals(ALT_TEXT));
      });
      test('hides from ARIA when inactive', () {
        spinner.active = false;
        expect(spinner.attributes['aria-hidden'], equals('true'));
      });
    });
  });
}
