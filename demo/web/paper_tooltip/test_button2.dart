/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('test_button2.html')
library polymer_elements_demo.web.web.paper_tooltip.test_button2;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

/// Silence analyzer
/// Note added name suffix `2` to disambiguate with the same name in
///   paper_badge_demo/test_button
@PolymerRegister('test-button2')
class TestButton2 extends PolymerElement {
  TestButton2.created() : super.created();
}
