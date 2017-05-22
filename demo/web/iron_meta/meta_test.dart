/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
library polymer_elements_demo.web.iron_meta.meta_test;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_meta.dart';
//import 'package:polymer_elements/iron_meta.dart';

/// Silence analyzer [IronMeta],
@PolymerRegister('meta-test')
class MetaTest extends PolymerElement {
  MetaTest.created() : super.created();

  void ready() {
    this.text = new IronMetaQuery().byKey('info');
  }
}
