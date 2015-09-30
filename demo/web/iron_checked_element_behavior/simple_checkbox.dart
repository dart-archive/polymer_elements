/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('simple_checkbox.html')
library polymer_elements_demo.web.web.iron_checked_element_behavior.simple_checkbox;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer_elements/iron_checked_element_behavior.dart';
import 'package:polymer/polymer.dart';

/// Silence analyzer
@PolymerRegister('simple-checkbox')
class SimpleCheckbox extends PolymerElement with IronCheckedElementBehavior {
  SimpleCheckbox.created() : super.created();

  @property String label = 'not validated';

  @eventHandler
  onCheckTap([_, __]) => set('checked', $['checkbox'].checked);

  @eventHandler
  void onClick([_, __]) {
    validate();
    set('label', invalid ? 'is invalid' : 'is valid');
  }
}
