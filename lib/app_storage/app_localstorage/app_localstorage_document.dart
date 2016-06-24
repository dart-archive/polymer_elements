// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_localstorage_document`.
@HtmlImport('app_localstorage_document_nodart.html')
library polymer_elements.lib.src.app_storage.app_localstorage.app_localstorage_document;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../app_storage_behavior.dart';

/// app-localstorage-document synchronizes storage between an in-memory
/// value and a location in the browser's localStorage system.
///
/// localStorage is a simple and widely supported storage API that provides both
/// permanent and session-based storage options. Using app-localstorage-document
/// you can easily integrate localStorage into your app via normal Polymer
/// databinding.
///
/// app-localstorage-document is the reference implementation of an element
/// that uses `AppStorageBehavior`. Reading its code is a good way to get
/// started writing your own storage element.
///
/// Example use:
///
///     <paper-input value="{{search}}"></paper-input>
///     <app-localstorage-document key="search" data="{{search}}">
///     </app-localstorage-document>
///
/// app-localstorage-document automatically synchronizes changes to the
/// same key across multiple tabs.
///
/// Only supports storing JSON-serializable values.
@CustomElementProxy('app-localstorage-document')
class AppLocalstorageDocument extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppStorageBehavior {
  AppLocalstorageDocument.created() : super.created();
  factory AppLocalstorageDocument() => new Element.tag('app-localstorage-document');

  get isNew => jsElement[r'isNew'];

  /// Defines the logical location to store the data.
  String get key => jsElement[r'key'];
  set key(String value) { jsElement[r'key'] = value; }

  /// If true, the data will automatically be cleared from storage when
  /// the page session ends (i.e. when the user has navigated away from
  /// the page).
  bool get sessionOnly => jsElement[r'sessionOnly'];
  set sessionOnly(bool value) { jsElement[r'sessionOnly'] = value; }

  /// Either `window.localStorage` or `window.sessionStorage`, depending on
  /// `this.sessionOnly`.
  get storage => jsElement[r'storage'];
  set storage(value) { jsElement[r'storage'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  destroy() =>
      jsElement.callMethod('destroy', []);

  getStoredValue(path) =>
      jsElement.callMethod('getStoredValue', [path]);

  reset() =>
      jsElement.callMethod('reset', []);

  /// Stores a value at the given key, and if successful, updates this.key.
  /// [key]: The new key to use.
  save([key]) => //(String key) =>
      jsElement.callMethod('save', [key]);

  setStoredValue(path, value) =>
      jsElement.callMethod('setStoredValue', [path, value]);
}
