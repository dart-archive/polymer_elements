/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('simple_dialog.html')
library polymer_elements_demo.web.web.paper_dialog_behavior.simple_dialog;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_dialog_behavior.dart';
import 'package:polymer_elements/iron_overlay_behavior.dart';
import 'package:polymer_elements/iron_fit_behavior.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';

/// Silence analyzer
@PolymerRegister('simple-dialog')
class SimpleDialog extends PolymerElement
    with
        IronFitBehavior,
        IronResizableBehavior,
        IronOverlayBehavior,
        PaperDialogBehavior {
  SimpleDialog.created() : super.created();
}
