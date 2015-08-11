@TestOn('browser')
library polymer_elements.test.google_sheets_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/google_sheets.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  GoogleSheets sheet = document.querySelector('#sheet1');

  group('<google-sheets>', () {
    test('basic', () {
      // Check defaults.
      expect(sheet.spreadsheets.length, 0,
          reason: '.spreadsheets length should default to 0');
      expect(sheet.rows.length, 0, reason: '.rows length should default to 0');
      expect(sheet.sheet, isNotNull, reason: '.sheet should default to {}');
      expect(sheet.tab, isNotNull, reason: '.tab should default to {}');

      expect(sheet.key, '', reason: ".key default is not ''");
      // TODO(jakemac): Confirm this is cruft.
      //expect(sheet.gid, 0, reason: '.gid default is not 0');
      expect(sheet.published, isFalse,
          reason: '.published does not default to false');
      expect(sheet.querySelector('google-signin-aware'), isNotNull,
          reason: 'google-signin-aware should be created for non-public sheet');
    });
  });
}
