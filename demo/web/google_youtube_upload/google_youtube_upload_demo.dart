/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_youtube_upload_demo.html')
library polymer_elements_demo.web.google_youtube_upload.google_youtube_upload_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_youtube_upload.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleYoutubeUpload], [DemoElements]
@PolymerRegister('google-youtube-upload-demo')
class GoogleYoutubeUploadDemo extends PolymerElement {
  GoogleYoutubeUploadDemo.created() : super.created();

  @property String state = 'pre-upload';
  @property String processingEllipses = '...';
  @property int megabytesPerSecond = 0;
  @property int minutesRemaining = 0;
  @property int secondsRemaining = 0;
  @property int fractionComplete = 0;
  @property String error = '';
  @property String videoTitle = 'Untitled Video';
  @property String description =
      'Uploaded via a web component! Check out https://github.com/GoogleWebComponents/google-youtube-upload';
  @property String privacyStatus = 'public';
  @property String videoId = '';
  @property String videoUrl = 'computeVideoUrl(videoId)';

  @reflectable
  bool canShowPreUpload(String state) => state == 'pre-upload';

  @reflectable
  bool canShowUpload(String state) => state == 'upload';

  @reflectable
  bool canShowUploadComplete(String state) => state == 'upload-complete';

  @reflectable
  bool canShowProcessingComplete(String state) =>
      state == 'processing-complete';

  @reflectable
  bool canShowError(String state) => state == 'error';

  @reflectable
  String computeProgressText(
          int megabytesPerSecond, int minutesRemaining, int secondsRemaining) =>
      '${megabytesPerSecond}MB/s, ${minutesRemaining}m ${secondsRemaining}s remaining';

  @reflectable
  String computeVideoUrl(int videoId) => 'https://youtu.be/${videoId}';

  @reflectable
  handleYouTubeUploadStart([_, __]) => set('state', 'upload');

  @reflectable
  void handleYouTubeUploadProgress(dom.CustomEvent event, [_]) {
    set('megabytesPerSecond',
        (event.detail.bytesPerSecond / (1024 * 1024)).toFixed(2));
    set('minutesRemaining',
        ((event.detail.estimatedSecondsRemaining / 60) as double).floor());
    set('secondsRemaining',
        ((event.detail.estimatedSecondsRemaining % 60) as double).round());
    set('fractionComplete', event.detail.fractionComplete);
  }

  @reflectable
  void handleYouTubeUploadComplete([_, __]) {
    set('state', 'upload-complete');
  }

  @reflectable
  void handleYouTubeUploadFail(dom.CustomEvent event, [_]) {
    set('error', event.detail);
    set('state', 'error');
  }

  @reflectable
  handleYouTubeProcessingPoll([_, __]) =>
      set('processingEllipses', '${processingEllipses}.');

  @reflectable
  handleYouTubeProcessingComplete([_, __]) =>
      set('state', 'processing-complete');

  @reflectable
  void handleYouTubeProcessingFail(dom.CustomEvent event, [_]) {
    var error;
    switch (event.detail.uploadStatus) {
      case 'failed':
        error = event.detail.failureReason ?? 'unknown error';
        break;

      case 'rejected':
        error = event.detail.rejectionReason ?? 'unknown error';
        break;

      default:
        error = 'unknown error';
        break;
    }

    set('error', 'YouTube processing failed (${error}).');
    set('state', 'error');
  }
}
