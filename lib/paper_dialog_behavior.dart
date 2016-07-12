// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_dialog_behavior`.
@HtmlImport('paper_dialog_behavior_nodart.html')
library polymer_elements.lib.src.paper_dialog_behavior.paper_dialog_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_overlay_behavior.dart';
import 'iron_fit_behavior.dart';
import 'iron_resizable_behavior.dart';

/// Use `Polymer.PaperDialogBehavior` and `paper-dialog-shared-styles.html` to implement a Material Design
/// dialog.
///
/// For example, if `<paper-dialog-impl>` implements this behavior:
///
///     <paper-dialog-impl>
///         <h2>Header</h2>
///         <div>Dialog body</div>
///         <div class="buttons">
///             <paper-button dialog-dismiss>Cancel</paper-button>
///             <paper-button dialog-confirm>Accept</paper-button>
///         </div>
///     </paper-dialog-impl>
///
/// `paper-dialog-shared-styles.html` provide styles for a header, content area, and an action area for buttons.
/// Use the `<h2>` tag for the header and the `buttons` class for the action area. You can use the
/// `paper-dialog-scrollable` element (in its own repository) if you need a scrolling content area.
///
/// Use the `dialog-dismiss` and `dialog-confirm` attributes on interactive controls to close the
/// dialog. If the user dismisses the dialog with `dialog-confirm`, the `closingReason` will update
/// to include `confirmed: true`.
///
/// ### Accessibility
///
/// This element has `role="dialog"` by default. Depending on the context, it may be more appropriate
/// to override this attribute with `role="alertdialog"`.
///
/// If `modal` is set, the element will set `aria-modal` and prevent the focus from exiting the element.
/// It will also ensure that focus remains in the dialog.
@BehaviorProxy(const ['Polymer', 'PaperDialogBehavior'])
abstract class PaperDialogBehavior implements CustomElementProxyMixin, IronOverlayBehavior {

  /// If `modal` is true, this implies `no-cancel-on-outside-click`, `no-cancel-on-esc-key` and `with-backdrop`.
  bool get modal => jsElement[r'modal'];
  set modal(bool value) { jsElement[r'modal'] = value; }
}
