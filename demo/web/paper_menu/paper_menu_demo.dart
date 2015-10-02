/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_menu_demo.html')
library polymer_elements_demo.web.paper_menu.paper_menu_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/iron_collapse.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_submenu.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperItem], [IronCollapse], [PaperMenu], [PaperSubmenu], [DemoElements],
@PolymerRegister('paper-menu-demo')
class PaperMenuDemo extends PolymerElement {
  PaperMenuDemo.created() : super.created();
}
