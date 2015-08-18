// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_request`.
@HtmlImport('iron_request_nodart.html')
library polymer_elements.lib.src.iron_ajax.iron_request;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';


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
  set completes(value) { jsElement[r'completes'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// An object that contains progress information emitted by the XHR if
  /// available.
  get progress => jsElement[r'progress'];
  set progress(value) { jsElement[r'progress'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// A reference to the parsed response body, if the `xhr` has completely
  /// resolved.
  get response => jsElement[r'response'];
  set response(value) { jsElement[r'response'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Succeeded is true if the request succeeded. The request succeeded if the
  /// status code is greater-than-or-equal-to 200, and less-than 300. Also,
  /// the status code 0 is accepted as a success even though the outcome may
  /// be ambiguous.
  get succeeded => jsElement[r'succeeded'];

  /// A reference to the XMLHttpRequest instance used to generate the
  /// network request.
  get xhr => jsElement[r'xhr'];
  set xhr(value) { jsElement[r'xhr'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  void abort() =>
      jsElement.callMethod('abort', []);

  void parseResponse() =>
      jsElement.callMethod('parseResponse', []);

  /// Sends an HTTP request to the server and returns the XHR object.
  /// [options]: url The url to which the request is sent.
  ///         method The HTTP method to use, default is GET.
  ///         async By default, all requests are sent asynchronously. To send synchronous requests,
  ///             set to true.
  ///         body The content for the request body for POST method.
  ///         headers HTTP request headers.
  ///         handleAs The response type. Default is 'text'.
  ///         withCredentials Whether or not to send credentials on the request. Default is false.
  send(options) =>
      jsElement.callMethod('send', [options]);
}
