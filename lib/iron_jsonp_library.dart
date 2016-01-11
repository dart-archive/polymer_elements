// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_jsonp_library`.
@HtmlImport('iron_jsonp_library_nodart.html')
library polymer_elements.lib.src.iron_jsonp_library.iron_jsonp_library;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_jsonp_library.dart';

/// Loads specified jsonp library.
///
/// Example:
///
///     <iron-jsonp-library
///       library-url="https://apis.google.com/js/plusone.js?onload=%callback%"
///       notify-event="api-load"
///       library-loaded="{{loaded}}"></iron-jsonp-library>
///
/// Will emit 'api-load' event when loaded, and set 'loaded' to true
///
/// Implemented by  Polymer.IronJsonpLibraryBehavior. Use it
/// to create specific library loader elements.
@CustomElementProxy('iron-jsonp-library')
class IronJsonpLibrary extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronJsonpLibraryBehavior {
  IronJsonpLibrary.created() : super.created();
  factory IronJsonpLibrary() => new Element.tag('iron-jsonp-library');

  /// Set if library requires specific callback name.
  /// Name will be automatically generated if not set.
  String get callbackName => jsElement[r'callbackName'];
  set callbackName(String value) { jsElement[r'callbackName'] = value; }

  /// Library url. Must contain string `%callback%`.
  ///
  /// `%callback%` is a placeholder for jsonp wrapper function name
  ///
  /// Ex: https://maps.googleapis.com/maps/api/js?callback=%callback%
  String get libraryUrl => jsElement[r'libraryUrl'];
  set libraryUrl(String value) { jsElement[r'libraryUrl'] = value; }

  /// event with name specified in 'notifyEvent' attribute
  /// will fire upon successful load
  String get notifyEvent => jsElement[r'notifyEvent'];
  set notifyEvent(String value) { jsElement[r'notifyEvent'] = value; }
}



/// `Polymer.IronJsonpLibraryBehavior` loads a jsonp library.
///     Multiple components can request same library, only one copy will load.
///
///     Some libraries require a specific global function be defined.
///     If this is the case, specify the `callbackName` property.
///
///     You should use an HTML Import to load library dependencies
///     when possible instead of using this element.
@BehaviorProxy(const ['Polymer', 'IronJsonpLibraryBehavior'])
abstract class IronJsonpLibraryBehavior implements CustomElementProxyMixin {

  /// Not null if library has failed to load
  String get libraryErrorMessage => jsElement[r'libraryErrorMessage'];
  set libraryErrorMessage(String value) { jsElement[r'libraryErrorMessage'] = value; }

  /// True if library has been successfully loaded
  bool get libraryLoaded => jsElement[r'libraryLoaded'];
  set libraryLoaded(bool value) { jsElement[r'libraryLoaded'] = value; }
}
