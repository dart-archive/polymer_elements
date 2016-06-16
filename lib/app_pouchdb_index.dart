// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_pouchdb_index`.
@HtmlImport('app_pouchdb_index_nodart.html')
library polymer_elements.lib.src.app_pouchdb.app_pouchdb_index;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_pouchdb_database_behavior.dart';

/// `app-pouchdb-index` enables declarative, idempotent configuration of database
/// indexes. The semantics map to those of the pouchdb-find plugin. For more
/// information on creating PouchDB indexes with pouchdb-find, please refer to the
/// documentation
/// [here](https://github.com/nolanlawson/pouchdb-find#dbcreateindexindex--callback).
///
/// Note: at least one index must be created in order for `app-pouchdb-query` to
/// work.
@CustomElementProxy('app-pouchdb-index')
class AppPouchdbIndex extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppPouchDBDatabaseBehavior {
  AppPouchdbIndex.created() : super.created();
  factory AppPouchdbIndex() => new Element.tag('app-pouchdb-index');

  /// Design document name (i.e. the part after '_design/'), auto-generated
  /// if you don't include it.
  String get ddoc => jsElement[r'ddoc'];
  set ddoc(String value) { jsElement[r'ddoc'] = value; }

  /// A list of fields to index.
  List get fields => jsElement[r'fields'];
  set fields(List value) { jsElement[r'fields'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The configuration object for the index, derived from `fields`, `name`
  /// and `ddoc` properties.
  get index => jsElement[r'index'];
  set index(value) { jsElement[r'index'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The name of the index, auto-generated if you don't include it.
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }
}
