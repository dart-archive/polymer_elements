// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_signin_aware`.
@HtmlImport('google_signin_aware_nodart.html')
library polymer_elements.lib.src.google_signin.google_signin_aware;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_js_api.dart';

/// `google-signin-aware` is used to enable authentication in custom elements by
/// interacting with a google-signin element that needs to be present somewhere
/// on the page.
///
/// The `scopes` attribute allows you to specify which scope permissions are required
/// (e.g do you want to allow interaction with the Google Drive API).
///
/// The `google-signin-aware-success` event is triggered when a user successfully
/// authenticates. If either `offline` or `offlineAlwaysPrompt` is set to true, successful
/// authentication will also trigger the `google-signin-offline-success`event.
/// The `google-signin-aware-signed-out` event is triggered when a user explicitly
/// signs out via the google-signin element.
///
/// You can bind to `isAuthorized` property to monitor authorization state.
/// ##### Example
///
///     <google-signin-aware scopes="https://www.googleapis.com/auth/drive"></google-signin-aware>
///
///
/// ##### Example with offline
///     <template id="awareness" is="dom-bind">
///       <google-signin-aware
///           scopes="https://www.googleapis.com/auth/drive"
///           offline
///           on-google-signin-aware-success="handleSignin"
///           on-google-signin-offline-success="handleOffline"></google-signin-aware>
///     <\/template>
///     <script>
///       var aware = document.querySelector('#awareness');
///       aware.handleSignin = function(response) {
///         var user = gapi.auth2.getAuthInstance()['currentUser'].get();
///         console.log('User name: ' + user.getBasicProfile().getName());
///       };
///       aware.handleOffline = function(response) {
///         console.log('Offline code received: ' + response.detail.code);
///         // Here you would POST response.detail.code to your webserver, which can
///         // exchange the authorization code for an access token. More info at:
///         // https://developers.google.com/identity/protocols/OAuth2WebServer
///       };
///     <\/script>
@CustomElementProxy('google-signin-aware')
class GoogleSigninAware extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleSigninAware.created() : super.created();
  factory GoogleSigninAware() => new Element.tag('google-signin-aware');

  /// App package name for android over-the-air installs.
  /// See the relevant [docs](https://developers.google.com/+/web/signin/android-app-installs)
  String get appPackageName => jsElement[r'appPackageName'];
  set appPackageName(String value) { jsElement[r'appPackageName'] = value; }

  /// a Google Developers clientId reference
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// The cookie policy defines what URIs have access to the session cookie
  /// remembering the user's sign-in state.
  /// See the relevant [docs](https://developers.google.com/+/web/signin/reference#determining_a_value_for_cookie_policy) for more information.
  String get cookiePolicy => jsElement[r'cookiePolicy'];
  set cookiePolicy(String value) { jsElement[r'cookiePolicy'] = value; }

  /// True if *any* element has google+ scopes
  bool get hasPlusScopes => jsElement[r'hasPlusScopes'];
  set hasPlusScopes(bool value) { jsElement[r'hasPlusScopes'] = value; }

  /// The Google Apps domain to which users must belong to sign in.
  /// See the relevant [docs](https://developers.google.com/identity/sign-in/web/reference) for more information.
  String get hostedDomain => jsElement[r'hostedDomain'];
  set hostedDomain(String value) { jsElement[r'hostedDomain'] = value; }

  /// True if authorizations for *this* element have been granted
  bool get isAuthorized => jsElement[r'isAuthorized'];
  set isAuthorized(bool value) { jsElement[r'isAuthorized'] = value; }

  /// True if additional authorizations for *any* element are required
  bool get needAdditionalAuth => jsElement[r'needAdditionalAuth'];
  set needAdditionalAuth(bool value) { jsElement[r'needAdditionalAuth'] = value; }

  /// Allows for offline `access_token` retrieval during the signin process.
  /// See also `offlineAlwaysPrompt`. You only need to set one of the two; if both
  /// are set, the behavior of `offlineAlwaysPrompt` will override `offline`.
  bool get offline => jsElement[r'offline'];
  set offline(bool value) { jsElement[r'offline'] = value; }

  /// Works the same as `offline` with the addition that it will always
  /// force a re-prompt to the user, guaranteeing that you will get a
  /// refresh_token even if the user has already granted offline access to
  /// this application. You only need to set one of `offline` or
  /// `offlineAlwaysPrompt`, not both.
  bool get offlineAlwaysPrompt => jsElement[r'offlineAlwaysPrompt'];
  set offlineAlwaysPrompt(bool value) { jsElement[r'offlineAlwaysPrompt'] = value; }

  /// Space-delimited, case-sensitive list of strings that
  /// specifies whether the the user is prompted for reauthentication
  /// and/or consent. The defined values are:
  ///   none: do not display authentication or consent pages.
  ///     This value is mutually exclusive with the rest.
  ///   login: always prompt the user for reauthentication.
  ///   consent: always show consent screen.
  ///   select_account: always show account selection page.
  ///     This enables a user who has multiple accounts to select amongst
  ///     the multiple accounts that they might have current sessions for.
  /// For more information, see "prompt" parameter description in
  /// https://openid.net/specs/openid-connect-basic-1_0.html#RequestParameters
  String get openidPrompt => jsElement[r'openidPrompt'];
  set openidPrompt(String value) { jsElement[r'openidPrompt'] = value; }

  /// The app activity types you want to write on behalf of the user
  /// (e.g http://schemas.google.com/AddActivity)
  String get requestVisibleActions => jsElement[r'requestVisibleActions'];
  set requestVisibleActions(String value) { jsElement[r'requestVisibleActions'] = value; }

  /// The scopes to provide access to (e.g https://www.googleapis.com/auth/drive)
  /// and should be space-delimited.
  String get scopes => jsElement[r'scopes'];
  set scopes(String value) { jsElement[r'scopes'] = value; }

  /// True if user is signed in
  bool get signedIn => jsElement[r'signedIn'];
  set signedIn(bool value) { jsElement[r'signedIn'] = value; }

  errorNotify(error) =>
      jsElement.callMethod('errorNotify', [error]);

  /// pops up the authorization dialog
  signIn() =>
      jsElement.callMethod('signIn', []);

  /// signs user out
  signOut() =>
      jsElement.callMethod('signOut', []);
}
