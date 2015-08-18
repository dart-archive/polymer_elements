// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_toast`.
@HtmlImport('paper_toast_nodart.html')
library polymer_elements.lib.src.paper_toast.paper_toast;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'typography.dart';
import 'iron_a11y_announcer.dart';

/// `paper-toast` provides a subtle notification toast.
@CustomElementProxy('paper-toast')
class PaperToast extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PaperToast.created() : super.created();
  factory PaperToast() => new Element.tag('paper-toast');

  /// The duration in milliseconds to show the toast.
  num get duration => jsElement[r'duration'];
  set duration(num value) { jsElement[r'duration'] = value; }

  /// The text to display in the toast.
  String get text => jsElement[r'text'];
  set text(String value) { jsElement[r'text'] = value; }

  /// True if the toast is currently visible.
  bool get visible => jsElement[r'visible'];
  set visible(bool value) { jsElement[r'visible'] = value; }

  /// Hide the toast
  void hide() =>
      jsElement.callMethod('hide', []);

  /// Show the toast.
  void show() =>
      jsElement.callMethod('show', []);

  /// Toggle the opened state of the toast.
  void toggle() =>
      jsElement.callMethod('toggle', []);
}
