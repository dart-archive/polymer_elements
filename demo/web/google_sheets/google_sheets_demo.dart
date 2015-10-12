/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_sheets_demo.html')
library polymer_elements_demo.web.google_sheets.google_sheets_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/google_sheets.dart';
import 'package:polymer_elements/google_map.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronFlexLayout], [GoogleSheets], [GoogleMap], [DemoElements],
@PolymerRegister('google-sheets-demo')
class GoogleSheetsDemo extends PolymerElement {
  GoogleSheetsDemo.created() : super.created();

  @property List rows;
  @property var tab;
  @property int tabId = 1;
  @property String openInGoogleDocsUrl;

  @reflectable
  void useTab(dom.Event event, [_]) {
    set('tabId',
        int.parse((event.currentTarget as dom.Element).dataset['tabid']));
  }
}
