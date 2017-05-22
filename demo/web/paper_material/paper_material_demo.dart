/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_material_demo.html')
library polymer_elements_demo.web.paper_material.paper_material_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/typography.dart';
import 'package:polymer_elements/paper_material.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronFlexLayout], [Typography], [PaperMaterial], [DemoElements],
@PolymerRegister('paper-material-demo')
class PaperMaterialDemo extends PolymerElement {
  PaperMaterialDemo.created() : super.created();

  @reflectable
  void tapAction (dom.Event event, [_]) {
    PaperMaterial target = (Polymer.dom(event) as PolymerEvent).localTarget;
    if (!target.attributes.containsKey('down')) {
      target.elevation += 1;
      if (target.elevation == 5) {
        target.attributes['down'] = true.toString();
      }
    } else {
      target.elevation -= 1;
      if (target.elevation == 0) {
        target.attributes.remove('down');
      }
    }
  }

}
