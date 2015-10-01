/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_signals_demo.html')
library polymer_elements_demo.web.iron_signals.iron_signals_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/iron_signals.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperStyles], [IronSignals], [DemoElements],
@PolymerRegister('iron-signals-demo')
class IronSignalsDemo extends PolymerElement {
  IronSignalsDemo.created() : super.created();

  @property String detail;

  ready() =>
    fire('iron-signal', detail: convertToJs({'name': "foo", 'data': "Foo!"}));

  @eventHandler
  fooSignal(_, String detail) => set('detail', detail);
}
