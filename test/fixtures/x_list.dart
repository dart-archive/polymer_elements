// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('x_list.html')
library polymer_elements.test.fixtures.x_list;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:web_components/web_components.dart';

/// Uses [IronFlexLayout] and [IronList]
@PolymerRegister('x-list')
class XList extends PolymerElement {
  XList.created() : super.created();

  @property
  List data;

  @property
  int itemHeight = 100;

  @property
  int listHeight = 300;

  get list => $['list'];

  @reflectable
  String computedItemHeight() => 'height: ${itemHeight}px';

  @reflectable
  String computedListHeight(listHeight) => 'height: ${listHeight}px';
}
