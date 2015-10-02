/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_dialog_demo.html')
library polymer_elements_demo.web.paper_dialog.paper_dialog_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_dialog.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_dialog_scrollable.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/neon_animation/animations/scale_up_animation.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperDialog], [PaperButton], [PaperDialogScrollable], [PaperStyles], [NeonAnimations], [PaperDropdownMenu], [PaperMenu], [PaperItem], [DemoElements],
@PolymerRegister('paper-dialog-demo')
class PaperDialogDemo extends PolymerElement {
  PaperDialogDemo.created() : super.created();

  @eventHandler
  void openDialog(dom.Event event, [_]) {
    var id = ((Polymer.dom(event) as PolymerEvent).localTarget as dom.Element)
        .dataset['dialog'];
    var dialog = $[id];
    if (dialog != null) {
      dialog.open();
    }
  }
}
