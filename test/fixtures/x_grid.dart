// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('x_grid.html')
library polymer_elements.test.fixtures.x_grid;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:web_components/web_components.dart';

/// Uses [IronFlexLayout] and [IronList]
@PolymerRegister('x-grid')
class XGrid extends PolymerElement {
  XGrid.created() : super.created();

  @property
  List data;

  @property
  int itemSize = 100;

  @property
  int listSize = 300;

  @property
  bool pre = false;

  get list => $['list'];

  @reflectable
  String computeItemSize(item) {
    var css = this.pre ? 'white-space:pre;' : '';
    css += 'height: ${this.itemSize}px;';
    css += 'width: ${this.itemSize}px;';
    return css;
  }

  @reflectable
  String computedListSize(listHeight) {
    return 'height: ${listHeight}px;width: ${listHeight}px;';
  }
}
