/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_chart_demo.html')
library polymer_elements_demo.web.google_chart.google_chart_demo;

import 'dart:async' show Timer;
import 'dart:html' as dom;
import 'dart:math' show Random;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_chart.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleChart], [DemoElements],
@PolymerRegister('google-chart-demo')
class GoogleChartDemo extends PolymerElement {
  GoogleChartDemo.created() : super.created();

  void ready() {
    // `drawChart()` needs to be called when the window was resized to update
    // the charts
    var media = dom.window.matchMedia('(min-width: 1024px)');
    media.addListener(([_]) {
      ($['resizing_chart'] as GoogleChart).drawChart();
    });

    // update data of the `mutating_chart` chart
    new Timer.periodic(const Duration(seconds: 3), (_) {
      var chart = $['mutating_chart'] as GoogleChart;

      chart.rows = [
        ["Col1", _getRandomValue()],
        ["Col2", _getRandomValue()],
        ["Col3", _getRandomValue()]
      ];
    });

    // update data of the `mutating_gauge` chart
    new Timer.periodic(const Duration(seconds: 3), (_) {
      var gauge = $['mutating_gauge'] as GoogleChart;

      gauge.data = [
        ["Label", "Value"],
        ["Memory", _getRandomGaugeValue(40, 60)],
        ["CPU", _getRandomGaugeValue(40, 60)],
        ["Network", _getRandomGaugeValue(60, 20)]
      ];
    });

    on['google-chart-select'].listen((_) {
      var chart = $['selection-chart'] as GoogleChart;
      $['selection-label'].textContent =
          chart.selection[0] != null ? chart.selection[0].row : 'None';
    });
  }

  double _getRandomValue() => new Random().nextDouble() * 10;

  double _getRandomGaugeValue(offset, factor) =>
      offset + factor * new Random().nextDouble();

  @reflectable
  void selectionDemoChartRender([_, __]) {
    var chart = $['selection-chart'] as GoogleChart;
    chart.selection = [
      {'row': 1, 'column': null}
    ];
    $['selection-label'].textContent = chart.selection[0].row;
  }
}
