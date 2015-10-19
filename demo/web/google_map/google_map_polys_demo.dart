/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_map_polys_demo.html')
library polymer_elements_demo.web.google_map.google_map_polys_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_map.dart';
import 'package:polymer_elements/google_map_marker.dart';
import 'package:polymer_elements/google_map_poly.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleMap], [GoogleMapMarker], [GoogleMapPoly], [GoogleMapDirections], [DemoElements],
@PolymerRegister('google-map-polys-demo')
class GoogleMapPolysDemo extends PolymerElement {
  GoogleMapPolysDemo.created() : super.created();

  const editingButtonCaptionEnabled = 'Disable editing';
  const editingButtonCaptionDisabled = 'Enable editing';

  GoogleMapPoly get _poly => $$('google-map-poly');


  @property
  String toggleEditButtonCaption = editingButtonCaptionEnabled;

  @reflectable
  void toggleEdit([_, __]) {
    poly.editable = !poly.editable;
    set('toggleEditButtonCaption', poly.editable ? editingButtonCaptionEnabled : editingButtonCaptionDisabled);

  }
}
