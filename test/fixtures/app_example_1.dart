// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('app_example_1.html')
library polymer_elements.test.fixtures.app_example_1;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';
import 'package:polymer_elements/app_route.dart';
import 'package:polymer_elements/app_location.dart';

@PolymerRegister('app-example-1')
class AppExample1 extends PolymerElement {
  AppExample1.created() : super.created();

  @property
  var data;
  @property
  var userRoute;
  @property
  var userData;
  @property
  var route;
  @property
  var userQueryParams;

  AppRoute get page => $['page'];
  AppRoute get user => $['user'];
  AppRoute get tail => $['tail'];

  @Observe('data.page')
  pageChanged(page) {
    if (page == 'redirectToUser') {
      this.set('data.page', 'user');
    }
  }

  @Observe('userRoute.path')
  userPathChanged(path) {
    // Redirect from /user/ and /user to /user/view
    if (path == '/' || path == '') {
      this.set('userRoute.path', '/view');
    }
  }
}
