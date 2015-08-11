@TestOn('browser')
library polymer_elements.test.google_youtube_custom_thumbnail_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/google_youtube.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  GoogleYoutube googleYouTube = querySelector('google-youtube');

  group('<google-youtube> custom thumbnail', () {
    test('thumbnail image present', () {
      var img = googleYouTube.querySelector('img');
      expect(img, isNotNull,
          reason: 'thumbnail <img> is present.');
      expect(img.getComputedStyle().display, isNot('none'),
          reason: 'thumbnail <img> is visible.');
    });

    test('tap handler loads embed', () {
      var done = new Completer();
      googleYouTube.on['google-youtube-ready'].take(1).listen((e) {
        expect(googleYouTube.querySelector('img').getComputedStyle().display, 'none',
            reason: 'thumbnail <img> is no longer present.');

        expect(googleYouTube.querySelector('iframe'), isNotNull,
            reason: 'YouTube embed <iframe> is present.');

        done.complete();
      });

      // Trigger the on-tap handler.
      googleYouTube.jsElement.callMethod('_handleThumbnailTap');

      return done.future;
    });
  });
}
