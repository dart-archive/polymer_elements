// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_swipeable_container`.
@HtmlImport('iron_swipeable_container_nodart.html')
library polymer_elements.lib.src.iron_swipeable_container.iron_swipeable_container;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `<iron-swipeable-container>` is a container that allows any of its nested
/// children (native or custom elements) to be swiped away. By default it supports
/// a curved or horizontal transition, but the transition duration and properties
/// can be customized.
///
/// Example:
///
///     <iron-swipeable-container>
///       <div>I can be swiped</div>
///       <paper-card heading="Me too!"></paper-card>
///     </iron-swipeable-container>
///
/// To disable swiping on individual children, you must give them the `.disable-swipe`
/// class. Alternatively, to disable swiping on the whole container, you can use its
/// `disable-swipe` attribute:
///
///     <iron-swipeable-container>
///       <div class="disable-swipe">I cannot be swiped be swiped</div>
///       <paper-card heading="But I can!"></paper-card>
///     </iron-swipeable-container>
///
///     <iron-swipeable-container disable-swipe>
///       <div>I cannot be swiped</div>
///       <paper-card heading="Me neither :("></paper-card>
///     </iron-swipeable-container>
///
/// It is a good idea to disable text selection on any of the children that you
/// want to be swiped:
///
///     .swipe {
///       -moz-user-select: none;
///       -ms-user-select: none;
///       -webkit-user-select: none;
///       user-select: none;
///       cursor: default;
///     }
@CustomElementProxy('iron-swipeable-container')
class IronSwipeableContainer extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronSwipeableContainer.created() : super.created();
  factory IronSwipeableContainer() => new Element.tag('iron-swipeable-container');

  /// If true, then the container will not allow swiping.
  bool get disabled => jsElement[r'disabled'];
  set disabled(bool value) { jsElement[r'disabled'] = value; }

  /// The ratio of the total animation distance after which the opacity
  /// transformation begins. For example, if the `widthRatio` is 1 and
  /// the `opacityRate` is 0.5, then the element needs to travel half its
  /// width before its opacity starts decreasing.
  num get opacityRate => jsElement[r'opacityRate'];
  set opacityRate(num value) { jsElement[r'opacityRate'] = value; }

  /// The style in which to swipe the card. Currently supported
  /// options are `curve | horizontal`. If left unspecified, the default
  /// is assumed to be `horizontal`.
  String get swipeStyle => jsElement[r'swipeStyle'];
  set swipeStyle(String value) { jsElement[r'swipeStyle'] = value; }

  /// The CSS transition applied while swiping.
  String get transition => jsElement[r'transition'];
  set transition(String value) { jsElement[r'transition'] = value; }

  /// The ratio of the width of the element that the translation animation
  /// should happen over. For example, if the `widthRatio` is 3, the
  /// animation will take place on a distance 3 times the width of the
  /// element being swiped.
  num get widthRatio => jsElement[r'widthRatio'];
  set widthRatio(num value) { jsElement[r'widthRatio'] = value; }
}
