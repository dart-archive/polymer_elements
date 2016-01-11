// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `google_feeds`.
@HtmlImport('google_feeds_nodart.html')
library polymer_elements.lib.src.google_feeds.google_feeds;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'google_legacy_loader.dart';

/// Exposes [Google Feeds API](https://developers.google.com/feed/)
///
/// <b>Example</b>:
///
///     <template is='dom-bind'>
///       <google-feeds feed='http://www.engadget.com/rss-full.xml'
///       results='{{result}}'></google-feeds>
///       <p>Feed title: <span>{{result.title}}</span></p>
///     </template>
@CustomElementProxy('google-feeds')
class GoogleFeeds extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  GoogleFeeds.created() : super.created();
  factory GoogleFeeds() => new Element.tag('google-feeds');

  /// Number of feed items to fetch in fetchFeed
  num get count => jsElement[r'count'];
  set count(num value) { jsElement[r'count'] = value; }

  /// url of the feed to fetch.
  String get feed => jsElement[r'feed'];
  set feed(String value) { jsElement[r'feed'] = value; }

  /// An array of multiple feeds. Feed will load, and report results in `google-feeds-response` event.
  List get feeds => jsElement[r'feeds'];
  set feeds(List value) { jsElement[r'feeds'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Format the data is returned. json(default)|xml|mixed
  /// Only applies for one feed.
  String get format => jsElement[r'format'];
  set format(String value) { jsElement[r'format'] = value; }

  /// True if feeds API is loading an item
  bool get loading => jsElement[r'loading'];
  set loading(bool value) { jsElement[r'loading'] = value; }

  /// Query for google.feeds.findFeeds(). Query result will be reported through `google-feeds-queryresponse` event
  String get queryObject => jsElement[r'query'];
  set queryObject(String value) { jsElement[r'query'] = value; }

  /// Result of loading a single feed url
  get results => jsElement[r'results'];
  set results(value) { jsElement[r'results'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
