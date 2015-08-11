@TestOn('browser')
library polymer_elements.test.google_sheets_published_test;

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
  GoogleSheets sheet;

  group('<google-sheets>', () {
    setUp(() {
      sheet = fixture('sheet');
    });

    test('published', () {
      var done = new Completer();
      expect(sheet.published, isTrue);
      expect(sheet.querySelector('google-signin-aware'), isNull,
          reason:
              'google-signin-aware should not be created for a published sheet');

      sheet.on['google-sheet-data'].take(1).listen((e) {
        if (eventDetail(e)['type'] == 'tab') {
          expect(sheet.tab['title'], 'Locations',
              reason: 'Published spreadsheet title is not correct.');
          expect(sheet.tab['updated'], isNotNull,
              reason: '.tab.updated was not set');
          expect(sheet.tab['authors'].length > 0, isTrue,
              reason: '.tab.authors was 0');
        } else if (eventDetail(e)['type'] == 'rows') {
          expect(sheet.spreadsheets.length, 0,
              reason:
                  '.spreadsheets length should be 0 since spreadsheet key was given');
          expect(sheet.rows.length, greaterThan(0),
              reason: '.rows was not populated');
        }

        expect(sheet.$['cellrowsajax'].url, '',
            reason:
                '#cellrowsajax should not be invoked for a public spreadsheet');

        done.complete();
      });

      return done.future;
    });
  });
}
