@TestOn('browser')
library polymer_elements.test.paper_dialog_test;

import 'dart:async';
import 'package:polymer_elements/paper_dialog.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('a11y', () {
    test('dialog has role="dialog"', () {
      PaperDialog dialog = fixture('basic');
      expect(dialog.getAttribute('role'), equals('dialog'),
          reason: 'should be role="dialog"');
    });
  });
}
