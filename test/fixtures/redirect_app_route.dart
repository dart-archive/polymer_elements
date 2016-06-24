// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('redirect_app_route.html')
library polymer_elements.test.fixtures.redirect_app_route;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';
import 'package:polymer_elements/app_route.dart';
import 'package:polymer_elements/app_location.dart';

@PolymerRegister('redirect-app-route')
class RedirectAppRoute extends PolymerElement {
  RedirectAppRoute.created() : super.created();

  @Property(notify: true) var route;
  @Property(notify: true) var data;
  @Property(notify: true) var tail;

}
