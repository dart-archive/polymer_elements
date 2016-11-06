// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.google_chart_test;

import 'dart:async';
import 'package:polymer_elements/google_chart.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<google-chart>', () {
    GoogleChart chart;

    setUp(() {
      chart = fixture('test-chart');
    });

    test('fires google-chart-render event for initial load', () {
      var done = new Completer();
      chart.on['google-chart-ready'].take(1).listen((event) {
        event = convertToDart(event);
        expect(event.detail, isNotNull);
        done.complete();
      });
      return done.future;
    });

    test('fires google-chart-render event for drawChart call', () {
      var done = new Completer();
      chart.on['google-chart-ready'].take(1).listen((event) {
        event = convertToDart(event);
        expect(event.detail, isNotNull);
        done.complete();
      });
      chart.redraw(); // drawChart is no more public ? Using redraw
      return done.future;
    });

    test('default type is column', () {
      expect(chart.type, 'column');
    });

    test('specified properties have the correct values', () {
      expect(chart.cols, isNotNull);
      expect(chart.cols.length, greaterThan(0));
      expect(chart.cols[0]['label'], 'Data');
      expect(chart.cols[0]['type'], 'string');
      expect(chart.cols.length, greaterThan(1));
      expect(chart.cols[1]['label'], 'Value');
      expect(chart.cols[1]['type'], 'number');

      expect(chart.rows, isNotNull);
      expect(chart.rows.length, greaterThan(0));
      expect(chart.rows[0].length, greaterThan(0));
      expect(chart.rows[0][0], 'Something');
      expect(chart.rows[0].length, greaterThan(1));
      expect(chart.rows[0][1], 1);
    });
  });
}
