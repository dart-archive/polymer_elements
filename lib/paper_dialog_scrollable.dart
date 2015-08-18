// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_dialog_scrollable`.
@HtmlImport('paper_dialog_scrollable_nodart.html')
library polymer_elements.lib.src.paper_dialog_scrollable.paper_dialog_scrollable;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_flex_layout/classes/iron_flex_layout.dart';
import 'paper_styles.dart';

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
@CustomElementProxy('paper-dialog-scrollable')
class PaperDialogScrollable extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperDialogScrollable.created() : super.created();
  factory PaperDialogScrollable() => new Element.tag('paper-dialog-scrollable');

  /// The dialog element that implements `Polymer.PaperDialogBehavior` containing this element.
  get dialogElement => jsElement[r'dialogElement'];
  set dialogElement(value) { jsElement[r'dialogElement'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Returns the scrolling element.
  get scrollTarget => jsElement[r'scrollTarget'];
}
