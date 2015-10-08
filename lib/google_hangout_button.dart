// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_hangout_button`.
@HtmlImport('google_hangout_button_nodart.html')
library polymer_elements.lib.src.google_hangout_button.google_hangout_button;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_plusone_api.dart';

/// Element providing a button to start a Google Hangout.
///
/// ##### Example
///
///     <google-hangout-button></google-hangout-button>
@CustomElementProxy('google-hangout-button')
class GoogleHangoutButton extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleHangoutButton.created() : super.created();
  factory GoogleHangoutButton() => new Element.tag('google-hangout-button');

  /// Specifies the Google+ Hangout apps to launch when a user clicks the
  /// Hangout button. Invalid objects and parameters are ignored.
  ///
  /// See the [Initial app parameters reference](https://developers.google.com/+/hangouts/button#initial_app_parameters)
  /// for more details.
  List get apps => jsElement[r'apps'];
  set apps(List value) { jsElement[r'apps'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Specifies the list of people to invite when the user clicks the
  /// Hangout button. Invalid objects and parameters are ignored.
  ///
  /// See the [Invite parameters reference](https://developers.google.com/+/hangouts/button#invite_parameters)
  /// for more details.
  List get invites => jsElement[r'invites'];
  set invites(List value) { jsElement[r'invites'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Pre-populates the topic field for Hangouts on Air. Note that users can
  /// change the topic of the Hangout after they have joined.
  String get topic => jsElement[r'topic'];
  set topic(String value) { jsElement[r'topic'] = value; }

  /// Specifies what type of Hangout should be started.
  /// Valid values are 'normal', 'onair', 'party' and 'moderated'
  ///
  /// See the [Hangout button parameter reference](https://developers.google.com/+/hangouts/button#hangout_button_parameters)
  /// for more details.
  String get type => jsElement[r'type'];
  set type(String value) { jsElement[r'type'] = value; }

  /// Specifies the width of the button.
  num get width => jsElement[r'width'];
  set width(num value) { jsElement[r'width'] = value; }
}
