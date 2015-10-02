/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_tabs_demo.html')
library polymer_elements_demo.web.paper_tabs.paper_tabs_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_tab.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronFlexLayout], [PaperToolbar], [PaperTabs], [PaperTab], [DemoElements],
@PolymerRegister('paper-tabs-demo')
class PaperTabsDemo extends PolymerElement {
  PaperTabsDemo.created() : super.created();

  @property int selected;
}
