/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_spinner_demo.html')
library polymer_elements_demo.web.paper_spinner.paper_spinner_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_spinner.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperSpinner], [DemoElements],
@PolymerRegister('paper-spinner-demo')
class PaperSpinnerDemo extends PolymerElement {
  PaperSpinnerDemo.created() : super.created();

  @reflectable
  toggle1(dom.Event event, [_]) => _toggleGroup('group1');

  @reflectable
  toggle2(dom.Event event, [_]) => _toggleGroup('group2');

  void _toggleGroup(String id) => $[id].querySelectorAll('paper-spinner').forEach((s) => s.active =! s.active);
}
