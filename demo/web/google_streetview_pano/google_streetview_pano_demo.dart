/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_streetview_pano_demo.html')
library polymer_elements_demo.web.google_streetview_pano.google_streetview_pano_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_streetview_pano.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleStreetviewPano], [DemoElements]
@PolymerRegister('google-streetview-pano-demo')
class GoogleStreetviewPanoDemo extends PolymerElement {
  GoogleStreetviewPanoDemo.created() : super.created();

  GoogleStreetviewPano get _pano => $['pano'];

  @eventHandler
  void showMachu([_, __]) {
    _pano.heading = 330;
    _pano.pitch = -2;
    _pano.zoom = 0.8;
    _pano.panoId = 'VsCKIVGfvpEAAAQJKfdW1w';
  }

  @eventHandler
  void showBrazil([_, __]) {
    _pano.heading = 210;
    _pano.pitch = 15;
    _pano.zoom = 0.2;
    _pano.panoId = 'CkmCkfwvIGUAAAQW-qy0KQ';
  }

  @eventHandler
  void showStatue([_, __]) {
    _pano.heading = 80;
    _pano.pitch = 7;
    _pano.zoom = 0.2;
    _pano.panoId = 'pVFRQcvJ2IEAAAGuvUxa_w';
  }
}
