/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_ajax_demo.html')
library polymer_elements_demo.web.iron_ajax.iron_ajax_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_ajax.dart';
import 'package:polymer_elements/iron_image.dart';
import 'package:polymer_elements/typography.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';


/// Silence analyzer [IronAjax], [IronImage], [Typography], [IronFlexLayout],
/// [DemoElements]
@PolymerRegister('iron-ajax-demo')
class IronAjaxDemo extends PolymerElement {
  IronAjaxDemo.created() : super.created();

  @property var ajaxResponse;

  @reflectable
  computeUrl(String videoId) =>
    'https://www.youtube.com/watch?v=${videoId}';
}
