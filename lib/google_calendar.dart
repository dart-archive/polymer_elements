// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_calendar`.
@HtmlImport('google_calendar_nodart.html')
library polymer_elements.lib.src.google_calendar.google_calendar;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_signin_aware.dart';
import 'google_client_loader.dart';

/// Element providing a list of Google Calendars for a signed in user.
/// Needs a google-signin element included somewhere on the same page
/// that handles authentication.
///
/// ##### Example
///
///     <google-calendar-list title="What I'm up to"></google-calendar-list>
@CustomElementProxy('google-calendar-list')
class GoogleCalendarList extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleCalendarList.created() : super.created();
  factory GoogleCalendarList() => new Element.tag('google-calendar-list');

  /// List of calendars
  List get calendars => jsElement[r'calendars'];
  set calendars(List value) { jsElement[r'calendars'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// A title to be displayed on top of the calendar list.
  String get title => jsElement[r'title'];
  set title(String value) { jsElement[r'title'] = value; }

  /// Displays the calendar list if the user is signed in to Google.
  displayCalendars() =>
      jsElement.callMethod('displayCalendars', []);
}



/// A badge showing the free/busy status based on the events in a given calendar.
///
/// ##### Example
///
///     <google-calendar-busy-now
///         calendarId="YOUR_CAL_ID"
///         apiKey="YOUR_API_KEY"
///         busyLabel="Do not disturb"
///         freeLabel="I'm free, talk to me!">
///     </google-calendar-busy-now>
@CustomElementProxy('google-calendar-busy-now')
class GoogleCalendarBusyNow extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleCalendarBusyNow.created() : super.created();
  factory GoogleCalendarBusyNow() => new Element.tag('google-calendar-busy-now');

  /// API key to use with Calendar API requests.
  String get apiKey => jsElement[r'apiKey'];
  set apiKey(String value) { jsElement[r'apiKey'] = value; }

  /// Label to be displayed if the status is busy.
  String get busyLabel => jsElement[r'busyLabel'];
  set busyLabel(String value) { jsElement[r'busyLabel'] = value; }

  /// Event from this calendar decide whether the status is free/busy.
  String get calendarId => jsElement[r'calendarId'];
  set calendarId(String value) { jsElement[r'calendarId'] = value; }

  /// Label to be displayed if the status is free.
  String get freeLabel => jsElement[r'freeLabel'];
  set freeLabel(String value) { jsElement[r'freeLabel'] = value; }

  /// Displays the busy/free status. Use it to refresh label state
  displayBusy() =>
      jsElement.callMethod('displayBusy', []);
}
