// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_dialog_scrollable`.
@HtmlImport('paper_dialog_scrollable_nodart.html')
library polymer_elements.lib.src.paper_dialog_scrollable.paper_dialog_scrollable;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_flex_layout.dart';
import 'paper_dialog_behavior.dart';
import 'default_theme.dart';

/// Material design: [Dialogs](https://www.google.com/design/spec/components/dialogs.html)
///
/// `paper-dialog-scrollable` implements a scrolling area used in a Material Design dialog. It shows
/// a divider at the top and/or bottom indicating more content, depending on scroll position. Use this
/// together with elements implementing `Polymer.PaperDialogBehavior`.
///
///     <paper-dialog-impl>
///       <h2>Header</h2>
///       <paper-dialog-scrollable>
///         Lorem ipsum...
///       </paper-dialog-scrollable>
///       <div class="buttons">
///         <paper-button>OK</paper-button>
///       </div>
///     </paper-dialog-impl>
///
/// It shows a top divider after scrolling if it is not the first child in its parent container,
/// indicating there is more content above. It shows a bottom divider if it is scrollable and it is not
/// the last child in its parent container, indicating there is more content below. The bottom divider
/// is hidden if it is scrolled to the bottom.
///
/// If `paper-dialog-scrollable` is not a direct child of the element implementing `Polymer.PaperDialogBehavior`,
/// remember to set the `dialogElement`:
///
///     <paper-dialog-impl id="myDialog">
///       <h2>Header</h2>
///       <div class="my-content-wrapper">
///         <h4>Sub-header</h4>
///         <paper-dialog-scrollable>
///           Lorem ipsum...
///         </paper-dialog-scrollable>
///       </div>
///       <div class="buttons">
///         <paper-button>OK</paper-button>
///       </div>
///     </paper-dialog-impl>
///
///     <script>
///       var scrollable = Polymer.dom(myDialog).querySelector('paper-dialog-scrollable');
///       scrollable.dialogElement = myDialog;
///     </script>
///
/// ### Styling
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-dialog-scrollable` | Mixin for the scrollable content | {}
@CustomElementProxy('paper-dialog-scrollable')
class PaperDialogScrollable extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperDialogScrollable.created() : super.created();
  factory PaperDialogScrollable() => new Element.tag('paper-dialog-scrollable');

  /// The dialog element that implements `Polymer.PaperDialogBehavior` containing this element.
  get dialogElement => jsElement[r'dialogElement'];
  set dialogElement(value) { jsElement[r'dialogElement'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Returns the scrolling element.
  get scrollTarget => jsElement[r'scrollTarget'];
}
