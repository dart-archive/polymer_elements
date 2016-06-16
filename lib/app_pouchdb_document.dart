// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_pouchdb_document`.
@HtmlImport('app_pouchdb_document_nodart.html')
library polymer_elements.lib.src.app_pouchdb.app_pouchdb_document;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_storage_behavior.dart';
import 'app_pouchdb_database_behavior.dart';

/// `app-pouchdb-document` is an implementation of `Polymer.CarbonStorageBehavior`
/// for reading and writing to individual PouchDB documents.
///
/// In order to refer to a PouchDB document, provide the name of the database
/// (both local and remote databases are supported) and the ID of the document.
///
/// For example:
///
/// ```html
/// <app-pouchdb-document
///     db-name="cats"
///     doc-id="parsnip">
/// </app-pouchdb-document>
/// ```
///
/// In the above example, a PouchDB instance will be created to connect to the
/// local database named "cats". Then it will check to see if a document with the
/// ID "parsnip" exists. If it does, the `data` property of the document will be
/// set to the value of the document. If it does not, then any subsequent
/// assignments to the `data` property will cause a document with ID "parsnip" to
/// be created.
///
/// Here is an example of a simple form that can be used to read and write to a
/// PouchDB document:
///
/// ```html
/// <app-pouchdb-document
///     db-name="cats"
///     doc-id="parsnip"
///     data="{{cat}}">
/// </app-pouchdb-document>
/// <input
///     is="iron-input"
///     bind-value="{{cat.name}}">
/// </input>
/// ```
@CustomElementProxy('app-pouchdb-document')
class AppPouchdbDocument extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppStorageBehavior, AppPouchDBDatabaseBehavior {
  AppPouchdbDocument.created() : super.created();
  factory AppPouchdbDocument() => new Element.tag('app-pouchdb-document');

  /// A changes event emitter. Notifies of changes to the PouchDB document
  /// referred to by `docId`, if a `docId` has been provided.
  get changes => jsElement[r'changes'];
  set changes(value) { jsElement[r'changes'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The value of the _id (Pouch/Couch unique identifier) of the PouchDB
  /// document that this element's data should refer to.
  String get docId => jsElement[r'docId'];
  set docId(String value) { jsElement[r'docId'] = value; }

  get isNew => jsElement[r'isNew'];

  /// The current _rev (revision) of the PouchDB document that this
  /// element's data refers to, if the document is not new.
  String get rev => jsElement[r'rev'];
  set rev(String value) { jsElement[r'rev'] = value; }

  get zeroValue => jsElement[r'zeroValue'];

  destroy() =>
      jsElement.callMethod('destroy', []);

  getStoredValue(storagePath) =>
      jsElement.callMethod('getStoredValue', [storagePath]);

  reset() =>
      jsElement.callMethod('reset', []);

  save() =>
      jsElement.callMethod('save', []);

  setStoredValue(storagePath, value) =>
      jsElement.callMethod('setStoredValue', [storagePath, value]);
}
