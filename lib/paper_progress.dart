// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_progress`.
@HtmlImport('paper_progress_nodart.html')
library polymer_elements.lib.src.paper_progress.paper_progress;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_range_behavior.dart';
import 'paper_styles.dart';
import 'iron_flex_layout/classes/iron_flex_layout.dart';

/// The progress bars are for situations where the percentage completed can be
/// determined. They give users a quick sense of how much longer an operation
/// will take.
///
/// Example:
///
///     <paper-progress value="10"></paper-progress>
///
/// There is also a secondary progress which is useful for displaying intermediate
/// progress, such as the buffer level during a streaming playback progress bar.
///
/// Example:
///
///     <paper-progress value="10" secondary-progress="30"></paper-progress>
///
/// ### Styling progress bar:
///
/// To change the active progress bar color:
///
///     paper-progress {
///        --paper-progress-active-color: #e91e63;
///     }
///
/// To change the secondary progress bar color:
///
///     paper-progress {
///       --paper-progress-secondary-color: #f8bbd0;
///     }
///
/// To change the progress bar background color:
///
///     paper-progress {
///       --paper-progress-container-color: #64ffda;
///     }
///
/// Add the class `transiting` to a paper-progress to animate the progress bar when
/// the value changed. You can also customize the transition:
///
///     paper-progress {
///       --paper-progress-transition-duration: 0.08s;
///       --paper-progress-transition-timing-function: ease;
///       --paper-progress-transition-transition-delay: 0s;
///     }
///
/// The following mixins are available for styling:
///
///
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--paper-progress-container` | Mixin applied to container | `{}`
@CustomElementProxy('paper-progress')
class PaperProgress extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronRangeBehavior {
  PaperProgress.created() : super.created();
  factory PaperProgress() => new Element.tag('paper-progress');

  /// Use an indeterminate progress indicator.
  bool get indeterminate => jsElement[r'indeterminate'];
  set indeterminate(bool value) { jsElement[r'indeterminate'] = value; }

  /// The number that represents the current secondary progress.
  num get secondaryProgress => jsElement[r'secondaryProgress'];
  set secondaryProgress(num value) { jsElement[r'secondaryProgress'] = value; }

  /// The secondary ratio
  num get secondaryRatio => jsElement[r'secondaryRatio'];
  set secondaryRatio(num value) { jsElement[r'secondaryRatio'] = value; }
}
