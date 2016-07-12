// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('x_scrollable_element.html')
library polymer_elements.test.fixtures.x_list;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';

@PolymerRegister('x-scrollable-element')
class XScrollableElement extends PolymerElement {
  XScrollableElement.created() : super.created();

  DivElement get childOne=> new PolymerDom(this.root).querySelector("#ChildOne");

  DivElement get grandchildOne=> new PolymerDom(this.root).querySelector("#GrandchildOne");

  DivElement get childTwo=> new PolymerDom(this.root).querySelector("#ChildTwo");

  DivElement get grandchildTwo=> new PolymerDom(this.root).querySelector("#GrandchildTwo");

}
