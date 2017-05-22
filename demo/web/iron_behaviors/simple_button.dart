/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('simple_button.html')
library polymer_elements_demo.web.web.iron_behaviors.simple_button;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';

/// Silence analyzer
@PolymerRegister('simple-button')
class SimpleButton extends PolymerElement
    with IronControlState, IronA11yKeysBehavior, IronButtonState {
  SimpleButton.created() : super.created();

  static const hostAttributes = const {'role': 'button',};
}
