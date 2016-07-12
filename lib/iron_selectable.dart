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

  /// If you want to use an attribute value or property of an element for
  /// `selected` instead of the index, set this to the name of the attribute
  /// or property. Hyphenated values are converted to camel case when used to
  /// look up the property of a selectable element. Camel cased values are
  /// *not* converted to hyphenated values for attribute lookup. It's
  /// recommended that you provide the hyphenated form of the name so that
  /// selection works in both cases. (Use `attr-or-property-name` instead of
  /// `attrOrPropertyName`.)
  String get attrForSelected => jsElement[r'attrForSelected'];
  set attrForSelected(String value) { jsElement[r'attrForSelected'] = value; }

  /// Default fallback if the selection based on selected with `attrForSelected`
  /// is not found.
  String get fallbackSelection => jsElement[r'fallbackSelection'];
  set fallbackSelection(String value) { jsElement[r'fallbackSelection'] = value; }

  /// The list of items from which a selection can be made.
  List get items => jsElement[r'items'];
  set items(List value) { jsElement[r'items'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// This is a CSS selector string.  If this is set, only items that match the CSS selector
  /// are selectable.
  String get selectable => jsElement[r'selectable'];
  set selectable(String value) { jsElement[r'selectable'] = value; }

  /// Gets or sets the selected element. The default is to use the index of the item.
  get selected => jsElement[r'selected'];
  set selected(value) { jsElement[r'selected'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The attribute to set on elements when selected.
  String get selectedAttribute => jsElement[r'selectedAttribute'];
  set selectedAttribute(String value) { jsElement[r'selectedAttribute'] = value; }

  /// The class to set on elements when selected.
  String get selectedClass => jsElement[r'selectedClass'];
  set selectedClass(String value) { jsElement[r'selectedClass'] = value; }

  /// Returns the currently selected item.
  get selectedItem => jsElement[r'selectedItem'];
  set selectedItem(value) { jsElement[r'selectedItem'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Force a synchronous update of the `items` property.
  ///
  /// NOTE: Consider listening for the `iron-items-changed` event to respond to
  /// updates to the set of selectable items after updates to the DOM list and
  /// selection state have been made.
  ///
  /// WARNING: If you are using this method, you should probably consider an
  /// alternate approach. Synchronously querying for items is potentially
  /// slow for many use cases. The `items` property will update asynchronously
  /// on its own to reflect selectable items in the DOM.
  forceSynchronousItemUpdate() =>
      jsElement.callMethod('forceSynchronousItemUpdate', []);

  /// Returns the index of the given item.
  indexOf(item) =>
      jsElement.callMethod('indexOf', [item]);

  /// Selects the given value.
  /// [value]: the value to select.
  select(value) =>
      jsElement.callMethod('select', [value]);

  /// Selects the item at the given index.
  selectIndex(index) =>
      jsElement.callMethod('selectIndex', [index]);

  /// Selects the next item.
  selectNext() =>
      jsElement.callMethod('selectNext', []);

  /// Selects the previous item.
  selectPrevious() =>
      jsElement.callMethod('selectPrevious', []);
}
