// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_header_layout`.
@HtmlImport('app_header_layout_nodart.html')
library polymer_elements.lib.src.app_layout.app_header_layout.app_header_layout;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../iron_resizable_behavior.dart';
import '../../iron_flex_layout.dart';

/// app-header-layout is a wrapper element that positions an app-header and other content. This
/// element uses the document scroll by default, but it can also define its own scrolling region.
///
/// Using the document scroll:
///
/// ```html
/// <app-header-layout>
///   <app-header fixed condenses effects="waterfall">
///     <app-toolbar>
///       <div title>App name</div>
///     </app-toolbar>
///   </app-header>
///   <div>
///     main content
///   </div>
/// </app-header-layout>
/// ```
///
/// Using an own scrolling region:
///
/// ```html
/// <app-header-layout has-scrolling-region style="width: 300px; height: 400px;">
///   <app-header fixed condenses effects="waterfall">
///     <app-toolbar>
///       <div title>App name</div>
///     </app-toolbar>
///   </app-header>
///   <div>
///     main content
///   </div>
/// </app-header-layout>
/// ```
@CustomElementProxy('app-header-layout')
class AppHeaderLayout extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  AppHeaderLayout.created() : super.created();
  factory AppHeaderLayout() => new Element.tag('app-header-layout');

  /// If true, the current element will have its own scrolling region.
  /// Otherwise, it will use the document scroll to control the header.
  bool get hasScrollingRegion => jsElement[r'hasScrollingRegion'];
  set hasScrollingRegion(bool value) { jsElement[r'hasScrollingRegion'] = value; }

  /// A reference to the app-header element.
  get header => jsElement[r'header'];

  /// Resets the layout. This method is automatically called when the element is attached
  /// to the DOM.
  resetLayout() =>
      jsElement.callMethod('resetLayout', []);
}
