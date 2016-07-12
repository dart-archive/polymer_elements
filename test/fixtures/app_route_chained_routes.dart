// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('app_route_chained_routes.html')
library polymer_elements.test.fixtures.app_chained_routes;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';
import 'package:polymer_elements/app_route.dart';
import 'package:polymer_elements/app_location.dart';

@PolymerRegister('chained-routes')
class AppChainedRoutes extends PolymerElement {
  AppChainedRoutes.created() : super.created();

  @Property(notify:true) var numberOneTopRoute;
  @Property(notify:true) var fooData;
  @Property(notify:true) var fooRoute;

  @Property(notify:true) var barData;

  @Property(notify:true) var bazData;

  AppRoute get foo => $['foo'];
  AppRoute get bar => $['bar'];
  AppRoute get baz => $['baz'];



}
