/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('x_puck.html')
library polymer_elements_demo.web.iron_resizable_behavior.x_puck;

import 'dart:async' show Future;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';

/// Silence analyzer [DemoElements],
@PolymerRegister('x-puck')
class XPuck extends PolymerElement with IronResizableBehavior {
  XPuck.created() : super.created();

  @property int x = 0;
  @property int y = 0;

  @override
  void attached() {
    new Future.delayed(const Duration(seconds: 1), notifyResize);
  }

  @Listen('iron-resize')
  void onIronResize([_, __]) {
    set('x', (domHost.offsetWidth / 3).floor());
    set('y', (domHost.offsetHeight / 3).floor());
    translate3d('${x}px', '${y}px', '0');
  }
}
