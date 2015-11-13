// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_sheets`.
@HtmlImport('google_sheets_nodart.html')
library polymer_elements.lib.src.google_sheets.google_sheets;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_ajax.dart';
import 'google_signin_aware.dart';

/// Element for interacting with Google Sheets.
///
/// `<google-sheets>` pulls cell data from the Google Sheet specified by `key`.
/// A spreadsheet's key can be found in the URL when viewing it in google docs (e.g. `docs.google.com/spreadsheet/ccc?key=<KEY>#gid=12345`).
///
/// Optionally, pass the `tab-id` attribute to specify a particular worksheet tab in the spreadsheet. For example, the first tab would be `tab-id="1"`. If `tab` is updated at a later time, the underlying data is also updated. **API calls are cached** as to not make extraneous calls.
///
/// See [developers.google.com/google-apps/spreadsheets](https://developers.google.com/google-apps/spreadsheets) for full Spreadsheets API documentation.
///
/// #### Example
///
///     <google-sheets key="..." tab-id="1" client-id="..."></google-sheets>
///
///     <script>
///       var sheet = document.querySelector('google-sheets');
///
///       sheet.addEventListener('google-sheet-data', function(e) {
///        // this.spreadsheets - list of the user's spreadsheets
///        // this.tab - information on the tab that was fetched
///        // this.rows - cell row information for the tab that was fetched
///       });
///
///       sheet.addEventListener('error', function(e) {
///        // e.detail.response
///       });
///     </script>
///
/// <b>Example</b> - `published` is a perf optimization and hints that the spreadsheet has been published (public):
///
///     <google-sheets key="0Anye-JMjUkZZdDBkMVluMEhZMmFGeHpYdDJJV1FBRWc" published></google-sheets>
///
/// <b>Example</b> - leaving off the `key` returns as list of the user's spreadsheets.
///
///     <google-sheets client-id="..."></google-sheets>
///
/// <b>Example</b> - show a list of Map markers, using data-binding features inside Polymer:
///
///     <template is="dom-bind">
///       <google-sheets
///         key="0Anye-JMjUkZZdDBkMVluMEhZMmFGeHpYdDJJV1FBRWc" tab-id="1" rows="{{rows}}"
///         client-id="...">
///       </google-sheets>
///       <google-map>
///         <google-map-marker latitude="{{gsx$lat.$t}}" longitude="{{gsx$lng.$t}}">
///       </google-map>
///     </template>
///
/// <b>Example</b> - list a user's private spreadsheets. Authenticate with google-signin button.
///
///     <google-signin
///       client-id="1054047045356-j8pgqgls9vdef3rl09hapoicumbte0bo.apps.googleusercontent.com"
///       scopes="https://spreadsheets.google.com/feeds">
///     </google-signin>
///
///     <template is="dom-bind">
///       <google-sheets client-id="1054047045356-j8pgqgls9vdef3rl09hapoicumbte0bo.apps.googleusercontent.com"
///          key="1QMGizivw3UJ3-R9BFK7sfrXE0RL87dygk2C0RcuKoDY" tab-id="1"
///          spreadsheets="{{spreadsheets}}"></google-sheets>
///       <template is="dom-repeat" items="[[spreadsheets]]">
///         <p>{{item.title.$t}}</p>
///       </template>
///     </template>
@CustomElementProxy('google-sheets')
class GoogleSheets extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleSheets.created() : super.created();
  factory GoogleSheets() => new Element.tag('google-sheets');

  /// A Google Developers client ID. Obtain from [console.developers.google.com](https://console.developers.google.com). Required for accessing a private spreadsheet. Optional if accessing a public spreadsheet.
  String get clientId => jsElement[r'clientId'];
  set clientId(String value) { jsElement[r'clientId'] = value; }

  /// The key of the spreadsheet. This can be found in the URL when viewing
  /// the document is Google Docs (e.g. `docs.google.com/spreadsheet/ccc?key=<KEY>`).
  ///
  /// Leaving off this attribute still returns a list of the users spreadsheets in the `spreadsheets` property.
  String get key => jsElement[r'key'];
  set key(String value) { jsElement[r'key'] = value; }

  /// The URL to open this spreadsheet in Google Sheets.
  String get openInGoogleDocsUrl => jsElement[r'openInGoogleDocsUrl'];
  set openInGoogleDocsUrl(String value) { jsElement[r'openInGoogleDocsUrl'] = value; }

  /// A hint that the spreadsheet is published publicly in Google Docs. Used as a performance optimization.
  /// Make sure the sheet is also publicly viewable by anyone in the Share settings.
  bool get published => jsElement[r'published'];
  set published(bool value) { jsElement[r'published'] = value; }

  /// If a spreadsheet `key` is specified, returns a list of cell row data.
  List get rows => jsElement[r'rows'];
  set rows(List value) { jsElement[r'rows'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The fetched sheet corresponding to the `key` attribute.
  get sheet => jsElement[r'sheet'];
  set sheet(value) { jsElement[r'sheet'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// List of the user's spreadsheets. Shared across instances.
  List get spreadsheets => jsElement[r'spreadsheets'];
  set spreadsheets(List value) { jsElement[r'spreadsheets'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Meta data about the particular tab that was retrieved for the spreadsheet.
  get tab => jsElement[r'tab'];
  set tab(value) { jsElement[r'tab'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Tab within a spreadsheet. For example, the first tab in a spreadsheet
  /// would be `tab-id="1"`.
  num get tabId => jsElement[r'tabId'];
  set tabId(num value) { jsElement[r'tabId'] = value; }
}
