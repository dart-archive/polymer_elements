/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_image_demo.html')
library polymer_elements_demo.web.iron_image.iron_image_demo;

import 'dart:html' as dom;
import 'dart:math' show Random;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_image.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronImage], [DemoElements],
@PolymerRegister('iron-image-demo')
class IronImageDemo extends PolymerElement {
  IronImageDemo.created() : super.created();

  @property var loading2a;
  @property var loading2aFade;
  @property var loading2b;
  @property var loading2bFade;
  @property var loading2c;
  @property var loading2cFade;
  @property var loading3a;
  @property var loading3aFade;
  @property var loading3b;
  @property var loading3bFade;
  @property var loading3c;
  @property var loading3cFade;

  final Random _rnd = new Random();
  @eventHandler preload(dom.Event event, [_]) {
    var id = (event.target as dom.Element).attributes['target'];
    var img = $[id] as IronImage;
    img.src = './polymer.svg?${_rnd.nextDouble()}';
    (event.target as dom.Element).text = 'Reload image';
  }
}
