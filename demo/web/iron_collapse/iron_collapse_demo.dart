/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_collapse_demo.html')
library polymer_elements_demo.web.iron_collapse.iron_collapse_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_collapse.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronCollapse], [DemoElements],
@PolymerRegister('iron-collapse-demo')
class IronCollapseDemo extends PolymerElement {
  IronCollapseDemo.created() : super.created();
  @property bool opened1 = false;
  @property bool opened2 = false;
  @property bool opened3 = false;

  @eventHandler
  void toggle([dom.Event event, __]) =>
      ($[(event.target as dom.HtmlElement).dataset['target']] as IronCollapse)
          .toggle();

  @eventHandler
  String isExpanded(bool opened) => '${opened}';
}
