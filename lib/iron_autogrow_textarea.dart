// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_autogrow_textarea`.
@HtmlImport('iron_autogrow_textarea_nodart.html')
library polymer_elements.lib.src.iron_autogrow_textarea.iron_autogrow_textarea;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_form_element_behavior.dart';
import 'iron_validatable_behavior.dart';
import 'iron_control_state.dart';
import 'iron_flex_layout.dart';

/// `iron-autogrow-textarea` is an element containing a textarea that grows in height as more
/// lines of input are entered. Unless an explicit height or the `maxRows` property is set, it will
/// never scroll.
///
/// Example:
///
///     <iron-autogrow-textarea></iron-autogrow-textarea>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--iron-autogrow-textarea` | Mixin applied to the textarea | `{}`
/// `--iron-autogrow-textarea-placeholder` | Mixin applied to the textarea placeholder | `{}`
@CustomElementProxy('iron-autogrow-textarea')
class IronAutogrowTextarea extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronFormElementBehavior, IronValidatableBehavior, IronControlState {
  IronAutogrowTextarea.created() : super.created();
  factory IronAutogrowTextarea() => new Element.tag('iron-autogrow-textarea');

  /// Bound to the textarea's `autocomplete` attribute.
  String get autocomplete => jsElement[r'autocomplete'];
  set autocomplete(String value) { jsElement[r'autocomplete'] = value; }

  /// Bound to the textarea's `autofocus` attribute.
  bool get autofocus => jsElement[r'autofocus'];
  set autofocus(bool value) { jsElement[r'autofocus'] = value; }

  /// Use this property instead of `value` for two-way data binding.
  /// This property will be deprecated in the future. Use `value` instead.
  get bindValue => jsElement[r'bindValue'];
  set bindValue(value) { jsElement[r'bindValue'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Bound to the textarea's `inputmode` attribute.
  String get inputmode => jsElement[r'inputmode'];
  set inputmode(String value) { jsElement[r'inputmode'] = value; }

  /// The maximum number of rows this element can grow to until it
  /// scrolls. 0 means no maximum.
  num get maxRows => jsElement[r'maxRows'];
  set maxRows(num value) { jsElement[r'maxRows'] = value; }

  /// The maximum length of the input value.
  num get maxlength => jsElement[r'maxlength'];
  set maxlength(num value) { jsElement[r'maxlength'] = value; }

  /// Bound to the textarea's `placeholder` attribute.
  String get placeholder => jsElement[r'placeholder'];
  set placeholder(String value) { jsElement[r'placeholder'] = value; }

  /// Bound to the textarea's `readonly` attribute.
  String get readonly => jsElement[r'readonly'];
  set readonly(String value) { jsElement[r'readonly'] = value; }

  /// Set to true to mark the textarea as required.
  bool get required => jsElement[r'required'];
  set required(bool value) { jsElement[r'required'] = value; }

  /// The initial number of rows.
  num get rows => jsElement[r'rows'];
  set rows(num value) { jsElement[r'rows'] = value; }

  /// Sets the textarea's selection end.
  get selectionEnd => jsElement[r'selectionEnd'];
  set selectionEnd(value) { jsElement[r'selectionEnd'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Sets the textarea's selection start.
  get selectionStart => jsElement[r'selectionStart'];
  set selectionStart(value) { jsElement[r'selectionStart'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Returns the underlying textarea.
  get textarea => jsElement[r'textarea'];

  /// Returns true if `value` is valid. The validator provided in `validator`
  /// will be used first, if it exists; otherwise, the `textarea`'s validity
  /// is used.
  bool validate([_]) => //() =>
      jsElement.callMethod('validate', []);
}
