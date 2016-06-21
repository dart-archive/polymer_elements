// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('cats_only.html')
library polymer_elements.test.fixtures.cats_only;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_validatable_behavior.dart';
import 'dart:html';

@CustomElementProxy('cats-only')
class CatsOnly extends HtmlElement with CustomElementProxyMixin,PolymerBase,IronValidatableBehavior {
  CatsOnly.created() : super.created();


}
