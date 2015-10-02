/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_input_demo.html')
library polymer_elements_demo.web.paper_input.paper_input_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_input_container.dart';
import 'package:polymer_elements/paper_input_error.dart';
import 'package:polymer_elements/paper_input_char_counter.dart';
import 'package:polymer_elements/paper_textarea.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'ssn_input.dart';
import 'ssn_validator.dart';

/// Silence analyzer [PaperInput], [PaperInputContainer], [PaperInputError], [PaperInputCharCounter], [PaperTextarea], [IronInput], [IronIcon], [IronIcons], [PaperIconButton], [DemoElements], [SsnInput],
@PolymerRegister('paper-input-demo')
class PaperInputDemo extends PolymerElement {
  PaperInputDemo.created() : super.created();

  @eventHandler
  validate([_, __]) => $['inputForValidation'].validate();

  @eventHandler
  clearInput([_, __]) => $['inputWithButton'].value = '';
}
