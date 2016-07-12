// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_input_container`.
@HtmlImport('paper_input_container_nodart.html')
library polymer_elements.lib.src.paper_input.paper_input_container;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_flex_layout.dart';
import 'default_theme.dart';
import 'typography.dart';

/// `<paper-input-container>` is a container for a `<label>`, an `<input is="iron-input">` or
/// `<iron-autogrow-textarea>` and optional add-on elements such as an error message or character
/// counter, used to implement Material Design text fields.
///
/// For example:
///
///     <paper-input-container>
///       <label>Your name</label>
///       <input is="iron-input">
///     </paper-input-container>
///
/// Do not wrap `<paper-input-container>` around elements that already include it, such as `<paper-input>`.
/// Doing so may cause events to bounce infintely between the container and its contained element.
///
/// ### Listening for input changes
///
/// By default, it listens for changes on the `bind-value` attribute on its children nodes and perform
/// tasks such as auto-validating and label styling when the `bind-value` changes. You can configure
/// the attribute it listens to with the `attr-for-value` attribute.
///
/// ### Using a custom input element
///
/// You can use a custom input element in a `<paper-input-container>`, for example to implement a
/// compound input field like a social security number input. The custom input element should have the
/// `paper-input-input` class, have a `notify:true` value property and optionally implements
/// `Polymer.IronValidatableBehavior` if it is validatable.
///
///     <paper-input-container attr-for-value="ssn-value">
///       <label>Social security number</label>
///       <ssn-input class="paper-input-input"></ssn-input>
///     </paper-input-container>
///
///
/// If you're using a `<paper-input-container>` imperatively, it's important to make sure
/// that you attach its children (the `iron-input` and the optional `label`) before you
/// attach the `<paper-input-container>` itself, so that it can be set up correctly.
///
/// ### Validation
///
/// If the `auto-validate` attribute is set, the input container will validate the input and update
/// the container styling when the input value changes.
///
/// ### Add-ons
///
/// Add-ons are child elements of a `<paper-input-container>` with the `add-on` attribute and
/// implements the `Polymer.PaperInputAddonBehavior` behavior. They are notified when the input value
/// or validity changes, and may implement functionality such as error messages or character counters.
/// They appear at the bottom of the input.
///
/// ### Prefixes and suffixes
/// These are child elements of a `<paper-input-container>` with the `prefix`
/// or `suffix` attribute, and are displayed inline with the input, before or after.
///
///     <paper-input-container>
///       <div prefix>$</div>
///       <label>Total</label>
///       <input is="iron-input">
///       <paper-icon-button suffix icon="clear"></paper-icon-button>
///     </paper-input-container>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-input-container-color` | Label and underline color when the input is not focused | `--secondary-text-color`
/// `--paper-input-container-focus-color` | Label and underline color when the input is focused | `--primary-color`
/// `--paper-input-container-invalid-color` | Label and underline color when the input is is invalid | `--error-color`
/// `--paper-input-container-input-color` | Input foreground color | `--primary-text-color`
/// `--paper-input-container` | Mixin applied to the container | `{}`
/// `--paper-input-container-disabled` | Mixin applied to the container when it's disabled | `{}`
/// `--paper-input-container-label` | Mixin applied to the label | `{}`
/// `--paper-input-container-label-focus` | Mixin applied to the label when the input is focused | `{}`
/// `--paper-input-container-label-floating` | Mixin applied to the label when floating | `{}`
/// `--paper-input-container-input` | Mixin applied to the input | `{}`
/// `--paper-input-container-underline` | Mixin applied to the underline | `{}`
/// `--paper-input-container-underline-focus` | Mixin applied to the underline when the input is focused | `{}`
/// `--paper-input-container-underline-disabled` | Mixin applied to the underline when the input is disabled | `{}`
/// `--paper-input-prefix` | Mixin applied to the input prefix | `{}`
/// `--paper-input-suffix` | Mixin applied to the input suffix | `{}`
///
/// This element is `display:block` by default, but you can set the `inline` attribute to make it
/// `display:inline-block`.
@CustomElementProxy('paper-input-container')
class PaperInputContainer extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperInputContainer.created() : super.created();
  factory PaperInputContainer() => new Element.tag('paper-input-container');

  /// Set to true to always float the floating label.
  bool get alwaysFloatLabel => jsElement[r'alwaysFloatLabel'];
  set alwaysFloatLabel(bool value) { jsElement[r'alwaysFloatLabel'] = value; }

  /// The attribute to listen for value changes on.
  String get attrForValue => jsElement[r'attrForValue'];
  set attrForValue(String value) { jsElement[r'attrForValue'] = value; }

  /// Set to true to auto-validate the input value when it changes.
  bool get autoValidate => jsElement[r'autoValidate'];
  set autoValidate(bool value) { jsElement[r'autoValidate'] = value; }

  /// True if the input has focus.
  bool get focused => jsElement[r'focused'];
  set focused(bool value) { jsElement[r'focused'] = value; }

  /// True if the input is invalid. This property is set automatically when the input value
  /// changes if auto-validating, or when the `iron-input-validate` event is heard from a child.
  bool get invalid => jsElement[r'invalid'];
  set invalid(bool value) { jsElement[r'invalid'] = value; }

  /// Set to true to disable the floating label. The label disappears when the input value is
  /// not null.
  bool get noLabelFloat => jsElement[r'noLabelFloat'];
  set noLabelFloat(bool value) { jsElement[r'noLabelFloat'] = value; }

  /// Call this to update the state of add-ons.
  /// [state]: Add-on state.
  updateAddons(state) =>
      jsElement.callMethod('updateAddons', [state]);
}
