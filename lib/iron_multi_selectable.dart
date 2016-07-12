// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_multi_selectable`.
@HtmlImport('iron_multi_selectable_nodart.html')
library polymer_elements.lib.src.iron_selector.iron_multi_selectable;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_selectable.dart';


@BehaviorProxy(const ['Polymer', 'IronMultiSelectableBehavior'])
abstract class IronMultiSelectableBehavior implements CustomElementProxyMixin, IronSelectableBehavior {

  /// If true, multiple selections are allowed.
  bool get multi => jsElement[r'multi'];
  set multi(bool value) { jsElement[r'multi'] = value; }

  /// Returns an array of currently selected items.
  List get selectedItems => jsElement[r'selectedItems'];
  set selectedItems(List value) { jsElement[r'selectedItems'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Gets or sets the selected elements. This is used instead of `selected` when `multi`
  /// is true.
  List get selectedValues => jsElement[r'selectedValues'];
  set selectedValues(List value) { jsElement[r'selectedValues'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  multiChanged(multi) =>
      jsElement.callMethod('multiChanged', [multi]);

  /// Selects the given value. If the `multi` property is true, then the selected state of the
  /// `value` will be toggled; otherwise the `value` will be selected.
  /// [value]: the value to select.
  select(value) =>
      jsElement.callMethod('select', [value]);
}
