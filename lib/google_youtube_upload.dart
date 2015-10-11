// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_youtube_upload`.
@HtmlImport('google_youtube_upload_nodart.html')
library polymer_elements.lib.src.google_youtube_upload.google_youtube_upload;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_signin.dart';
import 'google_client_loader.dart';

/// Element enabling you to upload videos to YouTube.
///
/// ##### Examples
///
/// Manual upload with a `Video Upload` button once a video file is selected:
///
///     <google-youtube-upload client-id="..."></google-youtube-upload>
///
/// Automatic upload on video file select, with a custom title, and 'unlisted' privacy:
///
///     <google-youtube-upload
///       auto
///       video-title="My Awesome Video"
///       privacy-status="unlisted"
///       client-id="...">
///     </google-youtube-upload>
@CustomElementProxy('google-youtube-upload')
class GoogleYoutubeUpload extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleYoutubeUpload.created() : super.created();
  factory GoogleYoutubeUpload() => new Element.tag('google-youtube-upload');

  /// Whether the user has authenticated or not.
  bool get authenticated => jsElement[r'authenticated'];
  set authenticated(bool value) { jsElement[r'authenticated'] = value; }

  /// Whether files should be automatically uploaded.
  bool get auto => jsElement[r'auto'];
  set auto(bool value) { jsElement[r'auto'] = value; }

  /// The numeric YouTube
  /// [cateogry id](https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.videoCategories.list?part=snippet&regionCode=us).
  num get categoryId => jsElement[r'categoryId'];
  set categoryId(num value) { jsElement[r'categoryId'] = value; }

  /// An OAuth 2 clientId reference, obtained from the
  /// [Google Developers Console](https://console.developers.google.com).
  ///
  /// Follow
  /// [the steps](https://developers.google.com/console/help/new/#generatingoauth2)
  /// for registering for OAuth 2, ensure that the
  /// [YouTube Data API v3](https://developers.google.com/youtube/registering_an_application)
  /// is enabled for your API project, and ensure that the JavaScript Origin
  /// is set to the domain hosting the page on which
  /// you'll be using this element.
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// The description for the new YouTube video.
  String get description => jsElement[r'description'];
  set description(String value) { jsElement[r'description'] = value; }

  /// The [privacy setting](https://support.google.com/youtube/answer/157177?hl=en)
  /// for the new video.
  ///
  /// Valid values are 'public', 'private', and 'unlisted'.
  String get privacyStatus => jsElement[r'privacyStatus'];
  set privacyStatus(String value) { jsElement[r'privacyStatus'] = value; }

  /// The array of tags for the new YouTube video.
  List get tags => jsElement[r'tags'];
  set tags(List value) { jsElement[r'tags'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The id of the new video.
  ///
  /// This is set as soon as a `youtube-upload-complete` event is fired.
  String get videoId => jsElement[r'videoId'];
  set videoId(String value) { jsElement[r'videoId'] = value; }

  /// The title for the new YouTube video.
  String get videoTitle => jsElement[r'videoTitle'];
  set videoTitle(String value) { jsElement[r'videoTitle'] = value; }

  /// Uploads a video file to YouTube.
  ///
  /// `this.accessToken` must already be set to a valid OAuth 2 access token.
  /// [file]: File object corresponding to the video to upload.
  uploadFile(file) =>
      jsElement.callMethod('uploadFile', [file]);
}
