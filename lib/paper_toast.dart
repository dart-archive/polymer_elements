// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_toast`.
@HtmlImport('paper_toast_nodart.html')
library polymer_elements.lib.src.paper_toast.paper_toast;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_overlay_behavior.dart';
import 'iron_fit_behavior.dart';
import 'iron_resizable_behavior.dart';
import 'iron_a11y_announcer.dart';

/// Material design: [Snackbards & toasts](https://www.google.com/design/spec/components/snackbars-toasts.html)
///
/// `paper-toast` provides a subtle notification toast. Only one `paper-toast` will
/// be visible on screen.
///
/// Use `opened` to show the toast:
///
/// Example:
///
///     <paper-toast text="Hello world!" opened></paper-toast>
///
/// Also `open()` or `show()` can be used to show the toast:
///
/// Example:
///
///     <paper-button on-click="openToast">Open Toast</paper-button>
///     <paper-toast id="toast" text="Hello world!"></paper-toast>
///
///     ...
///
///     openToast: function() {
///       this.$.toast.open();
///     }
///
/// Set `duration` to 0, a negative number or Infinity to persist the toast on screen:
///
/// Example:
///
///     <paper-toast text="Terms and conditions" opened duration="0">
///       <a href="#">Show more</a>
///     </paper-toast>
///
///
/// ### Styling
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-toast-background-color` | The paper-toast background-color | `#323232`
/// `--paper-toast-color` | The paper-toast color | `#f1f1f1`
///
/// This element applies the mixin `--paper-font-common-base` but does not import `paper-styles/typography.html`.
/// In order to apply the `Roboto` font to this element, make sure you've imported `paper-styles/typography.html`.
@CustomElementProxy('paper-toast')
class PaperToast extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronFitBehavior, IronResizableBehavior, IronOverlayBehavior {
  PaperToast.created() : super.created();
  factory PaperToast() => new Element.tag('paper-toast');

  /// The duration in milliseconds to show the toast.
  /// Set to `0`, a negative number, or `Infinity`, to disable the
  /// toast auto-closing.
  num get duration => jsElement[r'duration'];
  set duration(num value) { jsElement[r'duration'] = value; }

  /// The element to fit `this` into.
  /// Overridden from `Polymer.IronFitBehavior`.
  get fitInto => jsElement[r'fitInto'];
  set fitInto(value) { jsElement[r'fitInto'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The orientation against which to align the dropdown content
  /// horizontally relative to `positionTarget`.
  /// Overridden from `Polymer.IronFitBehavior`.
  String get horizontalAlign => jsElement[r'horizontalAlign'];
  set horizontalAlign(String value) { jsElement[r'horizontalAlign'] = value; }

  /// Overridden from `IronOverlayBehavior`.
  /// Set to true to disable auto-focusing the toast or child nodes with
  /// the `autofocus` attribute` when the overlay is opened.
  bool get noAutoFocus => jsElement[r'noAutoFocus'];
  set noAutoFocus(bool value) { jsElement[r'noAutoFocus'] = value; }

  /// Overridden from `IronOverlayBehavior`.
  /// Set to false to enable closing of the toast by clicking outside it.
  bool get noCancelOnOutsideClick => jsElement[r'noCancelOnOutsideClick'];
  set noCancelOnOutsideClick(bool value) { jsElement[r'noCancelOnOutsideClick'] = value; }

  /// The text to display in the toast.
  String get text => jsElement[r'text'];
  set text(String value) { jsElement[r'text'] = value; }

  /// The orientation against which to align the dropdown content
  /// vertically relative to `positionTarget`.
  /// Overridden from `Polymer.IronFitBehavior`.
  String get verticalAlign => jsElement[r'verticalAlign'];
  set verticalAlign(String value) { jsElement[r'verticalAlign'] = value; }

  /// Read-only. Deprecated. Use `opened` from `IronOverlayBehavior`.
  get visible => jsElement[r'visible'];

  /// Hide the toast. Same as `close()` from `IronOverlayBehavior`.
  hide() =>
      jsElement.callMethod('hide', []);

  /// Show the toast. Without arguments, this is the same as `open()` from `IronOverlayBehavior`.
  /// [properties]: Properties to be set before opening the toast.
  ///     e.g. `toast.show('hello')` or `toast.show({text: 'hello', duration: 3000})`
  show(properties) =>
      jsElement.callMethod('show', [properties]);
}
