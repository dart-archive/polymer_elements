// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_icon_test;

import 'dart:html';
import 'dart:js';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/carbon_route_converter.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:async';


main() async {
  await initWebComponents();

  group('<carbon-route-converter>', () {
    test('it bidirectionally maps path and queryParams to route', () {
      var converter = fixture('BasicRouteConversion');

      var queryParams = new JsObject.jsify({'x': '10'});
      converter.path = '/a/b/c';
      converter.queryParams = queryParams;

      expect(converter.route['prefix'],'');

      expect(converter.route['path'],'/a/b/c');


      expect(converter.route['__queryParams']['x'],'10');

      converter.set('route.path', '/d/e/f');
      expect(converter.path, '/d/e/f');

      queryParams = new JsObject.jsify({'y': '11'});
      converter.set('route.__queryParams', queryParams);
      expect(converter.queryParams['y'], '11');

      queryParams['z'] = '12';
      expect(converter.queryParams['z'], '12');
    });
  });
}
