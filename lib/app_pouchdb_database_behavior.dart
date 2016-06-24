// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_pouchdb_database_behavior`.
@HtmlImport('app_pouchdb_database_behavior_nodart.html')
library polymer_elements.lib.src.app_pouchdb.app_pouchdb_database_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `Polymer.AppPouchDBDatabaseBehavior` is an abstract implementation that
/// is intended to be shared by any element that refers to and operates on a
/// PouchDB database instance. It includes implementation for creating and
/// configuring a PouchDB database instance, and some advanced macro
/// operations that might be performed on the database, including "upsert"
/// and conflict-aware "put" and "post" operations.
@BehaviorProxy(const ['Polymer', 'AppPouchDBDatabaseBehavior'])
abstract class AppPouchDBDatabaseBehavior implements CustomElementProxyMixin {

  /// The PouchDB adapter to use. For more information on PouchDB adapters,
  /// please refer to the PouchDB documentation
  /// [here](https://pouchdb.com/api.html#create_database).
  String get adapter => jsElement[r'adapter'];
  set adapter(String value) { jsElement[r'adapter'] = value; }

  /// A reference to the PouchDB database instance that has been created.
  get db => jsElement[r'db'];
  set db(value) { jsElement[r'db'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The name of the database. This can be either a local database (such
  /// as "cats"), or a remote one (e.g., "https://example.com:5678/cats").
  String get dbName => jsElement[r'dbName'];
  set dbName(String value) { jsElement[r'dbName'] = value; }

  /// The number of document revisions to keep track of. The default value
  /// (0) indicates no limit.
  num get revsLimit => jsElement[r'revsLimit'];
  set revsLimit(num value) { jsElement[r'revsLimit'] = value; }

  /// If true, all attempts to "put" or "post" values into the database
  /// will be automatically structured as an "upsert", where documents are
  /// updated if already available, or created if not.
  bool get upsert => jsElement[r'upsert'];
  set upsert(bool value) { jsElement[r'upsert'] = value; }

  /// If desired, assign a function that implements a conflict resolution
  /// strategy. This conflict resolution strategy will take precedence when
  /// a conflict occurs, and will prevent conflict notification events from
  /// being fired.
  ///
  /// Consider using an `app-pouchdb-conflict-resolver` element instead for
  /// a more declarative experience!
  resolveConflict() =>
      jsElement.callMethod('resolveConflict', []);
}
