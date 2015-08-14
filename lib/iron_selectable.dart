// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_selectable`.
@HtmlImport('iron_selectable_nodart.html')
library polymer_elements.lib.src.iron_selector.iron_selectable;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_selection.dart';


@BehaviorProxy(const ['Polymer', 'IronSelectableBehavior'])
abstract class IronSelectableBehavior implements CustomElementProxyMixin {

  /// The event that fires from items when they are selected. Selectable
  /// will listen for this event from items and update the selection state.
  /// Set to empty string to listen to no events.
  String get activateEvent => jsElement[r'activateEvent'];
  set activateEvent(String value) { jsElement[r'activateEvent'] = value; }

  /// If you want to use the attribute value of an element for `selected` instead of the index,
  /// set this to the name of the attribute.
  String get attrForSelected => jsElement[r'attrForSelected'];
  set attrForSelected(String value) { jsElement[r'attrForSelected'] = value; }

  get excludedLocalNames => jsElement[r'excludedLocalNames'];
  set excludedLocalNames(value) { jsElement[r'excludedLocalNames'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Returns an array of selectable items.
  get items => jsElement[r'items'];

  /// This is a CSS selector sting.  If this is set, only items that matches the CSS selector
  /// are selectable.
  String get selectable => jsElement[r'selectable'];
  set selectable(String value) { jsElement[r'selectable'] = value; }

  /// Gets or sets the selected element. The default is to use the index of the item.
  get selected => jsElement[r'selected'];
  set selected(value) { jsElement[r'selected'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// The attribute to set on elements when selected.
  String get selectedAttribute => jsElement[r'selectedAttribute'];
  set selectedAttribute(String value) { jsElement[r'selectedAttribute'] = value; }

  /// The class to set on elements when selected.
  String get selectedClass => jsElement[r'selectedClass'];
  set selectedClass(String value) { jsElement[r'selectedClass'] = value; }

  /// Returns the currently selected item.
  get selectedItem => jsElement[r'selectedItem'];
  set selectedItem(value) { jsElement[r'selectedItem'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Returns the index of the given item.
  void indexOf(item) =>
      jsElement.callMethod('indexOf', [item]);

  /// Selects the given value.
  /// [value]: the value to select.
  void select(String value) =>
      jsElement.callMethod('select', [value]);

  /// Selects the next item.
  void selectNext() =>
      jsElement.callMethod('selectNext', []);

  /// Selects the previous item.
  void selectPrevious() =>
      jsElement.callMethod('selectPrevious', []);
}
