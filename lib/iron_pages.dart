// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_pages`.
@HtmlImport('iron_pages_nodart.html')
library polymer_elements.lib.src.iron_pages.iron_pages;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_resizable_behavior.dart';
import 'iron_selectable.dart';

/// `iron-pages` is used to select one of its children to show. One use is to cycle through a list of
/// children "pages".
///
/// Example:
///
///     <iron-pages selected="0">
///       <div>One</div>
///       <div>Two</div>
///       <div>Three</div>
///     </iron-pages>
///
///     <script>
///       document.addEventListener('click', function(e) {
///         var pages = document.querySelector('iron-pages');
///         pages.selectNext();
///       });
///     </script>
@CustomElementProxy('iron-pages')
class IronPages extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior, IronSelectableBehavior {
  IronPages.created() : super.created();
  factory IronPages() => new Element.tag('iron-pages');

  /// handler immediately changes it back
  String get activateEvent => jsElement[r'activateEvent'];
  set activateEvent(String value) { jsElement[r'activateEvent'] = value; }
}
