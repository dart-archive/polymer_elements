@TestOn('browser')
library polymer_elements.test.google_sheets_private_test;

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
  GoogleSheets sheet = document.querySelector('#sheet');

  group('<google-sheets>', () {
    test('private sheet', () {
      var done = new Completer();
      // Test set attributes.
      expect(sheet.key, '0AjqzxJ5RoRrWdGh2S0RRYURXTlNHdm9pQlFuM1ZwZWc',
          reason: ".key was not updated");
      // TODO(jakemac): Verify this is cruft.
      //  expect(sheet.gid, 1, reason: '.gid was not updated');
      expect(sheet.clientId,
          '750497606405-1hq66meqmr4dp09dn54j9ggv85vbv0gp.apps.googleusercontent.com',
          reason: ".clientId was not set");

      sheet.on['google-sheet-data'].take(1).listen((e) {
        switch (e.detail.type) {
          case 'spreadsheets':
            expect(sheet.spreadsheets.length, greaterThan(0),
                reason: '.spreadsheets should be populated for private feeds.');
            break;
          case 'tab':
            expect(sheet.tab['title'], 'SECONDTAB',
                reason: '.tab.title is incorrect');
            break;
          case 'rows':
            var authors = new JsObject.fromBrowserObject(sheet.rows)['authors'];
            expect(authors.length, 1, reason: '.rows.authors array');

            var name = authors[0]['name'];
            var email = authors[0]['email'];

            expect(email, 'webcomponents.test@gmail.com',
                reason: 'author email not set correctly');
            expect(name, 'webcomponents.test',
                reason: 'author name not set correctly');

            expect(sheet.rows[0]['title'][r'$t'], 'FIRST NAME',
                reason: '"name" column was incorrect');
            expect(sheet.rows[1][r'gsx$state'][r'$t'], 'OR',
                reason: '"state" column was incorrect');

            break;
          default:
          // Noop
        }

        done.complete();
      });

      sheet.on['error'].take(1).listen((e) {
        done.completeError(e);
      });
      return done.future;
    });
  }, skip: 'Must be ran manually.');
}
