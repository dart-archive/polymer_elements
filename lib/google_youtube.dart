// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_youtube`.
@HtmlImport('google_youtube_nodart.html')
library polymer_elements.lib.src.google_youtube.google_youtube;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_localstorage.dart';
import 'google_youtube_api.dart';

/// `google-youtube` encapsulates the YouTube player into a web component.
///
///     <google-youtube
///       video-id="..."
///       height="270px"
///       width="480px"
///       rel="0"
///       start="5"
///       autoplay="1">
///     </google-youtube>
///
/// `google-youtube` supports all of the [embedded player parameters](https://developers.google.com/youtube/player_parameters). Each can be set as an attribute on `google-youtube`.
///
/// The standard set of [YouTube player events](https://developers.google.com/youtube/iframe_api_reference#Events) are exposed, as well as methods for playing, pausing, seeking to a specific time, and loading a new video.
///
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--google-youtube-container`  | Mixin applied to the container div | `{}`
/// `--google-youtube-thumbnail`  | Mixin for the video thumbnail      | `{}`
/// `--google-youtube-iframe`     | Mixin for the embeded iframe       | `{}`
@CustomElementProxy('google-youtube')
class GoogleYoutube extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleYoutube.created() : super.created();
  factory GoogleYoutube() => new Element.tag('google-youtube');

  /// "1" if video should start automatically
  num get autoplay => jsElement[r'autoplay'];
  set autoplay(num value) { jsElement[r'autoplay'] = value; }

  /// A shorthand to enable a set of player attributes that, used together, simulate a "chromeless" YouTube player.
  ///
  /// Equivalent to setting the following attributes:
  /// - `controls="0"`
  /// - `modestbranding="1"`
  /// - `showinfo="0"`
  /// - `iv_load_policy="3"`
  /// - `rel="0"`
  ///
  /// The "chromeless" player has minimal YouTube branding in cued state, and the native controls
  /// will be disabled during playback. Creating your own custom play/pause/etc. controls is recommended.
  bool get chromeless => jsElement[r'chromeless'];
  set chromeless(bool value) { jsElement[r'chromeless'] = value; }

  /// Exposes the current playback time, in seconds.
  ///
  /// You can divide this value by the `duration` to determine the playback percentage.
  num get currenttime => jsElement[r'currenttime'];
  set currenttime(num value) { jsElement[r'currenttime'] = value; }

  /// Exposes the current playback time, formatted as a (HH:)MM:SS string.
  String get currenttimeformatted => jsElement[r'currenttimeformatted'];
  set currenttimeformatted(String value) { jsElement[r'currenttimeformatted'] = value; }

  /// Exposes the video duration, in seconds.
  ///
  /// You can divide the `currenttime` to determine the playback percentage.
  num get duration => jsElement[r'duration'];
  set duration(num value) { jsElement[r'duration'] = value; }

  /// Exposes the video duration, formatted as a (HH:)MM:SS string.
  String get durationformatted => jsElement[r'durationformatted'];
  set durationformatted(String value) { jsElement[r'durationformatted'] = value; }

  /// If `fluid` is set, then the player will set its width to 100% to fill
  /// the parent container, while adding `padding-top` to preserve the
  /// aspect ratio provided by `width` and `height`. If `width` and `height`
  /// have not been set, the player will fall back to a 16:9 aspect ratio.
  /// This is useful for responsive designs where you don't want to
  /// introduce letterboxing on your video.
  bool get fluid => jsElement[r'fluid'];
  set fluid(bool value) { jsElement[r'fluid'] = value; }

  /// The fraction of the bytes that have been loaded for the current video, in the range [0-1].
  num get fractionloaded => jsElement[r'fractionloaded'];
  set fractionloaded(num value) { jsElement[r'fractionloaded'] = value; }

  /// Sets the height of the player on the page.
  /// Accepts anything valid for a CSS measurement, e.g. '200px' or '50%'.
  /// If the unit of measurement is left off, 'px' is assumed.
  String get height => jsElement[r'height'];
  set height(String value) { jsElement[r'height'] = value; }

  /// Whether playback has started.
  ///
  /// This defaults to `false` and is set to `true` once the first 'playing' event is fired by
  /// the underlying YouTube Player API.
  ///
  /// Once set to `true`, it will remain that way indefinitely.
  /// Paused/buffering/ended events won't cause `playbackstarted` to reset to `false`.
  /// Nor will loading a new video into the player.
  bool get playbackstarted => jsElement[r'playbackstarted'];
  set playbackstarted(bool value) { jsElement[r'playbackstarted'] = value; }

  /// Whether programmatic `<video>.play()` for initial playback is supported in the current browser.
  ///
  /// Most mobile browsers [do not support](https://developer.apple.com/library/safari/documentation/AudioVideo/Conceptual/Using_HTML5_Audio_Video/Device-SpecificConsiderations/Device-SpecificConsiderations.html#//apple_ref/doc/uid/TP40009523-CH5-SW1) autoplaying or scripted playback of videos.
  /// If you attempt to automatically initiate playback of a `<google-youtube>`, e.g. by calling the `play()` method before
  /// playback has initially begun, the YouTube Player will enter an unrecoverable "stuck" state.
  /// To protect against this, check the value of `playsupported` and don't call `play()` if it is set to `false`.
  /// (You can hide/disable your custom play button, etc.)
  ///
  /// The `playsupported` value is determined at runtime, by dynamically creating a `<video>` element with an
  /// inlined data source and calling `play()` on it. (Inspired by [Modernizr](https://github.com/Modernizr/Modernizr/blob/master/feature-detects/video/autoplay.js).)
  ///
  /// If you would rather not incur the minimal overhead involved in going through this process, you can explicitly set
  /// `playsupported` to `true` or `false` when initializing `<google-youtube>`. This is only recommended if you know that
  /// your web app will never (or only) be used on mobile browsers.
  bool get playsupported => jsElement[r'playsupported'];
  set playsupported(bool value) { jsElement[r'playsupported'] = value; }

  /// Exposes the current player state.
  /// Using this attribute is an alternative to listening to `google-youtube-state-change` events,
  /// and can simplify the logic in templates with conditional binding.
  ///
  /// The [possible values](https://developers.google.com/youtube/iframe_api_reference#onStateChange):
  ///   - -1 (unstarted)
  ///   - 0 (ended)
  ///   - 1 (playing)
  ///   - 2 (paused)
  ///   - 3 (buffering)
  ///   - 5 (video cued)
  num get state => jsElement[r'state'];
  set state(num value) { jsElement[r'state'] = value; }

  /// The URL of an image to use as a custom thumbnail.
  ///
  /// This is optional; if not provided, the standard YouTube embed (which uses the thumbnail associated
  /// with the video on YouTube) will be used.
  ///
  /// If `thumbnail` is set, than an `<img>` containing the thumbnail will be used in lieu of the actual
  /// YouTube embed. When the thumbnail is clicked, the `<img>` is swapped out for the actual YouTube embed,
  /// which will have [`autoplay=1`](https://developers.google.com/youtube/player_parameters#autoplay) set by default (in additional to any other player parameters specified on this element).
  ///
  /// Please note that `autoplay=1` won't actually autoplay videos on mobile browsers, so two taps will be required
  /// to play the video there. Also, on desktop browsers, setting `autoplay=1` will prevent the playback
  /// from [incrementing the view count](https://support.google.com/youtube/answer/1714329) for the video.
  String get thumbnail => jsElement[r'thumbnail'];
  set thumbnail(String value) { jsElement[r'thumbnail'] = value; }

  /// Sets the id of the video to play. Changing this attribute will trigger a call
  /// to load a new video into the player (if `this.autoplay` is set to `1` and `playsupported` is true)
  /// or cue a new video otherwise.
  ///
  /// The underlying YouTube embed will not be added to the page unless this
  /// value is set.
  ///
  /// You can [search for videos programmatically](https://developers.google.com/youtube/v3/docs/search/list)
  /// using the YouTube Data API, or just hardcode known video ids to display on your page.
  String get videoId => jsElement[r'videoId'];
  set videoId(String value) { jsElement[r'videoId'] = value; }

  /// Sets the width of the player on the page.
  /// Accepts anything valid for a CSS measurement, e.g. '200px' or '50%'.
  /// If the unit of measurement is left off, 'px' is assumed.
  String get width => jsElement[r'width'];
  set width(String value) { jsElement[r'width'] = value; }

  /// Mutes the current video.
  ///
  /// Developers should take care not to break expected user experience by programmatically
  /// modifying the volume on mobile browsers.
  /// Note that the YouTube player, in addition, does not display volume controls in a
  /// mobile environment.
  mute() =>
      jsElement.callMethod('mute', []);

  /// Pauses the current video.
  pause() =>
      jsElement.callMethod('pause', []);

  /// Plays the current video.
  ///
  /// Note that on certain mobile browsers, playback
  /// [can't be initiated programmatically](https://developers.google.com/youtube/iframe_api_reference#Mobile_considerations).
  ///
  /// If `this.playsupported` is not `true`, calling `play()` will have no effect.
  play() =>
      jsElement.callMethod('play', []);

  /// Skips ahead (or back) to the specified number of seconds.
  /// [seconds]: Number of seconds to seek to.
  seekTo(num seconds) =>
      jsElement.callMethod('seekTo', [seconds]);

  /// Modifies the volume of the current video.
  ///
  /// Developers should take care not to break expected user experience by programmatically
  /// modifying the volume on mobile browsers.
  /// Note that the YouTube player, in addition, does not display volume controls in a
  /// mobile environment.
  /// [volume]: The new volume, an integer between 0 (muted) and 100 (loudest).
  setVolume(num volume) =>
      jsElement.callMethod('setVolume', [volume]);

  /// Unmutes the current video.
  ///
  /// Developers should take care not to break expected user experience by programmatically
  /// modifying the volume on mobile browsers.
  /// Note that the YouTube player, in addition, does not display volume controls in a
  /// mobile environment.
  unMute() =>
      jsElement.callMethod('unMute', []);
}
