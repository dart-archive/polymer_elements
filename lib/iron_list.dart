// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_list`.
@HtmlImport('iron_list_nodart.html')
library polymer_elements.lib.src.iron_list.iron_list;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'iron_a11y_keys_behavior.dart';
import 'iron_scroll_target_behavior.dart';

/// `iron-list` displays a virtual, 'infinite' list. The template inside
/// the iron-list element represents the DOM to create for each list item.
/// The `items` property specifies an array of list item data.
///
/// For performance reasons, not every item in the list is rendered at once;
/// instead a small subset of actual template elements *(enough to fill the viewport)*
/// are rendered and reused as the user scrolls. As such, it is important that all
/// state of the list template be bound to the model driving it, since the view may
/// be reused with a new model at any time. Particularly, any state that may change
/// as the result of a user interaction with the list item must be bound to the model
/// to avoid view state inconsistency.
///
/// __Important:__ `iron-list` must either be explicitly sized, or delegate scrolling to an
/// explicitly sized parent. By "explicitly sized", we mean it either has an explicit
/// CSS `height` property set via a class or inline style, or else is sized by other
/// layout means (e.g. the `flex` or `fit` classes).
///
/// ### Template model
///
/// List item templates should bind to template models of the following structure:
///
/// ```js
/// {
///   index: 0,        // index in the item array
///   selected: false, // true if the current item is selected
///   tabIndex: -1,    // a dynamically generated tabIndex for focus management
///   item: {}         // user data corresponding to items[index]
/// }
/// ```
///
/// Alternatively, you can change the property name used as data index by changing the
/// `indexAs` property. The `as` property defines the name of the variable to add to the binding
/// scope for the array.
///
/// For example, given the following `data` array:
///
/// ##### data.json
///
/// ```js
/// [
///   {"name": "Bob"},
///   {"name": "Tim"},
///   {"name": "Mike"}
/// ]
/// ```
///
/// The following code would render the list (note the name and checked properties are
/// bound from the model object provided to the template scope):
///
/// ```html
/// <template is="dom-bind">
///   <iron-ajax url="data.json" last-response="{{data}}" auto></iron-ajax>
///   <iron-list items="[[data]]" as="item">
///     <template>
///       <div>
///         Name: [[item.name]]
///       </div>
///     </template>
///   </iron-list>
/// </template>
/// ```
///
/// ### Grid layout
///
/// `iron-list` supports a grid layout in addition to linear layout by setting
/// the `grid` attribute.  In this case, the list template item must have both fixed
/// width and height (e.g. via CSS). Based on this, the number of items
/// per row are determined automatically based on the size of the list viewport.
///
/// ### Accessibility
///
/// `iron-list` automatically manages the focus state for the items. It also provides
/// a `tabIndex` property within the template scope that can be used for keyboard navigation.
/// For example, users can press the up and down keys to move to previous and next
/// items in the list:
///
/// ```html
/// <iron-list items="[[data]]" as="item">
///   <template>
///     <div tabindex$="[[tabIndex]]">
///       Name: [[item.name]]
///     </div>
///   </template>
/// </iron-list>
/// ```
///
/// ### Styling
///
/// You can use the `--iron-list-items-container` mixin to style the container of items:
///
/// ```css
/// iron-list {
///  --iron-list-items-container: {
///     margin: auto;
///   };
/// }
/// ```
///
/// ### Resizing
///
/// `iron-list` lays out the items when it receives a notification via the `iron-resize` event.
/// This event is fired by any element that implements `IronResizableBehavior`.
///
/// By default, elements such as `iron-pages`, `paper-tabs` or `paper-dialog` will trigger
/// this event automatically. If you hide the list manually (e.g. you use `display: none`)
/// you might want to implement `IronResizableBehavior` or fire this event manually right
/// after the list became visible again. For example:
///
/// ```js
/// document.querySelector('iron-list').fire('iron-resize');
/// ```
///
/// ### When should `<iron-list>` be used?
///
/// `iron-list` should be used when a page has significantly more DOM nodes than the ones
/// visible on the screen. e.g. the page has 500 nodes, but only 20 are visible at the time.
/// This is why we refer to it as a `virtual` list. In this case, a `dom-repeat` will still
/// create 500 nodes which could slow down the web app, but `iron-list` will only create 20.
///
/// However, having an `iron-list` does not mean that you can load all the data at once.
/// Say, you have a million records in the database, you want to split the data into pages
/// so you can bring a page at the time. The page could contain 500 items, and iron-list
/// will only render 20.
@CustomElementProxy('iron-list')
class IronList extends HtmlElement with CustomElementProxyMixin, PolymerBase, Templatizer, IronResizableBehavior, IronA11yKeysBehavior, IronScrollTargetBehavior {
  IronList.created() : super.created();
  factory IronList() => new Element.tag('iron-list');

