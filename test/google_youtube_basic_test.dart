@TestOn('browser')
library polymer_elements.test.google_youtube_basic_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/google_youtube.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

GoogleYoutube googleYouTube;

main() async {
  await initWebComponents();

  group('<google-youtube>', () {
    setUp(() {
      googleYouTube = fixture('basic');
    });

    test('ToHHMMSS', () {
      // Durations in seconds and the formatted string that's expected for each.
      var durationsToFormattedStrings = {
        0: '0:00',
        1: '0:01',
        '5.4': '0:05',
        '5.5': '0:06',
        10: '0:10',
        60: '1:00',
        601: '10:01',
        3600: '1:00:00',
        3661: '1:01:01',
        36000: '10:00:00'
      };

      durationsToFormattedStrings.keys.forEach((seconds) {
        expect(durationsToFormattedStrings[seconds],
            googleYouTube.jsElement.callMethod('_toHHMMSS', [seconds]));
      });
    });

    test('play and method state transitions', () {
      var done = new Completer();

      // Playback can't be initiated until after the google-youtube-ready event is fired.
      onReady(googleYouTube, ([_]) {
        // Expected state transitions: -1 (unstarted) -> 3 (buffering) -> 1 (playing)
        var stateTransitions = new JsArray.from([-1, 3, 1]);

        googleYouTube.on['google-youtube-state-change'].listen((e) {
          // Test that the element's state property always is set to the same property in the event.
          expect(eventDetail(e)['data'], googleYouTube.state);

          // Test that the player goes through the expected sequence of state transitions.
          expect(eventDetail(e)['data'], stateTransitions.removeAt(0));

          // Once the array of expected state transitions have been exhausted, end the test.
          if (stateTransitions.length == 0) {
            done.complete();
          }
        });

        // Kick off playback.
        googleYouTube.play();
      });
      return done.future;
    });
  });
}

void onReady(GoogleYoutube proxy, Function fn) {
  if (proxy.jsElement['_player'] == true) {
    fn();
  } else {
    proxy.on['google-youtube-ready'].take(1).listen(fn);
  }
}
