// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_collection`.
@HtmlImport('firebase_collection_nodart.html')
library polymer_elements.lib.src.firebase_element.firebase_collection;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'firebase_query_behavior.dart';

/// An element wrapper for the Firebase API that provides a view into the provided
/// Firebase location as an ordered collection.
///
/// By default, Firebase yields values as unsorted document objects, where each of
/// the children are accessible via object keys. The `<firebase-collection>`
/// element allows Firebase API orderBy*, limitTo* and other query-oriented methods
/// to be specified declaratively. The element then produces and maintains an Array
/// of ordered child items of the document that is convenient for iterating over
/// in other elements such as `<template is="dom-repeat">`.
///
/// Example:
///
///       <template is="dom-bind">
///         <firebase-collection
///           order-by-child="height"
///           limit-to-first="3"
///           location="https://dinosaur-facts.firebaseio.com/dinosaurs"
///           data="{{dinosaurs}}"></firebase-collection>
///         <template is="dom-repeat" items="[[dinosaurs]]" as="dinosaur">
///           <h4>[[dinosaur.__firebaseKey__]]</h4>
///           <span>Height: </span><span>[[dinosaur.height]]</span><span>m</span>
///         </template>
///       </template>
///
/// As you may have noticed above, the original key of each item is available as
/// the `__firebaseKey__` property on the item.
///
/// The element makes special accomodations for documents whose children are
/// primitive values. A primitive value is wrapped in an object with the form:
///
/// ```javascript
/// {
///   value: /* original primitive value */
///   __firebaseKey__: /* key of primitive value in parent document */
/// }
/// ```
///
/// Accessor methods such as `add` and `remove` are provided to enable convenient
/// manipulation of the collection without direct knowledge of Firebase key values.
@CustomElementProxy('firebase-collection')
class FirebaseCollection extends HtmlElement with CustomElementProxyMixin, PolymerBase, FirebaseQueryBehavior {
  FirebaseCollection.created() : super.created();
  factory FirebaseCollection() => new Element.tag('firebase-collection');

  /// An ordered array of data items produced by the current Firebase Query
  /// instance.
  List get data => jsElement[r'data'];
  set data(List value) { jsElement[r'data'] = (value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Specify an end record for the set of records reflected in the
  /// collection.
  String get endAt => jsElement[r'endAt'];
  set endAt(String value) { jsElement[r'endAt'] = value; }

  /// Specify to create a query which includes children which match the
  /// specified value. The argument type depends on which orderBy*() function
  /// was used in this query. Specify a value that matches the orderBy*()
  /// type.
  String get equalTo => jsElement[r'equalTo'];
  set equalTo(String value) { jsElement[r'equalTo'] = value; }

  /// Specify a maximum number of records reflected on the client limited to
  /// the first certain number of children.
  num get limitToFirst => jsElement[r'limitToFirst'];
  set limitToFirst(num value) { jsElement[r'limitToFirst'] = value; }

  /// Specify a maximum number of records reflected on the client limited to
  /// the last certain number of children.
  num get limitToLast => jsElement[r'limitToLast'];
  set limitToLast(num value) { jsElement[r'limitToLast'] = value; }

  /// Specify a child key to order the set of records reflected on the
  /// client.
  String get orderByChild => jsElement[r'orderByChild'];
  set orderByChild(String value) { jsElement[r'orderByChild'] = value; }

  /// Specify to order by key the set of records reflected on the client.
  bool get orderByKey => jsElement[r'orderByKey'];
  set orderByKey(bool value) { jsElement[r'orderByKey'] = value; }

  /// Specify to order by priority the set of records reflected on the
  /// client.
  bool get orderByPriority => jsElement[r'orderByPriority'];
  set orderByPriority(bool value) { jsElement[r'orderByPriority'] = value; }

  /// Specify to order by value the set of records reflected on the client.
  bool get orderByValue => jsElement[r'orderByValue'];
  set orderByValue(bool value) { jsElement[r'orderByValue'] = value; }

  /// Specify to override the type used when deserializing the value of
  /// `start-at`, `end-at` and `equal-to` attributes. By default, these
  /// values are always deserialized as `String`, but sometimes it is
  /// preferrable to deserialize these values as e.g., `Number`.
  ///
  /// Accepted values for this attribute, and their corresponding
  /// deserialization types, are as follows:
  ///
  ///  - `string` => `String` (default)
  ///  - `number` => `Number`
  ///  - `boolean` => `Boolean`
  String get orderValueType => jsElement[r'orderValueType'];
  set orderValueType(String value) { jsElement[r'orderValueType'] = value; }

  /// A pointer to the current Firebase Query instance being used to
  /// populate `data`.
  get queryObject => jsElement[r'query'];
  set queryObject(value) { jsElement[r'query'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Specify a start record for the set of records reflected in the
  /// collection.
  String get startAt => jsElement[r'startAt'];
  set startAt(String value) { jsElement[r'startAt'] = value; }

  /// Add an item to the document referenced at `location`. A key associated
  /// with the item will be created by Firebase, and can be accessed via the
  /// Firebase Query instance returned by this method.
  /// [data]: A value to add to the document.
  add(data) =>
      jsElement.callMethod('add', [data]);

  /// Look up an item in the local `data` Array by key.
  /// [key]: The key associated with the item in the parent
  ///     document.
  void getByKey(String key) =>
      jsElement.callMethod('getByKey', [key]);

  /// Remove an item from the document referenced at `location`. The item
  /// is assumed to be an identical reference to an item already in the
  /// `data` Array.
  /// [data]: An identical reference to an item in `this.data`.
  void removeItem(data) =>
      jsElement.callMethod('remove', [data]);

  /// Remove an item from the document associated with `location` by key.
  /// [key]: The key associated with the item in the document
  ///     located at `location`.
  void removeByKey(String key) =>
      jsElement.callMethod('removeByKey', [key]);
}
