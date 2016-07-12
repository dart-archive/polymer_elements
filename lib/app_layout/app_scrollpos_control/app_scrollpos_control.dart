// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_scrollpos_control`.
@HtmlImport('app_scrollpos_control_nodart.html')
library polymer_elements.lib.src.app_layout.app_scrollpos_control.app_scrollpos_control;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../app_layout/helpers/helpers.dart';

/// app-scrollpos-control is a manager for saving and restoring the scroll position when multiple
/// pages are sharing the same document scroller.
///
/// Example:
///
/// ```html
/// <app-scrollpos-control selected="{{page}}"></app-scrollpos-control>
///
/// <app-drawer-layout>
///
///   <app-drawer>
///     <paper-menu selected="{{page}}">
///       <paper-item>Home</paper-item>
///       <paper-item>About</paper-item>
///       <paper-item>Schedule</paper-item>
///       <paper-item>Account</paper-item>
///     </paper-menu>
///   </app-drawer>
///
///   <div>
///     <app-toolbar>
///       <paper-icon-button icon="menu" drawer-toggle></paper-icon-button>
///     </app-toolbar>
///     <iron-pages selected="{{page}}">
///       <sample-content size="100"></sample-content>
///       <sample-content size="100"></sample-content>
///       <sample-content size="100"></sample-content>
///       <sample-content size="100"></sample-content>
///     </iron-pages>
///   </div>
///
/// </app-drawer-layout>
/// ```
@CustomElementProxy('app-scrollpos-control')
class AppScrollposControl extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  AppScrollposControl.created() : super.created();
  factory AppScrollposControl() => new Element.tag('app-scrollpos-control');

  /// Reset the scroll position to 0.
  bool get reset => jsElement[r'reset'];
  set reset(bool value) { jsElement[r'reset'] = value; }

  /// The selected page.
  String get selected => jsElement[r'selected'];
  set selected(String value) { jsElement[r'selected'] = value; }
}
