// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_spinner_behavior`.
@HtmlImport('paper_spinner_behavior_nodart.html')
library polymer_elements.lib.src.paper_spinner.paper_spinner_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';


@BehaviorProxy(const ['Polymer', 'PaperSpinnerBehavior'])
abstract class PaperSpinnerBehavior implements CustomElementProxyMixin {

  /// Displays the spinner.
  bool get active => jsElement[r'active'];
  set active(bool value) { jsElement[r'active'] = value; }

  /// Alternative text content for accessibility support.
  /// If alt is present, it will add an aria-label whose content matches alt when active.
  /// If alt is not present, it will default to 'loading' as the alt value.
  String get alt => jsElement[r'alt'];
  set alt(String value) { jsElement[r'alt'] = value; }
}
