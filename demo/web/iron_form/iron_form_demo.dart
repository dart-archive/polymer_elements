/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_form_demo.html')
library polymer_elements_demo.web.iron_form.iron_form_demo;

import 'dart:convert' show JSON;
import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/iron_form.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'simple_element.dart';

/// Silence analyzer [PaperInput], [PaperButton], [PaperStyles], [PaperCheckbox], [IronForm], [DemoElements], [SimpleElement],
@PolymerRegister('iron-form-demo')
class IronFormDemo extends PolymerElement {
  IronFormDemo.created() : super.created();

  @property String output;

  @reflectable
  display(dom.CustomEvent event, [_]) =>
      set('output', JSON.encode(event.detail));

  @reflectable
  void clickHandler(dom.Event event, [_]) {
    (((Polymer.dom(event) as PolymerEvent).localTarget as dom.Element).parent
        as dom.FormElement).submit();
  }
}
