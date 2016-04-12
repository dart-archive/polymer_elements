// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_location`.
@HtmlImport('iron_location_nodart.html')
library polymer_elements.lib.src.iron_location.iron_location;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `iron-location` element manages binding to and from the current URL.
///
/// iron-location is the first, and lowest level element in the Polymer team's
/// routing system. This is a beta release of iron-location as we continue work
/// on higher level elements, and as such iron-location may undergo breaking
/// changes.
///
/// #### Properties
///
/// When the URL is: `/search?query=583#details` iron-location's properties will be:
///
///   - path: `'/search'`
///   - query: `'query=583'`
///   - hash: `'details'`
///
/// These bindings are bidirectional. Modifying them will in turn modify the URL.
///
/// iron-location is only active while it is attached to the document.
///
/// #### Links
///
/// While iron-location is active in the document it will intercept clicks on links
/// within your site, updating the URL pushing the updated URL out through the
/// databinding system. iron-location only intercepts clicks with the intent to
/// open in the same window, so middle mouse clicks and ctrl/cmd clicks work fine.
///
/// You can customize this behavior with the `urlSpaceRegex`.
///
/// #### Dwell Time
///
/// iron-location protects against accidental history spamming by only adding
/// entries to the user's history if the URL stays unchanged for `dwellTime`
/// milliseconds.
@CustomElementProxy('iron-location')
class IronLocation extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronLocation.created() : super.created();
  factory IronLocation() => new Element.tag('iron-location');

  /// If the user was on a URL for less than `dwellTime` milliseconds, it
  /// won't be added to the browser's history, but instead will be replaced
  /// by the next entry.
  ///
  /// This is to prevent large numbers of entries from clogging up the user's
  /// browser history. Disable by setting to a negative number.
  num get dwellTime => jsElement[r'dwellTime'];
  set dwellTime(num value) { jsElement[r'dwellTime'] = value; }

  /// The hash component of the URL.
  String get hash => jsElement[r'hash'];
  set hash(String value) { jsElement[r'hash'] = value; }

  /// The pathname component of the URL.
  String get path => jsElement[r'path'];
  set path(String value) { jsElement[r'path'] = value; }

  /// The query string portion of the URL.
  String get locationQuery => jsElement[r'query'];
  set locationQuery(String value) { jsElement[r'query'] = value; }

  /// A regexp that defines the set of URLs that should be considered part
  /// of this web app.
  ///
  /// Clicking on a link that matches this regex won't result in a full page
  /// navigation, but will instead just update the URL state in place.
  ///
  /// This regexp is given everything after the origin in an absolute
  /// URL. So to match just URLs that start with /search/ do:
  ///     url-space-regex="^/search/"
  get urlSpaceRegex => jsElement[r'urlSpaceRegex'];
  set urlSpaceRegex(value) { jsElement[r'urlSpaceRegex'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
