/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_youtube_demo.html')
library polymer_elements_demo.web.google_youtube.google_youtube_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_youtube.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [DemoElements],
@PolymerRegister('google-youtube-demo')
class GoogleYoutubeDemo extends PolymerElement {
  GoogleYoutubeDemo.created() : super.created();

  @property bool playSupported;
  @property int state;
  @property int currentTime;
  @property String currentTimeFormatted;
  @property num duration;
  @property String durationFormatted;
  @property num fractionLoaded;
  @property List events = [];

  GoogleYoutube get _youTube => $['googleYouTube'];

  @reflectable
  double computeProgress(int currentTime, num duration) => currentTime / duration;

  @reflectable
  bool computePlayDisabled(int state, bool playSupported) =>
      state == 1 || state == 3 || !playSupported;

  @reflectable
  bool computePauseDisabled(int state) => state != 1 && state != 3;

  @reflectable
  handleStateChange(dom.CustomEvent event, [_]) =>
      add('events', {'data': event.detail['data']});

  @reflectable
  void handleYouTubeError(dom.CustomEvent event, [_]) {
    print('YouTube playback error');
    dom.window.console.error(event.detail);
  }

  @reflectable
  handlePlayVideo([_, __]) => _youTube.play();

  @reflectable
  handlePauseVideo([_, __]) => _youTube.pause();

  @reflectable
  handleCueVideo([_, __]) => _youTube.videoId = $['videoId'].value;
}
