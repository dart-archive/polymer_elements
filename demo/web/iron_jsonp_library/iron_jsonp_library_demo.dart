/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_jsonp_library_demo.html')
library polymer_elements_demo.web.iron_jsonp_library.iron_jsonp_library_demo;

import 'dart:async' show Future;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/paper_spinner.dart';
import 'package:polymer_elements/iron_jsonp_library.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperStyles], [PaperSpinner], [IronJsonpLibrary], [DemoElements],
@PolymerRegister('iron-jsonp-library-demo')
class IronJsonpLibraryDemo extends PolymerElement {
  IronJsonpLibraryDemo.created() : super.created();

  @property bool loaded1 = false;
  @property String errorMessage1;
  @property bool loaded2 = false;
  @property String errorMessage2;
  @property bool loaded3 = false;
  @property String errorMessage3;
  @property String libraryUrl3;

  // kick off delayed loader by setting libraryUrl
  ready() {
    new Future.delayed(const Duration(seconds: 1), () {
      set('libraryUrl3',
          'https://apis.google.com/js/drive-realtime.js?onload=%%callback%%');
    });
  }
}
