/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_resizable_behavior_demo.html')
library polymer_elements_demo.web.iron_resizable_behavior.iron_resizable_behavior_demo;

import 'dart:html' as dom;
import 'dart:async' show Future;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'x_puck.dart';

/// Silence analyzer [DemoElements], [XPuck]
@PolymerRegister('iron-resizable-behavior-demo')
class IronResizableBehaviorDemo extends PolymerElement with IronResizableBehavior {
  IronResizableBehaviorDemo.created() : super.created();
}
