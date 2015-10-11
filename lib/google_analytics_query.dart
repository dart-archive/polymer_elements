// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_analytics_query`.
@HtmlImport('google_analytics_query_nodart.html')
library polymer_elements.lib.src.google_analytics.google_analytics_query;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_analytics_loader.dart';

/// Element for querying the Google Analytics Core Reporting API.
///
/// ##### Example
///
///     <google-analytics-query
///       ids="ga:1174"
///       metrics="ga:sessions"
///       dimensions="ga:country"
///       sort="-ga:sessions"
///       max-results="5">
///     </google-analytics-query>
@CustomElementProxy('google-analytics-query')
class GoogleAnalyticsQuery extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleAnalyticsQuery.created() : super.created();
  factory GoogleAnalyticsQuery() => new Element.tag('google-analytics-query');

  /// The `data` attribute is the response from a query to the Google
  /// Analytics Core Reporting API. This value will be updated as
  /// subsequent requests are made.
  get data => jsElement[r'data'];
  set data(value) { jsElement[r'data'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The `dimensions` attribute is a list of comma-separated dimensions
  /// for your Analytics data, such as ga:browser,ga:city.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#dimensions">Core Reporting API parameter reference</a> for more details.
  String get dimensions => jsElement[r'dimensions'];
  set dimensions(String value) { jsElement[r'dimensions'] = value; }

  /// The `endDate` attribute is the end date for fetching Analytics
  /// data. Requests can specify an end date formatted as YYYY-MM-DD, or
  /// as a relative date (e.g., today, yesterday, or NdaysAgo where N is a
  /// positive integer).
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#endDate">Core Reporting API parameter reference</a> for more details.
  String get endDate => jsElement[r'endDate'];
  set endDate(String value) { jsElement[r'endDate'] = value; }

  /// The `fields` attribute is a selector specifying a subset of
  /// fields to include in the response.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#fields">Core Reporting API parameter reference</a> for more details.
  String get fields => jsElement[r'fields'];
  set fields(String value) { jsElement[r'fields'] = value; }

  /// The `filters` attribute is dimension or metric filters that restrict
  /// the data returned for your request.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#filters">Core Reporting API parameter reference</a> for more details.
  String get filters => jsElement[r'filters'];
  set filters(String value) { jsElement[r'filters'] = value; }

  /// The `ids` attribute is the unique table ID of the form ga:XXXX,
  /// where XXXX is the Analytics view (profile) ID for which the query
  /// will retrieve the data.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#ids">Core Reporting API parameter reference</a> for more details.
  ///
  /// Note: you can find out the `ids` value for any of your Google Analytics account using the <a href="https://ga-dev-tools.appspot.com/explorer/">Google Analytics query explorer</a>.
  String get ids => jsElement[r'ids'];
  set ids(String value) { jsElement[r'ids'] = value; }

  /// true if data is getting loaded
  bool get loading => jsElement[r'loading'];
  set loading(bool value) { jsElement[r'loading'] = value; }

  /// The `maxResults` attribute is the maximum number of rows to include
  /// in the response.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#maxResults">Core Reporting API parameter reference</a> for more details.
  num get maxResults => jsElement[r'maxResults'];
  set maxResults(num value) { jsElement[r'maxResults'] = value; }

  /// The `metrics` attribute is a list of comma-separated metrics,
  /// such as ga:sessions,ga:bounces.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#metrics">Core Reporting API parameter reference</a> for more details.
  String get metrics => jsElement[r'metrics'];
  set metrics(String value) { jsElement[r'metrics'] = value; }

  /// The `output` attribute sets the desired output type for the
  /// Analytics data returned in the response. Acceptable values are json
  /// and dataTable.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#output">Core Reporting API parameter reference</a> for more details.
  String get output => jsElement[r'output'];
  set output(String value) { jsElement[r'output'] = value; }

  /// The `samplingLevel` attribute sets the desired sampling level.
  /// Allowed Values: `DEFAULT`, `FASTER`, `HIGHER_PRECISION`.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#samplingLevel">Core Reporting API parameter reference</a> for more details.
  String get samplingLevel => jsElement[r'samplingLevel'];
  set samplingLevel(String value) { jsElement[r'samplingLevel'] = value; }

  /// The `segment` attribute segments the data returned for your
  /// request.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#segment">Core Reporting API parameter reference</a> for more details.
  String get segment => jsElement[r'segment'];
  set segment(String value) { jsElement[r'segment'] = value; }

  /// True if setup is ready
  bool get setupReady => jsElement[r'setupReady'];
  set setupReady(bool value) { jsElement[r'setupReady'] = value; }

  /// The `sort` attribute is a list of comma-separated dimensions
  /// and metrics indicating the sorting order and sorting direction for
  /// the returned data.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#sort">Core Reporting API parameter reference</a> for more details.
  String get sort => jsElement[r'sort'];
  set sort(String value) { jsElement[r'sort'] = value; }

  /// The `startDate` attribute is the start date for fetching Analytics
  /// data. Requests can specify a start date formatted as YYYY-MM-DD, or
  /// as a relative date (e.g., today, yesterday, or NdaysAgo where N is a
  /// positive integer).
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#startDate">Core Reporting API parameter reference</a> for more details.
  String get startDate => jsElement[r'startDate'];
  set startDate(String value) { jsElement[r'startDate'] = value; }

  /// The `startIndex` attribute sets the first row of data to retrieve,
  /// starting at 1. Use this parameter as a pagination mechanism along
  /// with the max-results parameter.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#startIndex">Core Reporting API parameter reference</a> for more details.
  num get startIndex => jsElement[r'startIndex'];
  set startIndex(num value) { jsElement[r'startIndex'] = value; }

  /// Query the Google Analytics Core Reporting API.
  getData() =>
      jsElement.callMethod('getData', []);

  getDataResponseHandler() =>
      jsElement.callMethod('getDataResponseHandler', []);

  /// The callback for the query run in `getData`. This is a separate
  /// function so subclasses can alter how the response is handled.
  handleResponse(response) =>
      jsElement.callMethod('handleResponse', [response]);

  /// setData sets data fetched by getData.
  /// Use it if you override getData response processing
  setData(data) =>
      jsElement.callMethod('setData', [data]);
}
