// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_analytics_view_selector`.
@HtmlImport('google_analytics_view_selector_nodart.html')
library polymer_elements.lib.src.google_analytics.google_analytics_view_selector;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_analytics_loader.dart';

/// Element for selecting the view ID (ids) value for queries inside a
/// `<google-analytics-dashboard>` element.
///
/// ##### Example
///
///     <google-analytics-dashboard>
///
///       <google-analytics-view-selector></google-analytics-view-selector>
///
///       <google-analytics-chart
///         metrics="ga:sessions"
///         dimensions="ga:date">
///       </google-analytics-chart>
///
///     </google-analytics-dashboard>
@CustomElementProxy('google-analytics-view-selector')
class GoogleAnalyticsViewSelector extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleAnalyticsViewSelector.created() : super.created();
  factory GoogleAnalyticsViewSelector() => new Element.tag('google-analytics-view-selector');

  /// The `account` attribute is the currently selected account.
  get account => jsElement[r'account'];
  set account(value) { jsElement[r'account'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The `ids` attribute, when found is used to preselect the chosen
  /// account, property, and view.
  ///
  /// See the <a href="https://developers.google.com/analytics/devguides/reporting/core/v3/reference#ids">Core Reporting API parameter reference</a> for more details.
  String get ids => jsElement[r'ids'];
  set ids(String value) { jsElement[r'ids'] = value; }

  /// The `property` attribute is the currently selected property.
  get property => jsElement[r'property'];
  set property(value) { jsElement[r'property'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// True if setup is ready
  bool get setupReady => jsElement[r'setupReady'];
  set setupReady(bool value) { jsElement[r'setupReady'] = value; }

  /// The `summaries` attribute contains an account summaries utility object
  /// with various helper methods for quickly getting account data.
  ///
  /// See the <a href="https://github.com/googleanalytics/javascript-api-utils">Github repo</a> for more details.
  get summaries => jsElement[r'summaries'];
  set summaries(value) { jsElement[r'summaries'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The `view` attribute is the currently selected view.
  get view => jsElement[r'view'];
  set view(value) { jsElement[r'view'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  accountChanged(newAccount, oldAccount) =>
      jsElement.callMethod('accountChanged', [newAccount, oldAccount]);

  /// Fire a change event passing all the currently stored data.
  fireChangeEvent() =>
      jsElement.callMethod('fireChangeEvent', []);

  idsChanged(newIds, oldIds) =>
      jsElement.callMethod('idsChanged', [newIds, oldIds]);

  propertyChanged(newProperty, oldProperty) =>
      jsElement.callMethod('propertyChanged', [newProperty, oldProperty]);

  setupReadyChanged(newVal, oldVal) =>
      jsElement.callMethod('setupReadyChanged', [newVal, oldVal]);

  /// The `updateAccount` method is bound to the change event on the
  /// account `<select>`. It updates the property and view `<select>`s based
  /// on the new account data. It also updates the `ids` attribute.
  updateAccount() =>
      jsElement.callMethod('updateAccount', []);

  /// The `updateProperty` method is bound to the change event on the
  /// property `<select>`. It updates the view `<select>` based
  /// on the new property data. It also updates the `ids` attribute.
  updateProperty() =>
      jsElement.callMethod('updateProperty', []);

  /// The `updateView` method is bound to the change event on the
  /// view `<select>`. It updates the `ids` attribute.
  updateView() =>
      jsElement.callMethod('updateView', []);

  /// this.view = Path.get('views[0]').getValueFrom(newProperty);
  viewChanged(newView, oldView) =>
      jsElement.callMethod('viewChanged', [newView, oldView]);
}
