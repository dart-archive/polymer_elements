// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_ajax`.
@HtmlImport('iron_ajax_nodart.html')
library polymer_elements.lib.src.iron_ajax.iron_ajax;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_request.dart';

/// The `iron-ajax` element exposes network request functionality.
///
///     <iron-ajax
///         auto
///         url="http://gdata.youtube.com/feeds/api/videos/"
///         params='{"alt":"json", "q":"chrome"}'
///         handle-as="json"
///         on-response="handleResponse"
///         debounce-duration="300"></iron-ajax>
///
/// With `auto` set to `true`, the element performs a request whenever
/// its `url`, `params` or `body` properties are changed. Automatically generated
/// requests will be debounced in the case that multiple attributes are changed
/// sequentially.
///
/// Note: The `params` attribute must be double quoted JSON.
///
/// You can trigger a request explicitly by calling `generateRequest` on the
/// element.
@CustomElementProxy('iron-ajax')
class IronAjax extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronAjax.created() : super.created();
  factory IronAjax() => new Element.tag('iron-ajax');

  /// An Array of all in-flight requests originating from this iron-ajax
  /// element.
  List get activeRequests => jsElement[r'activeRequests'];
  set activeRequests(List value) { jsElement[r'activeRequests'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// If true, automatically performs an Ajax request when either `url` or
  /// `params` changes.
  bool get auto => jsElement[r'auto'];
  set auto(bool value) { jsElement[r'auto'] = value; }

  /// Body content to send with the request, typically used with "POST"
  /// requests.
  ///
  /// If body is a string it will be sent unmodified.
  ///
  /// If Content-Type is set to a value listed below, then
  /// the body will be encoded accordingly.
  ///
  ///    * `content-type="application/json"`
  ///      * body is encoded like `{"foo":"bar baz","x":1}`
  ///    * `content-type="application/x-www-form-urlencoded"`
  ///      * body is encoded like `foo=bar+baz&x=1`
  ///
  /// Otherwise the body will be passed to the browser unmodified, and it
  /// will handle any encoding (e.g. for FormData, Blob, ArrayBuffer).
  get body => jsElement[r'body'];
  set body(value) { jsElement[r'body'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// By default, these events do not bubble largely because the `error` event has special
  /// meaning in the window object. Setting this attribute will cause iron-ajax's request,
  /// response, and error events to bubble to the window object.
  bool get bubbles => jsElement[r'bubbles'];
  set bubbles(bool value) { jsElement[r'bubbles'] = value; }

  /// Content type to use when sending data. If the `contentType` property
  /// is set and a `Content-Type` header is specified in the `headers`
  /// property, the `headers` property value will take precedence.
  ///
  /// Varies the handling of the `body` param.
  String get contentType => jsElement[r'contentType'];
  set contentType(String value) { jsElement[r'contentType'] = value; }

  /// Length of time in milliseconds to debounce multiple automatically generated requests.
  num get debounceDuration => jsElement[r'debounceDuration'];
  set debounceDuration(num value) { jsElement[r'debounceDuration'] = value; }

  /// Specifies what data to store in the `response` property, and
  /// to deliver as `event.detail.response` in `response` events.
  ///
  /// One of:
  ///
  ///    `text`: uses `XHR.responseText`.
  ///
  ///    `xml`: uses `XHR.responseXML`.
  ///
  ///    `json`: uses `XHR.responseText` parsed as JSON.
  ///
  ///    `arraybuffer`: uses `XHR.response`.
  ///
  ///    `blob`: uses `XHR.response`.
  ///
  ///    `document`: uses `XHR.response`.
  String get handleAs => jsElement[r'handleAs'];
  set handleAs(String value) { jsElement[r'handleAs'] = value; }

  /// HTTP request headers to send.
  ///
  /// Example:
  ///
  ///     <iron-ajax
  ///         auto
  ///         url="http://somesite.com"
  ///         headers='{"X-Requested-With": "XMLHttpRequest"}'
  ///         handle-as="json"></iron-ajax>
  ///
  /// Note: setting a `Content-Type` header here will override the value
  /// specified by the `contentType` property of this element.
  get headers => jsElement[r'headers'];
  set headers(value) { jsElement[r'headers'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Prefix to be stripped from a JSON response before parsing it.
  ///
  /// In order to prevent an attack using CSRF with Array responses
  /// (http://haacked.com/archive/2008/11/20/anatomy-of-a-subtle-json-vulnerability.aspx/)
  /// many backends will mitigate this by prefixing all JSON response bodies
  /// with a string that would be nonsensical to a JavaScript parser.
  String get jsonPrefix => jsElement[r'jsonPrefix'];
  set jsonPrefix(String value) { jsElement[r'jsonPrefix'] = value; }

  /// lastRequest's error, if any.
  get lastError => jsElement[r'lastError'];
  set lastError(value) { jsElement[r'lastError'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The most recent request made by this iron-ajax element.
  get lastRequest => jsElement[r'lastRequest'];
  set lastRequest(value) { jsElement[r'lastRequest'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// lastRequest's response.
  ///
  /// Note that lastResponse and lastError are set when lastRequest finishes,
  /// so if loading is true, then lastResponse and lastError will correspond
  /// to the result of the previous request.
  ///
  /// The type of the response is determined by the value of `handleAs` at
  /// the time that the request was generated.
  get lastResponse => jsElement[r'lastResponse'];
  set lastResponse(value) { jsElement[r'lastResponse'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// True while lastRequest is in flight.
  bool get loading => jsElement[r'loading'];
  set loading(bool value) { jsElement[r'loading'] = value; }

  /// The HTTP method to use such as 'GET', 'POST', 'PUT', or 'DELETE'.
  /// Default is 'GET'.
  String get method => jsElement[r'method'];
  set method(String value) { jsElement[r'method'] = value; }

  /// An object that contains query parameters to be appended to the
  /// specified `url` when generating a request. If you wish to set the body
  /// content when making a POST request, you should use the `body` property
  /// instead.
  get params => jsElement[r'params'];
  set params(value) { jsElement[r'params'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The query string that should be appended to the `url`, serialized from
  /// the current value of `params`.
  String get queryString => jsElement[r'queryString'];

  /// An object that maps header names to header values, first applying the
  /// the value of `Content-Type` and then overlaying the headers specified
  /// in the `headers` property.
  get requestHeaders => jsElement[r'requestHeaders'];

  /// The `url` with query string (if `params` are specified), suitable for
  /// providing to an `iron-request` instance.
  String get requestUrl => jsElement[r'requestUrl'];

  /// Toggle whether XHR is synchronous or asynchronous. Don't change this
  /// to true unless You Know What You Are Doing™.
  bool get sync => jsElement[r'sync'];
  set sync(bool value) { jsElement[r'sync'] = value; }

  /// Set the timeout flag on the request.
  num get timeout => jsElement[r'timeout'];
  set timeout(num value) { jsElement[r'timeout'] = value; }

  /// The URL target of the request.
  String get url => jsElement[r'url'];
  set url(String value) { jsElement[r'url'] = value; }

  /// If true, error messages will automatically be logged to the console.
  bool get verbose => jsElement[r'verbose'];
  set verbose(bool value) { jsElement[r'verbose'] = value; }

  /// Set the withCredentials flag on the request.
  bool get withCredentials => jsElement[r'withCredentials'];
  set withCredentials(bool value) { jsElement[r'withCredentials'] = value; }

  /// Performs an AJAX request to the specified URL.
  generateRequest() =>
      jsElement.callMethod('generateRequest', []);

  /// Request options suitable for generating an `iron-request` instance based
  /// on the current state of the `iron-ajax` instance's properties.
  toRequestOptions() =>
      jsElement.callMethod('toRequestOptions', []);
}
