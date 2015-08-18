// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_form`.
@HtmlImport('iron_form_nodart.html')
library polymer_elements.lib.src.iron_form.iron_form;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_ajax.dart';

/// ``<iron-form>` is an HTML `<form>` element that can validate and submit any custom
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

  /// Set the withCredentials flag when sending data.
  bool get withCredentials => jsElement[r'withCredentials'];
  set withCredentials(bool value) { jsElement[r'withCredentials'] = value; }

  /// Returns a json object containing name/value pairs for all the registered
  /// custom components and native elements of the form. If there are elements
  /// with duplicate names, then their values will get aggregated into an
  /// array of values.
  serialize() =>
      jsElement.callMethod('serialize', []);

  /// Called to submit the form.
  void submit() =>
      jsElement.callMethod('submit', []);

  /// Validates all the required elements (custom and native) in the form.
  bool validate() =>
      jsElement.callMethod('validate', []);
}
