// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_drawer_layout`.
@HtmlImport('app_drawer_layout_nodart.html')
library polymer_elements.lib.src.app_layout.app_drawer_layout.app_drawer_layout;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../iron_resizable_behavior.dart';
import '../../iron_media_query.dart';
import '../../app_layout/app_drawer/app_drawer.dart';

/// app-drawer-layout is a wrapper element that positions an app-drawer and other content. When
/// the viewport width is smaller than `responsiveWidth`, this element changes to narrow layout.
/// In narrow layout, the drawer will be stacked on top of the main content. The drawer will slide
/// in/out to hide/reveal the main content.
///
/// By default the drawer is aligned to the start, which is left in LTR layouts:
///
/// ```html
/// <app-drawer-layout>
///   <app-drawer>
///     drawer content
///   </app-drawer>
///   <div>
///     main content
///   </div>
/// </app-drawer-layout>
/// ```
///
/// Align the drawer at the end:
///
/// ```html
/// <app-drawer-layout>
///   <app-drawer align="end">
///      drawer content
///   </app-drawer>
///   <div>
///     main content
///   </div>
/// </app-drawer-layout>
/// ```
///
/// With an app-header-layout:
///
/// ```html
/// <app-drawer-layout>
///   <app-drawer>
///     drawer-content
///   </app-drawer>
///   <app-header-layout>
///     <app-header>
///       <app-toolbar>
///         <div title>App name</div>
///       </app-toolbar>
///     </app-header>
///
///     main content
///
///   </app-header-layout>
/// </app-drawer-layout>
/// ```
///
/// Add the `drawer-toggle` attribute to elements inside `app-drawer-layout` that toggle the drawer on tap events:
///
/// ```html
/// <app-drawer-layout>
///   <app-drawer>
///     drawer-content
///   </app-drawer>
///   <app-header-layout>
///     <app-header>
///       <app-toolbar>
///         <paper-icon-button icon="menu" drawer-toggle></paper-icon-button>
///         <div title>App name</div>
///       </app-toolbar>
///     </app-header>
///
///     main content
///
///   </app-header-layout>
/// </app-drawer-layout>
/// ```
///
/// Add the `fullbleed` attribute to app-drawer-layout to make it fit the size of its container:
///
/// ```html
/// <app-drawer-layout fullbleed>
///   <app-drawer>
///      drawer content
///   </app-drawer>
///   <div>
///     main content
///   </div>
/// </app-drawer-layout>
/// ```
///
/// ### Styling
///
/// Custom property                          | Description                          | Default
/// -----------------------------------------|--------------------------------------|---------
/// `--app-drawer-layout-content-transition` | Transition for the content container | none
@CustomElementProxy('app-drawer-layout')
class AppDrawerLayout extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronResizableBehavior {
  AppDrawerLayout.created() : super.created();
  factory AppDrawerLayout() => new Element.tag('app-drawer-layout');

  /// A reference to the app-drawer element.
  get drawer => jsElement[r'drawer'];

  /// If true, ignore `responsiveWidth` setting and force the narrow layout.
  bool get forceNarrow => jsElement[r'forceNarrow'];
  set forceNarrow(bool value) { jsElement[r'forceNarrow'] = value; }

  /// Returns true if it is in narrow layout. This is useful if you need to show/hide
  /// elements based on the layout.
  bool get narrow => jsElement[r'narrow'];
  set narrow(bool value) { jsElement[r'narrow'] = value; }

  /// If the viewport's width is smaller than this value, the panel will change to narrow
  /// layout. In the mode the drawer will be closed.
  String get responsiveWidth => jsElement[r'responsiveWidth'];
  set responsiveWidth(String value) { jsElement[r'responsiveWidth'] = value; }

  resetLayout() =>
      jsElement.callMethod('resetLayout', []);
}
