/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('x_select.html')
library polymer_elements_demo.web.web.iron_dropdown.x_select;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_dropdown.dart';
import 'package:polymer_elements/neon_animation.dart';
import 'expand_animation.dart';

/// Silence analyzer [IronDropdown], [ExpandAnimation]
@PolymerRegister('x-select')
class XSelect extends PolymerElement {
  XSelect.created() : super.created();

  @property String verticalAlign;
  @property String horizontalAlign;
  @property bool disabled;
  @property List openAnimationConfig = [
    {
      'name': 'fade-in-animation',
      'timing': {'delay': 150, 'duration': 50}
    },
    {
      'name': 'expand-animation',
      'timing': {'delay': 150, 'duration': 200}
    }
  ];

  @property List closeAnimationConfig = [
    {
      'name': 'fade-out-animation',
      'timing': {'duration': 200}
    }
  ];

  @eventHandler
  open([_, __]) => ($['dropdown'] as IronDropdown).open();
}
