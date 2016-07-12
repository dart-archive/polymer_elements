// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_toolbar`.
@HtmlImport('app_toolbar_nodart.html')
library polymer_elements.lib.src.app_layout.app_toolbar.app_toolbar;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../iron_flex_layout.dart';

/// app-toolbar is a horizontal toolbar containing items that can be used for
/// label, navigation, search and actions.
///
/// ### Example
///
/// Add a title to the toolbar.
///
/// ```html
/// <app-toolbar>
///   <div title>App name</div>
/// </app-toolbar>
/// ```
///
/// Add a button to the left and right side of the toolbar.
///
/// ```html
/// <app-toolbar>
///   <paper-icon-button icon="menu"></paper-icon-button>
///   <div title>App name</div>
///   <paper-icon-button icon="search"></paper-icon-button>
/// </app-toolbar>
/// ```
///
/// You can use the attributes `top-item` or `bottom-item` to completely fit an element
/// to the top or bottom of the toolbar respectively.
///
/// ### Content attributes
///
/// Attribute            | Description
/// ---------------------|---------------------------------------------------------
/// `title`              | The main title element.
/// `condensed-title`    | The title element if used inside a condensed app-header.
/// `spacer`             | Adds a left margin of `64px`.
/// `bottom-item`        | Sticks the element to the bottom of the toolbar.
/// `top-item`           | Sticks the element to the top of the toolbar.
///
/// ### Styling
///
/// Custom property              | Description                  | Default
/// -----------------------------|------------------------------|-----------------------
/// `--app-toolbar-font-size`    | Toolbar font size            | 20px
@CustomElementProxy('app-toolbar')
class AppToolbar extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  AppToolbar.created() : super.created();
  factory AppToolbar() => new Element.tag('app-toolbar');
}