  /// The name of the variable to add to the binding scope for the array
  /// element associated with a given template instance.
  String get as => jsElement[r'as'];
  set as(String value) { jsElement[r'as'] = value; }

  /// Gets the index of the first visible item in the viewport.
  num get firstVisibleIndex => jsElement[r'firstVisibleIndex'];
  set firstVisibleIndex(num value) { jsElement[r'firstVisibleIndex'] = value; }

  /// When true, the list is rendered as a grid. Grid items must have
  /// fixed width and height set via CSS. e.g.
  ///
  /// ```html
  /// <iron-list grid>
  ///   <template>
  ///      <div style="width: 100px; height: 100px;"> 100x100 </div>
  ///   </template>
  /// </iron-list>
  /// ```
  bool get grid => jsElement[r'grid'];
  set grid(bool value) { jsElement[r'grid'] = value; }

  /// The name of the variable to add to the binding scope with the index
  /// for the row.
  String get indexAs => jsElement[r'indexAs'];
  set indexAs(String value) { jsElement[r'indexAs'] = value; }

  /// An array containing items determining how many instances of the template
  /// to stamp and that that each template instance should bind to.
  List get items => jsElement[r'items'];
  set items(List value) { jsElement[r'items'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Gets the index of the last visible item in the viewport.
  num get lastVisibleIndex => jsElement[r'lastVisibleIndex'];
  set lastVisibleIndex(num value) { jsElement[r'lastVisibleIndex'] = value; }

  /// The max count of physical items the pool can extend to.
  num get maxPhysicalCount => jsElement[r'maxPhysicalCount'];
  set maxPhysicalCount(num value) { jsElement[r'maxPhysicalCount'] = value; }

  /// When `true`, multiple items may be selected at once (in this case,
  /// `selected` is an array of currently selected items).  When `false`,
  /// only one item may be selected at a time.
  bool get multiSelection => jsElement[r'multiSelection'];
  set multiSelection(bool value) { jsElement[r'multiSelection'] = value; }

  /// The name of the variable to add to the binding scope to indicate
  /// if the row is selected.
  String get selectedAs => jsElement[r'selectedAs'];
  set selectedAs(String value) { jsElement[r'selectedAs'] = value; }

  /// When `multiSelection` is false, this is the currently selected item, or `null`
  /// if no item is selected.
  get selectedItem => jsElement[r'selectedItem'];
  set selectedItem(value) { jsElement[r'selectedItem'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// When `multiSelection` is true, this is an array that contains the selected items.
  get selectedItems => jsElement[r'selectedItems'];
  set selectedItems(value) { jsElement[r'selectedItems'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// When true, tapping a row will select the item, placing its data model
  /// in the set of selected items retrievable via the selection property.
  ///
  /// Note that tapping focusable elements within the list item will not
  /// result in selection, since they are presumed to have their * own action.
  bool get selectionEnabled => jsElement[r'selectionEnabled'];
  set selectionEnabled(bool value) { jsElement[r'selectionEnabled'] = value; }

  /// Clears the current selection state of the list.
  clearSelection() =>
      jsElement.callMethod('clearSelection', []);

  /// Deselects the given item list if it is already selected.
  /// [item]: The item object or its index
  deselectItem(item) =>
      jsElement.callMethod('deselectItem', [item]);

  /// Scroll to a specific index in the virtual list regardless
  /// of the physical items in the DOM tree.
  /// [idx]: The index of the item
  scrollToIndex(num idx) =>
      jsElement.callMethod('scrollToIndex', [idx]);

  /// Scroll to a specific item in the virtual list regardless
  /// of the physical items in the DOM tree.
  /// [item]: The item to be scrolled to
  scrollToItem(item) =>
      jsElement.callMethod('scrollToItem', [item]);

  /// Select the list item at the given index.
  /// [item]: The item object or its index
  selectItem(item) =>
      jsElement.callMethod('selectItem', [item]);

  /// Select or deselect a given item depending on whether the item
  /// has already been selected.
  /// [item]: The item object or its index
  toggleSelectionForItem(item) =>
      jsElement.callMethod('toggleSelectionForItem', [item]);

  /// Updates the size of an item.
  /// [item]: The item object or its index
  updateSizeForItem(item) =>
      jsElement.callMethod('updateSizeForItem', [item]);

  /// Invoke this method if you dynamically update the viewport's
  /// size or CSS padding.
  updateViewportBoundaries() =>
      jsElement.callMethod('updateViewportBoundaries', []);
}
