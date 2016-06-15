// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_request`.
@HtmlImport('iron_request_nodart.html')
library polymer_elements.lib.src.iron_ajax.iron_request;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// iron-request can be used to perform XMLHttpRequests.
///
///     <iron-request id="xhr"></iron-request>
///     ...
///     this.$.xhr.send({url: url, params: params});
@CustomElementProxy('iron-request')
class IronRequest extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronRequest.created() : super.created();
  factory IronRequest() => new Element.tag('iron-request');

  /// Aborted will be true if an abort of the request is attempted.
  bool get aborted => jsElement[r'aborted'];
  set aborted(bool value) { jsElement[r'aborted'] = value; }

  /// A promise that resolves when the `xhr` response comes back, or rejects
  /// if there is an error before the `xhr` completes.
  get completes => jsElement[r'completes'];
  set completes(value) { jsElement[r'completes'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Errored will be true if the browser fired an error event from the
  /// XHR object (mainly network errors).
  bool get errored => jsElement[r'errored'];
  set errored(bool value) { jsElement[r'errored'] = value; }

  /// An object that contains progress information emitted by the XHR if
  /// available.
  get progress => jsElement[r'progress'];
  set progress(value) { jsElement[r'progress'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A reference to the parsed response body, if the `xhr` has completely
  /// resolved.
  get response => jsElement[r'response'];
  set response(value) { jsElement[r'response'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A reference to the status code, if the `xhr` has completely resolved.
  num get status => jsElement[r'status'];
  set status(num value) { jsElement[r'status'] = value; }

  /// A reference to the status text, if the `xhr` has completely resolved.
  String get statusText => jsElement[r'statusText'];
  set statusText(String value) { jsElement[r'statusText'] = value; }

  /// Succeeded is true if the request succeeded. The request succeeded if it
  /// loaded without error, wasn't aborted, and the status code is ≥ 200, and
  /// < 300, or if the status code is 0.
  ///
  /// The status code 0 is accepted as a success because some schemes - e.g.
  /// file:// - don't provide status codes.
  bool get succeeded => jsElement[r'succeeded'];

  /// TimedOut will be true if the XHR threw a timeout event.
  bool get timedOut => jsElement[r'timedOut'];
  set timedOut(bool value) { jsElement[r'timedOut'] = value; }

  /// A reference to the XMLHttpRequest instance used to generate the
  /// network request.
  get xhr => jsElement[r'xhr'];
  set xhr(value) { jsElement[r'xhr'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Aborts the request.
  abort() =>
      jsElement.callMethod('abort', []);

  /// Attempts to parse the response body of the XHR. If parsing succeeds,
  /// the value returned will be deserialized based on the `responseType`
  /// set on the XHR.
  parseResponse() =>
      jsElement.callMethod('parseResponse', []);

  /// Sends an HTTP request to the server and returns the XHR object.
  ///
  /// The handling of the `body` parameter will vary based on the Content-Type
  /// header. See the docs for iron-ajax's `body` param for details.
  /// [options]: url The url to which the request is sent.
  ///         method The HTTP method to use, default is GET.
  ///         async By default, all requests are sent asynchronously. To send synchronous requests,
  ///             set to true.
  ///         body The content for the request body for POST method.
  ///         headers HTTP request headers.
  ///         handleAs The response type. Default is 'text'.
  ///         withCredentials Whether or not to send credentials on the request. Default is false.
  ///       timeout: (Number|undefined)
  send(options) =>
      jsElement.callMethod('send', [options]);
}
