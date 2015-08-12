@TestOn('browser')
library polymer_elements.test.google_calendar_list_basic_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/google_calendar.dart';
import 'package:polymer_elements/google_client_loader.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<google-calendar-list>', () {
    GoogleCalendarList cal;

    setUp(() {
      cal = fixture('basic');
    });

    test('can fetch calendars', () {
      var done = new Completer();

      // Fake user's sign in.
      var signin = cal.querySelector('google-signin-aware');
      signin.dispatchEvent(new Event('google-signin-aware-success'));

      // Run tests.
      cal.on['google-api-load'].take(1).listen((_) {
        var response = new JsObject.jsify({
          'items': [{
            'kind': 'calendar#calendarListEntry',
            'id': 'test_id',
            'summary': 'test summary',
            'description': 'test description',
            'timeZone': 'Asia/Calcutta',
            'backgroundColor': '#000'
          }],
        });

        var request = new JsObject.jsify({
          'execute': new JsFunction.withThis((_, callback) {
            callback.apply([response]);
          })
        });
        // Stub out calendar request call.
        var api = cal.$['calendar'].api;
        api['calendarList']['list'] = new JsFunction.withThis((_, __) {
          return request;
        });

        // Spoof being signed in.
        cal.jsElement['_signedIn'] = true;
        cal.displayCalendars();
        PolymerDom.flush();
        wait(1).then((_) {
          // Check if calendars get updated.
          expect(cal.calendars, response['items']);
          done.complete();
        });
      });

      return done.future;
    });
  });
}
