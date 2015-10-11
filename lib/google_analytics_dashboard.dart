// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_analytics_dashboard`.
@HtmlImport('google_analytics_dashboard_nodart.html')
library polymer_elements.lib.src.google_analytics.google_analytics_dashboard;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_signin_aware.dart';

/// Container element for binding Google Analytics controls to Google Analytics charts.
///
/// `<google-analytics-chart>` elements inside a `<google-analytics-dashboard>`
/// element will automatically update as control elements (e.g.
/// `<google-analytics-view-selector>` or `<google-analytics-date-selector>`)
/// update query parameters.
///
/// ##### Example
///
///     <google-analytics-dashboard>
///
///       <google-analytics-view-selector></google-analytics-view-selector>
///       <google-analytics-date-selector></google-analytics-date-selector>
///
///       <google-analytics-chart
///         metrics="ga:sessions"
///         dimensions="ga:country"
///         sort="-ga:sessions"
///         max-results="5"
///         chart-type="column">
///       </google-analytics-chart>
///
///     </google-analytics-dashboard>
@CustomElementProxy('google-analytics-dashboard')
class GoogleAnalyticsDashboard extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleAnalyticsDashboard.created() : super.created();
  factory GoogleAnalyticsDashboard() => new Element.tag('google-analytics-dashboard');

  /// True if user has been authorized
  bool get authorized => jsElement[r'authorized'];
  set authorized(bool value) { jsElement[r'authorized'] = value; }

  /// The `query` attribute represents the internal query object of this
  /// dashboard. It is updated when control elements fire the
  /// `analytics-dashboard-control-change` event and pass along query data.
  get queryObject => jsElement[r'query'];
  set queryObject(value) { jsElement[r'query'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The `queryUpdated` method is the callback for whenever the
  /// `analytics-dashboard-control-change` event is fired. It updates the
  /// query attribute, which is then sent to child charts.
  /// [event]: The event with the query data.
  queryUpdated(event) =>
      jsElement.callMethod('queryUpdated', [event]);

  /// The `updateChildren` method updates each of this dashboards
  /// `<google-analytics-chart>` element with its current query value.
  updateChildren() =>
      jsElement.callMethod('updateChildren', []);
}
