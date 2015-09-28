/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_map_demo.html')
library polymer_elements_demo.web.google_map.google_map_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_map.dart';
import 'package:polymer_elements/google_map_marker.dart';
import 'package:polymer_elements/google_map_directions.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleMap], [GoogleMapMarker], [GoogleMapDirections], [DemoElements],
@PolymerRegister('google-map-demo')
class GoogleMapDemo extends PolymerElement {
  GoogleMapDemo.created() : super.created();

  @eventHandler
  void apiLoad(dom.CustomEvent event, [_]) {
    ($['directions'] as GoogleMapDirections).map = event.detail.map;
  }

  @eventHandler
  void toggleControls([_, __]) {
    $['map'].disableDefaultUi = !$['map'].disableDefaultUi;
  }
}
