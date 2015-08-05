// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_push_messaging`.
@HtmlImport('platinum_push_messaging_nodart.html')
library polymer_elements.lib.src.platinum_push_messaging.platinum_push_messaging;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `<platinum-push-messaging>` sets up a [push messaging][1] subscription
/// and allows you to define what happens when a push message is received.
///
/// The element can be placed anywhere, but should only be used once in a
/// page. If there are multiple occurrences, only one will be active.
///
/// # Sample
///
/// For a complete sample that uses the element, see the [Cat Push
/// Notifications][3] project.
///
/// # Requirements
/// Push messaging is currently only available in Google Chrome, which
/// requires you to configure Google Cloud Messaging. Chrome will check that
/// your page links to a manifest file that contains a `gcm_sender_id` field.
/// You can find full details of how to set all of this up in the [HTML5
/// Rocks guide to push notifications][1].
///
/// # Notification details
/// The data for how a notification should be displayed can come from one of
/// three places.
///
/// Firstly, you can specify a URL from which to fetch the message data.
/// ```
/// <platinum-push-messaging
///   message-url="notification-data.json">
/// </platinum-push-messaging>
/// ```
///
/// The second way is to send the message data in the body of
/// the push message from your server. In this case you do not need to
/// configure anything in your page:
/// ```
/// <platinum-push-messaging></platinum-push-messaging>
/// ```
/// **Note that this method is not currently supported by any browser**. It
/// is, however, defined in the
/// [draft W3C specification](http://w3c.github.io/push-api/#the-push-event)
/// and this element should use that data when it is implemented in the
/// future.
///
/// If a message-url is provided then the message body will be ignored in
/// favor of the first method.
///
/// Thirdly, you can manually define the attributes on the element:
/// ```
/// <platinum-push-messaging
///   title="Application updated"
///   message="The application was updated in the background"
///   icon-url="icon.png"
///   click-url="notification.html">
/// </platinum-push-messaging>
/// ```
/// These values will also be used as defaults if one of the other methods
/// does not provide a value for that property.
///
/// # Testing
/// If you have set up Google Cloud Messaging then you can send push messages
/// to your browser by following the guide in the [GCM documentation][2].
///
/// However, for quick client testing there are two options. You can use the
/// `testPush` method, which allows you to simulate a push message that
/// includes a payload.
///
/// Or, at a lower level, you can open up chrome://serviceworker-internals in
/// Chrome and use the 'Push' button for the service worker corresponding to
/// your app.
///
/// [1]: http://updates.html5rocks.com/2015/03/push-notificatons-on-the-open-web
/// [2]: https://developer.android.com/google/gcm/http.html
/// [3]: https://github.com/notwaldorf/caturday-post
@CustomElementProxy('platinum-push-messaging')
class PlatinumPushMessaging extends HtmlElement with CustomElementProxyMixin, PolymerProxyMixin {
  PlatinumPushMessaging.created() : super.created();
  factory PlatinumPushMessaging() => new Element.tag('platinum-push-messaging');

  /// A default URL to display when a notification is clicked.
  String get clickUrl => jsElement[r'clickUrl'];
  set clickUrl(String value) { jsElement[r'clickUrl'] = value; }

  /// Indicates the status of the element. If true, push messages will be
  /// received.
  bool get enabled => jsElement[r'enabled'];
  set enabled(bool value) { jsElement[r'enabled'] = value; }

  /// A default icon for notifications.
  String get iconUrl => jsElement[r'iconUrl'];
  set iconUrl(String value) { jsElement[r'iconUrl'] = value; }

  /// A default notification message.
  String get message => jsElement[r'message'];
  set message(String value) { jsElement[r'message'] = value; }

  /// A URL from which message information can be retrieved.
  ///
  /// When a push event happens that does not contain a message body this
  /// URL will be fetched. The URL is expected to be for a JSON document in
  /// the format:
  /// ```
  /// {
  ///   "title": "The title for the notification",
  ///   "message": "The message to display in the notification",
  ///   "url": "The URL to display when the notification is clicked",
  ///   "icon": "The URL of an icon to display with the notification",
  ///   "tag": "An identifier that determines which notifications can be displayed at the same time"
  /// }
  /// ```
  String get messageUrl => jsElement[r'messageUrl'];
  set messageUrl(String value) { jsElement[r'messageUrl'] = value; }

  /// The details of the current push subscription, if any.
  get subscription => jsElement[r'subscription'];
  set subscription(value) { jsElement[r'subscription'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Indicates whether the Push and Notification APIs are supported by
  /// this browser.
  bool get supported => jsElement[r'supported'];
  set supported(bool value) { jsElement[r'supported'] = value; }

  /// A default tag for the notifications that will be generated by
  /// this element. Notifications with the same tag will overwrite one
  /// another, so that only one will be shown at once.
  String get tag => jsElement[r'tag'];
  set tag(String value) { jsElement[r'tag'] = value; }

  /// A default notification title.
  String get title => jsElement[r'title'];
  set title(String value) { jsElement[r'title'] = value; }

  /// Request push messaging to be disabled.
  disable() =>
      jsElement.callMethod('disable', []);

  /// Request push messaging to be enabled.
  enable() =>
      jsElement.callMethod('enable', []);

  /// Programmatically trigger a push message
  /// [message]: {Object} the message payload
  void testPush(message) =>
      jsElement.callMethod('testPush', [message]);
}
