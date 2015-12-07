// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_dialog`.
@HtmlImport('paper_dialog_nodart.html')
library polymer_elements.lib.src.paper_dialog.paper_dialog;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'paper_dialog_behavior.dart';
import 'iron_overlay_behavior.dart';
import 'iron_fit_behavior.dart';
import 'iron_resizable_behavior.dart';
import 'neon_animation_runner_behavior.dart';
import 'neon_animatable_behavior.dart';
import 'paper_dialog_shared_styles.dart';

/// Material design: [Dialogs](https://www.google.com/design/spec/components/dialogs.html)
///
/// `<paper-dialog>` is a dialog with Material Design styling and optional animations when it is
/// opened or closed. It provides styles for a header, content area, and an action area for buttons.
/// You can use the `<paper-dialog-scrollable>` element (in its own repository) if you need a scrolling
/// content area. See `Polymer.PaperDialogBehavior` for specifics.
///
/// For example, the following code implements a dialog with a header, scrolling content area and
/// buttons.
///
///     <paper-dialog>
///       <h2>Header</h2>
///       <paper-dialog-scrollable>
///         Lorem ipsum...
///       </paper-dialog-scrollable>
///       <div class="buttons">
///         <paper-button dialog-dismiss>Cancel</paper-button>
///         <paper-button dialog-confirm>Accept</paper-button>
///       </div>
///     </paper-dialog>
///
/// ### Styling
///
/// See the docs for `Polymer.PaperDialogBehavior` for the custom properties available for styling
/// this element.
///
/// ### Animations
///
/// Set the `entry-animation` and/or `exit-animation` attributes to add an animation when the dialog
/// is opened or closed. See the documentation in
/// [PolymerElements/neon-animation](https://github.com/PolymerElements/neon-animation) for more info.
///
/// For example:
///
///     <link rel="import" href="components/neon-animation/animations/scale-up-animation.html">
///     <link rel="import" href="components/neon-animation/animations/fade-out-animation.html">
///
///     <paper-dialog entry-animation="scale-up-animation"
///                   exit-animation="fade-out-animation">
///       <h2>Header</h2>
///       <div>Dialog body</div>
///     </paper-dialog>
///
/// ### Accessibility
///
/// See the docs for `Polymer.PaperDialogBehavior` for accessibility features implemented by this
/// element.
@CustomElementProxy('paper-dialog')
class PaperDialog extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronFitBehavior, IronResizableBehavior, IronOverlayBehavior, PaperDialogBehavior, NeonAnimatableBehavior, NeonAnimationRunnerBehavior {
  PaperDialog.created() : super.created();
  factory PaperDialog() => new Element.tag('paper-dialog');
}
