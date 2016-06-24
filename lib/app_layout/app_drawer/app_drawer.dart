// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_drawer`.
@HtmlImport('app_drawer_nodart.html')
library polymer_elements.lib.src.app_layout.app_drawer.app_drawer;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../iron_flex_layout.dart';

/// app-drawer is a navigation drawer that can slide in from the left or right.
///
/// Example:
///
/// Align the drawer at the start, which is left in LTR layouts (default):
///
/// ```html
/// <app-drawer opened></app-drawer>
/// ```
///
/// Align the drawer at the end:
///
/// ```html
/// <app-drawer align="end" opened></app-drawer>
/// ```
///
/// To make the contents of the drawer scrollable, create a wrapper for the scroll
/// content, and apply height and overflow styles to it.
///
/// ```html
/// <app-drawer>
///   <div style="height: 100%; overflow: auto;"></div>
/// </app-drawer>
/// ```
///
/// ### Styling
///
/// Custom property                  | Description                            | Default
/// ---------------------------------|----------------------------------------|--------------------
/// `--app-drawer-width`             | Width of the drawer                    | 256px
/// `--app-drawer-content-container` | Mixin for the drawer content container | {}
/// `--app-drawer-scrim-background`  | Background for the scrim               | rgba(0, 0, 0, 0.5)
@CustomElementProxy('app-drawer')
class AppDrawer extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  AppDrawer.created() : super.created();
  factory AppDrawer() => new Element.tag('app-drawer');

  /// The alignment of the drawer on the screen ('left', 'right', 'start' or 'end').
  /// 'start' computes to left and 'end' to right in LTR layout and vice versa in RTL
  /// layout.
  String get align => jsElement[r'align'];
  set align(String value) { jsElement[r'align'] = value; }

  /// Trap keyboard focus when the drawer is opened and not persistent.
  bool get noFocusTrap => jsElement[r'noFocusTrap'];
  set noFocusTrap(bool value) { jsElement[r'noFocusTrap'] = value; }

  /// The opened state of the drawer.
  bool get opened => jsElement[r'opened'];
  set opened(bool value) { jsElement[r'opened'] = value; }

  /// The drawer does not have a scrim and cannot be swiped close.
  bool get persistent => jsElement[r'persistent'];
  set persistent(bool value) { jsElement[r'persistent'] = value; }

  /// The computed, read-only position of the drawer on the screen ('left' or 'right').
  String get position => jsElement[r'position'];
  set position(String value) { jsElement[r'position'] = value; }

  /// Create an area at the edge of the screen to swipe open the drawer.
  bool get swipeOpen => jsElement[r'swipeOpen'];
  set swipeOpen(bool value) { jsElement[r'swipeOpen'] = value; }

  /// Closes the drawer.
  close() =>
      jsElement.callMethod('close', []);

  /// Gets the width of the drawer.
  num getWidth() =>
      jsElement.callMethod('getWidth', []);

  /// Opens the drawer.
  open() =>
      jsElement.callMethod('open', []);

  /// Resets the layout. If you changed the size of app-header via CSS
  /// you can notify the changes by either firing the `iron-resize` event
  /// or calling `resetLayout` directly.
  resetLayout() =>
      jsElement.callMethod('resetLayout', []);

  /// Toggles the drawer open and close.
  toggle() =>
      jsElement.callMethod('toggle', []);
}
