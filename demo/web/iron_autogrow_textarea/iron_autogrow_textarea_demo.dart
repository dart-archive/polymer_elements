/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_autogrow_textarea_demo.html')
library polymer_elements_demo.web.iron_autogrow_textarea.iron_autogrow_textarea_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_autogrow_textarea.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronAutogrowTextarea], [DemoElements]
@PolymerRegister('iron-autogrow-textarea-demo')
class IronAutogrowTextareaDemo extends PolymerElement {
  IronAutogrowTextareaDemo.created() : super.created();

  @property String bindValue;
  @property String textArea1;
  @property String textArea2;

  @eventHandler
  bindValueClick([_, __]) => set('bindValue', textArea1);

  @eventHandler
  valueClick([_, __]) =>
      (($['agta'] as IronAutogrowTextarea).textarea as dom.TextAreaElement)
          .value = textArea2;
}
