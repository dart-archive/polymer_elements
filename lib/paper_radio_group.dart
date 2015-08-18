// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_radio_group`.
@HtmlImport('paper_radio_group_nodart.html')
library polymer_elements.lib.src.paper_radio_group.paper_radio_group;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_selectable.dart';
import 'paper_radio_button.dart';

/// `paper-radio-group` allows user to select only one radio button from a set.
/// Checking one radio button that belongs to a radio group unchecks any
/// previously checked radio button within the same group. Use
/// `selected` to get or set the selected radio button.
///
/// Example:
///
///     <paper-radio-group selected="small">
///       <paper-radio-button name="small">Small</paper-radio-button>
///       <paper-radio-button name="medium">Medium</paper-radio-button>
///       <paper-radio-button name="large">Large</paper-radio-button>
///     </paper-radio-group>
///
/// See <a href="paper-radio-button.html">paper-radio-button</a> for more
/// information about `paper-radio-button`.
@CustomElementProxy('paper-radio-group')
class PaperRadioGroup extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior, IronSelectableBehavior {
  PaperRadioGroup.created() : super.created();
  factory PaperRadioGroup() => new Element.tag('paper-radio-group');

  /// Overriden from Polymer.IronSelectableBehavior
  String get attrForSelected => jsElement[r'attrForSelected'];
  set attrForSelected(String value) { jsElement[r'attrForSelected'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Overriden from Polymer.IronSelectableBehavior
  String get selectable => jsElement[r'selectable'];
  set selectable(String value) { jsElement[r'selectable'] = value; }

  /// Overriden from Polymer.IronSelectableBehavior
  String get selectedAttribute => jsElement[r'selectedAttribute'];
  set selectedAttribute(String value) { jsElement[r'selectedAttribute'] = value; }

  /// Selects the given value.
  void select(value) =>
      jsElement.callMethod('select', [value]);

  /// Selects the next item. If the next item is disabled, then it is
  /// skipped, and the next item after it is selected.
  void selectNext() =>
      jsElement.callMethod('selectNext', []);

  /// Selects the previous item. If the previous item is disabled, then it is
  /// skipped, and its previous item is selected
  void selectPrevious() =>
      jsElement.callMethod('selectPrevious', []);
}
