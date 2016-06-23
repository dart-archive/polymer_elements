// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_route_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'package:polymer_elements/app_route.dart';
// ignore: UNUSED_IMPORT
import 'fixtures/redirect_app_route.dart';

import 'fixtures/app_route_chained_routes.dart';
import 'package:polymer_elements/app_route_converter.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  suite('<app-route-converter>', () {
    test('it bidirectionally maps path and queryParams to route', () {
      AppRouteConverter converter = fixture('BasicRouteConversion');

      var queryParams = {'x': '10'};
      converter.path = '/a/b/c';
      converter.queryParams = queryParams;

      $expect(converter.route).to.be.deep.equal({'prefix': '', 'path': '/a/b/c', '__queryParams': queryParams});

      converter.set('route.path', '/d/e/f');
      $expect(converter.path).to.be.equal('/d/e/f');

      queryParams = {'y': '11'};
      converter.set('route.__queryParams', queryParams);
      $expect(converter.queryParams).to.be.deep.equal(queryParams);

      queryParams['z'] = '12';
      $expect(converter.queryParams).to.be.deep.equal(queryParams);
    });
  });
}
