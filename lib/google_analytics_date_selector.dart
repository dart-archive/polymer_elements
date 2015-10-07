// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_analytics_date_selector`.
@HtmlImport('google_analytics_date_selector_nodart.html')
library polymer_elements.lib.src.google_analytics.google_analytics_date_selector;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Element for selecting the start and end date values for queries inside a
/// `<google-analytics-dashboard>` element.
///
/// ##### Example
///
///     <google-analytics-dashboard>
///
///       <google-analytics-date-selector
///         start-date="30daysAgo"
///         end-date="today">
///       </google-analytics-date-selector>
///
///       <google-analytics-chart
///         ids="ga:1174"
///         metrics="ga:sessions"
///         dimensions="ga:date">
///       </google-analytics-chart>
///
///     </google-analytics-dashboard>
@CustomElementProxy('google-analytics-date-selector')
class GoogleAnalyticsDateSelector extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleAnalyticsDateSelector.created() : super.created();
  factory GoogleAnalyticsDateSelector() => new Element.tag('google-analytics-date-selector');

  /// The `endDate` attribute is the end date for fetching Analytics
  /// data. Requests can specify an end date formatted as YYYY-MM-DD, or
  /// as a relative date (e.g., today, yesterday, or NdaysAgo where N is a
  /// positive integer).
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#endDate">Core Reporting API parameter reference</a> for more details.
  String get endDate => jsElement[r'endDate'];
  set endDate(String value) { jsElement[r'endDate'] = value; }

  /// The `maxEndDate` attribute is used as the `max` attribute on the
  /// end date `<input>`.
  String get maxEndDate => jsElement[r'maxEndDate'];
  set maxEndDate(String value) { jsElement[r'maxEndDate'] = value; }

  /// The `minStartDate` attribute is used as the `min` attribute on the
  /// start date `<input>`.
  String get minStartDate => jsElement[r'minStartDate'];
  set minStartDate(String value) { jsElement[r'minStartDate'] = value; }

  /// The `startDate` attribute is the start date for fetching Analytics
  /// data. Requests can specify a start date formatted as YYYY-MM-DD, or
  /// as a relative date (e.g., today, yesterday, or NdaysAgo where N is a
  /// positive integer).
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#startDate">Core Reporting API parameter reference</a> for more details.
  String get startDate => jsElement[r'startDate'];
  set startDate(String value) { jsElement[r'startDate'] = value; }

  endDateChanged(cur, old) =>
      jsElement.callMethod('endDateChanged', [cur, old]);

  startDateChanged(cur, old) =>
      jsElement.callMethod('startDateChanged', [cur, old]);
}
