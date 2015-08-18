// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_document`.
@HtmlImport('firebase_document_nodart.html')
library polymer_elements.lib.src.firebase_element.firebase_document;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'firebase_query_behavior.dart';

/// An element wrapper for the Firebase API.
///
/// A `<firebase-document>` is a reference to a remote document somewhere on
/// Firebase. The element fetchs a document at a provided `location`, and exposes
/// it as an Object that is suitable for deep two-way databinding.
///
/// Example:
///
///     <firebase-document
///       location="https://dinosaur-facts.firebaseio.com/dinosaurs"
///       data="{{dinosaurs}}">
///
/// In the above example, if the `dinosaurs` object is data-bound elsewhere via
/// Polymer's data-binding system, changes to the document will be automatically
/// reflected in the remote document and any other clients referencing that
/// document.
@CustomElementProxy('firebase-document')
class FirebaseDocument extends HtmlElement with CustomElementProxyMixin, PolymerBase, FirebaseQueryBehavior {
  FirebaseDocument.created() : super.created();
  factory FirebaseDocument() => new Element.tag('firebase-document');

  /// The `data` object mapped to `location`.
  get data => jsElement[r'data'];
  set data(value) { jsElement[r'data'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}

  /// Firebase Query object corresponding to `location`.
  get queryObject => jsElement[r'query'];
  set queryObject(value) { jsElement[r'query'] = (value is Map || value is Iterable) ? new JsObject.jsify(value) : value;}
}
