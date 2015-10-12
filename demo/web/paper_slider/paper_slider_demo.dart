/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_slider_demo.html')
library polymer_elements_demo.web.paper_slider.paper_slider_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_slider.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [PaperSlider], [DemoElements],
@PolymerRegister('paper-slider-demo')
class PaperSliderDemo extends PolymerElement {
  PaperSliderDemo.created() : super.created();

  PaperSlider get ratings => $['ratings'];

  @reflectable
  ratingsChanged([_, __]) =>
      // TODO(zoechi) change vvv to `ratings.value` when #74 is fixd
      $['ratingsLabel']?.text = '${_toNum(ratings.jsElement['value'])}';

  // TODO(zoechi) remove when ratings.value behaves properly #74
  num _toNum(val) {
    if (val is num) {
      return val;
    }
    if (val == null) {
      return 0;
    }
    if (val is! String) {
      throw ('Can\'t convert "${val}" to num.');
    }
    return num.parse(val);
  }
}
