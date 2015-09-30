/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_fit_behavior_demo.html')
library polymer_elements_demo.web.iron_fit_behavior.iron_fit_behavior_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'simple_fit.dart';

/// Silence analyzer [DemoElements], [SimpleFit],
@PolymerRegister('iron-fit-behavior-demo')
class IronFitBehaviorDemo extends PolymerElement {
  IronFitBehaviorDemo.created() : super.created();
}
