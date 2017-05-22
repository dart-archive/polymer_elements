/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('firebase_element_demo.html')
library polymer_elements.demo.web.firebase_element.firebase_element_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:polymer_elements/firebase_collection.dart';
import 'package:polymer_elements/firebase_document.dart';
import 'x_pretty_json.dart';
import 'x_login.dart';

/// Silence analyzer [FirebaseCollection], [FirebaseDocument], [XPrettyJson],
/// [XLogin], [DemoElements]
@PolymerRegister('firebase-element-demo')
class FirebaseElementDemo extends PolymerElement {
  FirebaseElementDemo.created() : super.created();

  @property var dinosaursByHeight;
  @property var dinosaursScores;
}
