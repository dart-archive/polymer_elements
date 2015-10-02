/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_dialog_behavior_demo.html')
library polymer_elements_demo.web.paper_dialog_behavior.paper_dialog_behavior_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_dialog_scrollable.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'simple_dialog.dart';
import 'package:polymer_elements/paper_dialog_behavior.dart';
import 'package:polymer_elements/paper_dialog.dart';

/// Silence analyzer [PaperButton], [PaperDialogScrollable], [DemoElements], [SimpleDialog], [PaperDialog]
@PolymerRegister('paper-dialog-behavior-demo')
class PaperDialogBehaviorDemo extends PolymerElement {
  PaperDialogBehaviorDemo.created() : super.created();

  @eventHandler
  void openDialog(dom.Event event, [_]) {
    var id = ((Polymer.dom(event) as PolymerEvent).localTarget as dom.Element)
        .dataset['dialog'];
    PaperDialogBehavior dialog = $[id];
    if (dialog != null) {
      dialog.toggle();
      var button = (event.target as dom.Element);
      if (dialog.opened) {
        button.attributes['data-dialog-opened'] = dialog.opened.toString();
      } else {
        button.attributes.remove('data-dialog-opened');
      }
    }
  }
}
