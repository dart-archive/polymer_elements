/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_castable_video_demo.html')
library polymer_elements_demo.web.google_castable_video.google_castable_video_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_castable_video.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleCastableVideo], [DemoElements],
@PolymerRegister('google-castable-video-demo')
class GoogleCastableVideoDemo extends PolymerElement {
  GoogleCastableVideoDemo.created() : super.created();

  @property String progress = '0';
  @property bool isPlaying = false;

  GoogleCastableVideo get _video => $['video'];

  @property String castButtonCaption = 'START CASTING';

  @reflectable
  void play([_, __]) {
    _video.play(null);
    set('isPlaying', true);
  }

  @reflectable
  void pause([_, __]) {
    _video.pause(null);
    set('isPlaying', false);
  }

  @reflectable
  cast([_, __]) => _video.launchSessionManager();

  // TODO(zoechi) e.target.value doesn't always provide the value
  // representing the mouse-up position. This might be a Dartium issue
  @reflectable
  void progressMouseUp(dom.Event e, [_]) {
    var duration = _video.duration;
    var newPosition = (duration / 100) *
        double.parse((e.target as dom.RangeInputElement).value);
    _video.currentTime = newPosition;
  }

  //IMPORTANT use this to get the currentTime even when casting
  @reflectable
  void timeUpdate(dom.CustomEvent event, [_]) {
    var duration = _video.duration;
    var currentTime = event.detail['currentTime'];
    set('progress', '${currentTime * (100 / duration)}');
  }

  //listen for casting event to change icon
  @reflectable
  casting(dom.CustomEvent event, [_]) {
    set('castButtonCaption',
        event.detail.casting ? "STOP CASTING" : "START CASTING");
  }
}
