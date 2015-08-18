// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_list`.
@HtmlImport('iron_list_nodart.html')
library polymer_elements.lib.src.iron_list.iron_list;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';

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
/// __Important:__ `iron-list` must ether be explicitly sized, or delegate scrolling to an
/// explicitly sized parent. By "explicitly sized", we mean it either has an explicit
/// CSS `height` property set via a class or inline style, or else is sized by other
/// layout means (e.g. the `flex` or `fit` classes).
///
/// ### Template model
///
/// List item templates should bind to template models of the following structure:
///
///     {
///       index: 0,     // data index for this item
///       item: {       // user data corresponding to items[index]
///         /* user item data  */
///       }
///     }
///
/// Alternatively, you can change the property name used as data index by changing the
/// `indexAs` property. The `as` property defines the name of the variable to add to the binding
/// scope for the array.
///
/// For example, given the following `data` array:
///
/// ##### data.json
///
///     [
///       {"name": "Bob"},
///       {"name": "Tim"},
///       {"name": "Mike"}
///     ]
///
/// The following code would render the list (note the name and checked properties are
/// bound from the model object provided to the template scope):
///
///     <template is="dom-bind">
///       <iron-ajax url="data.json" last-response="{{data}}" auto></iron-ajax>
///       <iron-list items="[[data]]" as="item">
///         <template>
///           <div>
///             Name: <span>[[item.name]]</span>
///           </div>
///         </template>
///       </iron-list>
///     </template>
///
/// ### Resizing
///
/// `iron-list` lays out the items when it recives a notification via the `resize` event.
/// This event is fired by any element that implements `IronResizableBehavior`.
///
/// By default, elements such as `iron-pages`, `paper-tabs` or `paper-dialog` will trigger
/// this event automatically. If you hide the list manually (e.g. you use `display: none`)
/// you might want to implement `IronResizableBehavior` or fire this event manually right
/// after the list became visible again. e.g.
///
///     document.querySelector('iron-list').fire('resize');
@CustomElementProxy('iron-list')
class IronList extends HtmlElement with CustomElementProxyMixin, PolymerBase, Templatizer, IronResizableBehavior {
  IronList.created() : super.created();
  factory IronList() => new Element.tag('iron-list');

  /// The name of the variable to add to the binding scope for the array
  /// element associated with a given template instance.
  String get as => jsElement[r'as'];
  set as(String value) { jsElement[r'as'] = value; }

  /// Gets the first visible item in the viewport.
  get firstVisibleIndex => jsElement[r'firstVisibleIndex'];

  /// The name of the variable to add to the binding scope with the index
  /// for the row.  If `sort` is provided, the index will reflect the
  /// sorted order (rather than the original array order).
  String get indexAs => jsElement[r'indexAs'];
  set indexAs(String value) { jsElement[r'indexAs'] = value; }

  /// An array containing items determining how many instances of the template
  /// to stamp and that that each template instance should bind to.
  List get items => jsElement[r'items'];
  set items(List value) { jsElement[r'items'] = (value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Scroll to a specific item in the virtual list regardless
  /// of the physical items in the DOM tree.
  void scrollToIndex(idx) =>
      jsElement.callMethod('scrollToIndex', [idx]);

  /// Invoke this method if you dynamically update the viewport's
  /// size or CSS padding.
  void updateViewportBoundaries() =>
      jsElement.callMethod('updateViewportBoundaries', []);
}
