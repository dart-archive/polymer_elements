/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
//@HtmlImport('simple_form.html')
library polymer_elements_demo.web.web.iron_form_element_behavior.simple_form;

import 'dart:html' as dom;
//import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

/// Silence analyzer
@PolymerRegister('simple-form', extendsTag: 'form')
class SimpleForm extends dom.FormElement
    with PolymerMixin, PolymerBase, JsProxy {
  SimpleForm.created() : super.created();

  @Property(notify: true) List formElements = [];

  @Listen('iron-form-element-register')
  void elementRegistered(dom.CustomEvent event, [_]) {
    add('formElements', event.target);
    event.target['parentForm'] = this;
  }

  @Listen('iron-form-element-unregister')
  void elementUnregistered(dom.CustomEvent event, [_]) {
    var target = event.detail.target;
    if (target != null) {
      var index = this.formElements.indexOf(target);
      if (index > -1) {
        removeAt('formElements', index);
      }
    }
  }
}
