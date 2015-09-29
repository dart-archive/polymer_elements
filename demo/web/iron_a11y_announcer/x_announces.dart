/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('x_announces.html')
library polymer_elements_demo.web.web.iron_a11y_announcer.x_announces;

import 'dart:html' as dom;
import 'dart:js' as js;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
//import 'package:polymer_elements/iron_a11y_announcer.dart';
import 'package:polymer_elements/paper_button.dart';

/// Silence analyzer [IronA11yAnnouncer], [PaperButton]
@PolymerRegister('x-announces')
class XAnnounces extends PolymerElement {
  XAnnounces.created() : super.created();

  @override
  void attached() {
    js.context['Polymer']['IronA11yAnnouncer']
        .callMethod('requestAvailability', []);
  }

  @eventHandler
  void onTapAnnounce([_, __]) {
    fire('iron-announce',
        detail: convertToJs({'text': ($['content'] as dom.Element).text}),
        canBubble: true);
  }
}
