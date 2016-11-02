// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_chart_loader`.
@HtmlImport('google_chart_loader_nodart.html')
library polymer_elements.lib.src.google_chart.google_chart_loader;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'promise_polyfill.dart';
import 'charts_loader.dart';


@CustomElementProxy('google-chart-loader')
class GoogleChartLoader extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleChartLoader.created() : super.created();
  factory GoogleChartLoader() => new Element.tag('google-chart-loader');

  /// Adds packages to the list of packages to load.
  ///
  /// This is an array consisting of any Google Visualization package names.
  get packages => jsElement[r'packages'];
  set packages(value) { jsElement[r'packages'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Loads the package for the chart type specified.
  ///
  /// This may be any of the supported `google-chart` types.
  /// This is mainly used by the `google-chart` element internally.
  String get type => jsElement[r'type'];
  set type(String value) { jsElement[r'type'] = value; }

  /// Creates a chart object by type in the specified element.
  /// Use *only* if you need total control of a chart object.
  /// Most should just use the `google-chart` element.
  /// [type]: the type of chart to create
  /// [el]: the element in which to create the chart
  create(String type, el) =>
      jsElement.callMethod('create', [type, el]);

  /// Creates a DataTable object for use with a chart.
  ///
  /// Multiple different argument types are supported. This is because the
  /// result of loading the JSON data URL is fed into this function for
  /// DataTable construction and its format is unknown.
  ///
  /// The data argument can be one of a few options:
  ///
  /// - null/undefined: An empty DataTable is created. Columns must be added
  /// - !DataTable: The object is simply returned
  /// - {{cols: !Array, rows: !Array}}: A DataTable in object format
  /// - {{cols: !Array}}: A DataTable in object format without rows
  /// - !Array<!Array>: A DataTable in 2D array format
  ///
  /// Un-supported types:
  ///
  /// - Empty !Array<!Array>: (e.g. `[]`) While technically a valid data
  ///   format, this is rejected as charts will not render empty DataTables.
  ///   DataTables must at least have columns specified. An empty array is most
  ///   likely due to a bug or bad data. If one wants an empty DataTable, pass
  ///   no arguments.
  /// - Anything else
  ///
  /// See <a href="https://developers.google.com/chart/interactive/docs/reference#datatable-class">the docs</a> for more details.
  /// [data]: the data with which we should use to construct the new DataTable object
  dataTable(data) =>
      jsElement.callMethod('dataTable', [data]);

  /// Creates a DataView object from a DataTable for use with a chart.
  ///
  /// See <a href="https://developers.google.com/chart/interactive/docs/reference#dataview-class">the docs</a> for more details.
  /// [data]: the DataTable to use
  dataView(data) =>
      jsElement.callMethod('dataView', [data]);

  /// Begins firing Polymer events for the requested chart event.
  /// Use *only* if you have control of a chart object.
  /// Most should just use the `google-chart` element.
  ///
  /// Events fired all have the same detail object:
  ///   {{
  ///     chart: !Object,  // The chart target object
  ///     data: (Object|undefined),  // The chart event details
  ///   }}
  /// [chart]: the chart object to which we should listen
  /// [eventName]: the name of the chart event
  /// [opt_once]: whether to listen only one time
  fireOnChartEvent(chart, String eventName, opt_once) =>
      jsElement.callMethod('fireOnChartEvent', [chart, eventName, opt_once]);

  /// Creates a Query object to be sent to a DataSource protocol implementation.
  ///
  /// See <a href="https://developers.google.com/chart/interactive/docs/reference#query-classes">the docs</a> for more details.
  /// [url]: the URL of the DataSource protocol implementer
  /// [opt_options]: options for the Query object
  query(String url, opt_options) =>
      jsElement.callMethod('query', [url, opt_options]);
}
