// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_analytics_chart`.
@HtmlImport('google_analytics_chart_nodart.html')
library polymer_elements.lib.src.google_analytics.google_analytics_chart;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_chart.dart';
import 'google_analytics_query.dart';
import 'google_analytics_loader.dart';

/// Element for displaying the results of a Google Analytics query in a
/// Google Chart.
///
/// ##### Example
///
///     <google-analytics-chart
///       type="column"
///       ids="ga:1174"
///       metrics="ga:sessions"
///       dimensions="ga:country"
///       sort="-ga:sessions"
///       max-results="5">
///     </google-analytics-chart>
@CustomElementProxy('google-analytics-chart')
class GoogleAnalyticsChart extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleAnalyticsChart.created() : super.created();
  factory GoogleAnalyticsChart() => new Element.tag('google-analytics-chart');

  get data => jsElement[r'data'];
  set data(value) { jsElement[r'data'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  String get dimensions => jsElement[r'dimensions'];
  set dimensions(String value) { jsElement[r'dimensions'] = value; }

  String get endDate => jsElement[r'endDate'];
  set endDate(String value) { jsElement[r'endDate'] = value; }

  String get filters => jsElement[r'filters'];
  set filters(String value) { jsElement[r'filters'] = value; }

  String get ids => jsElement[r'ids'];
  set ids(String value) { jsElement[r'ids'] = value; }

  /// True if the chart is currently loading data.
  bool get loading => jsElement[r'loading'];
  set loading(bool value) { jsElement[r'loading'] = value; }

  num get maxResults => jsElement[r'maxResults'];
  set maxResults(num value) { jsElement[r'maxResults'] = value; }

  String get metrics => jsElement[r'metrics'];
  set metrics(String value) { jsElement[r'metrics'] = value; }

  /// Sets the options for the chart.
  ///
  /// Example:
  /// <pre>{
  ///   title: "Chart title goes here",
  ///   hAxis: {title: "Categories"},
  ///   vAxis: {title: "Values", minValue: 0, maxValue: 2},
  ///   legend: "none"
  /// };</pre>
  /// See <a href="https://google-developers.appspot.com/chart/interactive/docs/gallery">Google Visualization API reference (Chart Gallery)</a>
  /// for the options available to each chart type.
  get options => jsElement[r'options'];
  set options(value) { jsElement[r'options'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// True after the chart has been rendered for the first time.
  bool get rendered => jsElement[r'rendered'];
  set rendered(bool value) { jsElement[r'rendered'] = value; }

  String get samplingLevel => jsElement[r'samplingLevel'];
  set samplingLevel(String value) { jsElement[r'samplingLevel'] = value; }

  String get segment => jsElement[r'segment'];
  set segment(String value) { jsElement[r'segment'] = value; }

  /// True if setup is ready
  bool get setupReady => jsElement[r'setupReady'];
  set setupReady(bool value) { jsElement[r'setupReady'] = value; }

  String get sort => jsElement[r'sort'];
  set sort(String value) { jsElement[r'sort'] = value; }

  /// google-analytics-query passthrough properties
  /// See google-analytics-query for documentation
  /// startDate, endDate, data, ids, metrics, dimensions, sort, filters, segment, samplingLevel, startIndex, maxResults
  String get startDate => jsElement[r'startDate'];
  set startDate(String value) { jsElement[r'startDate'] = value; }

  num get startIndex => jsElement[r'startIndex'];
  set startIndex(num value) { jsElement[r'startIndex'] = value; }

  /// Sets the type of the chart.
  ///
  /// Should be one of:
  /// - `area`, `bar`, `column`, `line`, `pie`, `geo`.
  String get type => jsElement[r'type'];
  set type(String value) { jsElement[r'type'] = value; }

  handleResponse(response) =>
      jsElement.callMethod('handleResponse', [response]);

  setupReadyChanged(newVal, oldVal) =>
      jsElement.callMethod('setupReadyChanged', [newVal, oldVal]);
}
