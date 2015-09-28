/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_calendar_demo.html')
library polymer_elements_demo.web.google_calendar.google_calendar_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_signin.dart';
import 'package:polymer_elements/google_calendar.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleSignin], [GoogleCalendar], [DemoElements],
@PolymerRegister('google-calendar-demo')
class GoogleCalendarDemo extends PolymerElement {
  GoogleCalendarDemo.created() : super.created();

  @property String calendarId =
      "85rssq4g28omn1j1t8s4d4f06g@group.calendar.google.com";
}
