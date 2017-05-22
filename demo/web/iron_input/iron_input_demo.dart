/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_input_demo.html')
library polymer_elements_demo.web.iron_input.iron_input_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronInput], [PaperStyles], [DemoElements],
@PolymerRegister('iron-input-demo')
class IronInputDemo extends PolymerElement {
  IronInputDemo.created() : super.created();

  @property String bindValue;
  @property String value;
  @property String bindValueInput;
  @property String valueInput;

  @reflectable setBindValue([_, __]) =>
      set('bindValue', bindValueInput);

  @reflectable setValue([_, __]) =>
      set('value', valueInput);
}
