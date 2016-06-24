// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_signin`.
@HtmlImport('google_signin_nodart.html')
library polymer_elements.lib.src.google_signin.google_signin;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_signin_aware.dart';
import 'iron_icon.dart';
import 'roboto.dart';
import 'google_js_api.dart';
import 'paper_ripple.dart';
import 'paper_material.dart';
import 'iron_flex_layout_classes.dart';

/// &lt;google-signin&gt; is used to authenticate with Google, allowing you to interact
/// with other Google APIs such as Drive and Google+.
///
/// <img style="max-width:100%;" src="https://cloud.githubusercontent.com/assets/107076/6791176/5c868822-d16a-11e4-918c-ec9b84a2db45.png"/>
///
/// If you do not need to show the button, use companion `<google-signin-aware>` element to declare scopes, check authentication state.
///
/// #### Examples
///
///     <google-signin client-id="..." scopes="https://www.googleapis.com/auth/drive"></google-signin>
///
///     <google-signin label-signin="Sign-in" client-id="..." scopes="https://www.googleapis.com/auth/drive"></google-signin>
///
///     <google-signin theme="dark" width="iconOnly" client-id="..." scopes="https://www.googleapis.com/auth/drive"></google-signin>
///
///
/// #### Notes
///
/// The attribute `clientId` is provided in your Google Developers Console
/// (https://console.developers.google.com).
///
/// The `scopes` attribute allows you to specify which scope permissions are required
/// (e.g do you want to allow interaction with the Google Drive API). Many APIs also
/// need to be enabled in the Google Developers Console before you can use them.
///
/// The `requestVisibleActions` attribute is necessary if you want to write app
/// activities (https://developers.google.com/+/web/app-activities/) on behalf of
/// the user. Please note that this attribute is only valid in combination with the
/// plus.login scope (https://www.googleapis.com/auth/plus.login).
///
/// The `offline` attribute allows you to get an auth code which your server can
/// redeem for an offline access token
/// (https://developers.google.com/identity/sign-in/web/server-side-flow).
/// You can also set `offline-always-prompt` instead of `offline` to ensure that your app
/// will re-prompt the user for offline access and generate a working `refresh_token`
/// even if they have already granted offline access to your app in the past.
///
/// Use label properties to customize prompts.
///
/// The button can be styled in using the `height`, `width`, and `theme` attributes.
/// These attributes help you follow the Google+ Sign-In button branding guidelines
/// (https://developers.google.com/+/branding-guidelines).
///
/// The `google-signin-success` event is triggered when a user successfully authenticates
/// and `google-signed-out` is triggered when user signs out.
/// You can also use `isAuthorized` attribute to observe user's authentication state.
///
/// Additional events, such as `google-signout-attempted` are
/// triggered when the user attempts to sign-out and successfully signs out.
///
/// When requesting offline access, the `google-signin-offline-success` event is
/// triggered when the user successfully consents with offline support.
///
/// The `google-signin-necessary` event is fired when scopes requested via
/// google-signin-aware elements require additional user permissions.
///
/// #### Testing
///
/// By default, the demo accompanying this element is setup to work on localhost with
/// port 8080. That said, you *should* update the `clientId` to your own one for
/// any apps you're building. See the Google Developers Console
/// (https://console.developers.google.com) for more info.
@CustomElementProxy('google-signin')
class GoogleSignin extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleSignin.created() : super.created();
  factory GoogleSignin() => new Element.tag('google-signin');

  /// App package name for android over-the-air installs.
  /// See the relevant [docs](https://developers.google.com/+/web/signin/android-app-installs)
  String get appPackageName => jsElement[r'appPackageName'];
  set appPackageName(String value) { jsElement[r'appPackageName'] = value; }

  /// The brand being used for logo and styling.
  String get brand => jsElement[r'brand'];
  set brand(String value) { jsElement[r'brand'] = value; }

  /// a Google Developers clientId reference
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// The cookie policy defines what URIs have access to the session cookie
  /// remembering the user's sign-in state.
  /// See the relevant [docs](https://developers.google.com/+/web/signin/reference#determining_a_value_for_cookie_policy) for more information.
  String get cookiePolicy => jsElement[r'cookiePolicy'];
  set cookiePolicy(String value) { jsElement[r'cookiePolicy'] = value; }

  /// By default the ripple expands to fill the button. Set this to true to
  /// constrain the ripple to a circle within the button.
  bool get fill => jsElement[r'fill'];
  set fill(bool value) { jsElement[r'fill'] = value; }

  /// True if *any* element has google+ scopes
  bool get hasPlusScopes => jsElement[r'hasPlusScopes'];
  set hasPlusScopes(bool value) { jsElement[r'hasPlusScopes'] = value; }

  /// The height to use for the button.
  ///
  /// Available options: short, standard, tall.
  get height => jsElement[r'height'];
  set height(value) { jsElement[r'height'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The Google Apps domain to which users must belong to sign in.
  /// See the relevant [docs](https://developers.google.com/identity/sign-in/web/reference) for more information.
  String get hostedDomain => jsElement[r'hostedDomain'];
  set hostedDomain(String value) { jsElement[r'hostedDomain'] = value; }

  /// True if authorizations for *this* element have been granted
  bool get isAuthorized => jsElement[r'isAuthorized'];
  set isAuthorized(bool value) { jsElement[r'isAuthorized'] = value; }

  /// An optional label for the button for additional permissions.
  String get labelAdditional => jsElement[r'labelAdditional'];
  set labelAdditional(String value) { jsElement[r'labelAdditional'] = value; }

  /// An optional label for the sign-in button.
  String get labelSignin => jsElement[r'labelSignin'];
  set labelSignin(String value) { jsElement[r'labelSignin'] = value; }

  /// An optional label for the sign-out button.
  String get labelSignout => jsElement[r'labelSignout'];
  set labelSignout(String value) { jsElement[r'labelSignout'] = value; }

  /// True if additional authorization required globally
  bool get needAdditionalAuth => jsElement[r'needAdditionalAuth'];
  set needAdditionalAuth(bool value) { jsElement[r'needAdditionalAuth'] = value; }

  /// Allows for offline `access_token` retrieval during the signin process.
  bool get offline => jsElement[r'offline'];
  set offline(bool value) { jsElement[r'offline'] = value; }

  /// Forces a re-prompt, even if the user has already granted offline
  /// access to your application in the past. You only need one of
  /// `offline` and `offlineAlwaysPrompt`.
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

  /// If true, the button will be styled with a shadow.
  bool get raised => jsElement[r'raised'];
  set raised(bool value) { jsElement[r'raised'] = value; }

  /// The app activity types you want to write on behalf of the user
  /// (e.g http://schemas.google.com/AddActivity)
  String get requestVisibleActions => jsElement[r'requestVisibleActions'];
  set requestVisibleActions(String value) { jsElement[r'requestVisibleActions'] = value; }

  /// The scopes to provide access to (e.g https://www.googleapis.com/auth/drive)
  /// and should be space-delimited.
  String get scopes => jsElement[r'scopes'];
  set scopes(String value) { jsElement[r'scopes'] = value; }

  /// Is user signed in?
  bool get signedIn => jsElement[r'signedIn'];
  set signedIn(bool value) { jsElement[r'signedIn'] = value; }

  /// The theme to use for the button.
  ///
  /// Available options: light, dark.
  get theme => jsElement[r'theme'];
  set theme(value) { jsElement[r'theme'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The width to use for the button.
  ///
  /// Available options: iconOnly, standard, wide.
  get width => jsElement[r'width'];
  set width(value) { jsElement[r'width'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Sign in user. Opens the authorization dialog for signing in.
  /// The dialog will be blocked by a popup blocker unless called inside click handler.
  signIn() =>
      jsElement.callMethod('signIn', []);

  /// Sign out the user
  signOut() =>
      jsElement.callMethod('signOut', []);
}
