// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_form`.
@HtmlImport('iron_form_nodart.html')
library polymer_elements.lib.src.iron_form.iron_form;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_ajax.dart';

/// `<iron-form>` is an HTML `<form>` element that can validate and submit any custom
/// elements that implement `Polymer.IronFormElementBehavior`, as well as any
/// native HTML elements.
///
/// It supports both `get` and `post` methods, and uses an `iron-ajax` element to
/// submit the form data to the action URL.
///
///   Example:
///
///     <form is="iron-form" id="form" method="post" action="/form/handler">
///       <paper-input name="name" label="name"></paper-input>
///       <input name="address">
///       ...
///     </form>
///
/// By default, a native `<button>` element will submit this form. However, if you
/// want to submit it from a custom element's click handler, you need to explicitly
/// call the form's `submit` method.
///
///   Example:
///
///     <paper-button raised onclick="submitForm()">Submit</paper-button>
///
///     function submitForm() {
///       document.getElementById('form').submit();
///     }
///
/// To customize the request sent to the server, you can listen to the `iron-form-presubmit`
/// event, and modify the form's[`iron-ajax`](https://elements.polymer-project.org/elements/iron-ajax)
/// object. However, If you want to not use `iron-ajax` at all, you can cancel the
/// event and do your own custom submission:
///
///   Example of modifying the request, but still using the build-in form submission:
///
///     form.addEventListener('iron-form-presubmit', function() {
///       this.request.method = 'put';
///       this.request.params = someCustomParams;
///     });
///
///   Example of bypassing the build-in form submission:
///
///     form.addEventListener('iron-form-presubmit', function(event) {
///       event.preventDefault();
///       var firebase = new Firebase(form.getAttribute('action'));
///       firebase.set(form.serialize());
///     });
@CustomElementProxy('iron-form', extendsTag: 'form')
class IronForm extends FormElement with CustomElementProxyMixin, PolymerBase {
  IronForm.created() : super.created();
  factory IronForm() => new Element.tag('form', 'iron-form');

  /// Content type to use when sending data.
  String get contentType => jsElement[r'contentType'];
  set contentType(String value) { jsElement[r'contentType'] = value; }

  /// By default, the form will display the browser's native validation
  /// UI (i.e. popup bubbles and invalid styles on invalid fields). You can
  /// manually disable this; however, if you do, note that you will have to
  /// manually style invalid *native* HTML fields yourself, as you are
  /// explicitly preventing the native form from doing so.
  bool get disableNativeValidationUi => jsElement[r'disableNativeValidationUi'];
  set disableNativeValidationUi(bool value) { jsElement[r'disableNativeValidationUi'] = value; }

  /// HTTP request headers to send
  ///
  /// Note: setting a `Content-Type` header here will override the value
  /// specified by the `contentType` property of this element.
  get headers => jsElement[r'headers'];
  set headers(value) { jsElement[r'headers'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// iron-ajax request object used to submit the form.
  get request => jsElement[r'request'];
  set request(value) { jsElement[r'request'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Set the withCredentials flag when sending data.
  bool get withCredentials => jsElement[r'withCredentials'];
  set withCredentials(bool value) { jsElement[r'withCredentials'] = value; }

  /// Returns a json object containing name/value pairs for all the registered
  /// custom components and native elements of the form. If there are elements
  /// with duplicate names, then their values will get aggregated into an
  /// array of values.
  serialize() =>
      jsElement.callMethod('serialize', []);

  /// Submits the form.
  submit() =>
      jsElement.callMethod('submit', []);

  /// Validates all the required elements (custom and native) in the form.
  bool validate() =>
      jsElement.callMethod('validate', []);
}
