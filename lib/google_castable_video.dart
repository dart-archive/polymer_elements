// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_castable_video`.
@HtmlImport('google_castable_video_nodart.html')
library polymer_elements.lib.src.google_castable_video.google_castable_video;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `google-castable-video` element enables your HTML5 videos to be casted to any Chromecast.
///
/// It behaves exactly like an HTML5 video element except for some added methods and events.
///
/// Instead of listening for the video element's `timeupdate` event please listen for the `google-castable-video-timeupdate` event. This event is fired if the video is playing locally and on the Chromecast device.
///
/// ##### Example
///
///     <video is="google-castable-video">
///       <source src="video.mp4" type="video/mp4">
///     </video>
@CustomElementProxy('google-castable-video', extendsTag: 'video')
class GoogleCastableVideo extends VideoElement with CustomElementProxyMixin, PolymerBase {
  GoogleCastableVideo.created() : super.created();
  factory GoogleCastableVideo() => new Element.tag('video', 'google-castable-video');

  /// The appId that references which receiver the Chromecast will load.
  String get appId => jsElement[r'appId'];
  set appId(String value) { jsElement[r'appId'] = value; }

  /// Sets or returns the current playback position (in seconds).
  /// Since the local video is paused when the video is playing on the Chromecast device
  /// the objects currentTime property doesn't represent the actual currentTime of the video
  /// playing on the Chromecast device. To always get the actual position please use bothCurrentTime.
  get bothCurrentTime => jsElement[r'bothCurrentTime'];
  set bothCurrentTime(value) { jsElement[r'bothCurrentTime'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  get bothPaused => jsElement[r'bothPaused'];

  get castMedia => jsElement[r'castMedia'];

  get casting => jsElement[r'casting'];

  get receiverAvailable => jsElement[r'receiverAvailable'];

  get session => jsElement[r'session'];

  /// Call this when the user clicks the cast icon.
  /// Opens the cast extension to create a session with the selected receiver.
  launchSessionManager() =>
      jsElement.callMethod('launchSessionManager', []);

  /// Call the `pause` method from your controls.
  pause([cast]) => //(cast) =>
      jsElement.callMethod('pause', [cast]);

  /// Call the `play` method from your controls.
  play([cast]) => //(cast) =>
      jsElement.callMethod('play', [cast]);
}
