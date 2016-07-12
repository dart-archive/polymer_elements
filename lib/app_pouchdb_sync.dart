// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_pouchdb_sync`.
@HtmlImport('app_pouchdb_sync_nodart.html')
library polymer_elements.lib.src.app_pouchdb.app_pouchdb_sync;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `app-pouchdb-sync` arranges for one-directional or bi-directional
/// synchronization between two PouchDB databases. For one-directional
/// synchronization, it forwards to `PouchDB.replicate`, and for bi-directional
/// synchronization, it forwards to `PouchDB.sync`.
///
/// Here is an example of bi-directional synchronization between a local database
/// and a remote one:
///
/// ```html
/// <app-pouchdb-sync
///     src="cats"
///     target="https://example.com:5678/cats"
///     bidirectional>
/// </app-pouchdb-sync>
/// ```
///
/// For more information on PouchDB synchronization topics, please refer to the
/// documentation [here](https://pouchdb.com/guides/replication.html).
@CustomElementProxy('app-pouchdb-sync')
class AppPouchdbSync extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  AppPouchdbSync.created() : super.created();
  factory AppPouchdbSync() => new Element.tag('app-pouchdb-sync');

  /// While `false`, synchronization will only happen from the `src` to the
  /// `target`. One-directional synchronization follows the semantics of
  /// `PouchDB.replicate`. Set to `true` to make the sync bidirectional,
  /// which uses `PouchDB.sync` instead.
  bool get bidirectional => jsElement[r'bidirectional'];
  set bidirectional(bool value) { jsElement[r'bidirectional'] = value; }

  /// Set to true to log change events that are emitted by the `sync`
  /// instance.
  bool get log => jsElement[r'log'];
  set log(bool value) { jsElement[r'log'] = value; }

  /// The source to sync from. If this sync is `bidirectional`, then the
  /// `src` and `target` values are interchangeable.
  String get src => jsElement[r'src'];
  set src(String value) { jsElement[r'src'] = value; }

  /// An event emitter that notifies of events in the synchronization
  /// process.
  get sync => jsElement[r'sync'];
  set sync(value) { jsElement[r'sync'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The `target` to sync to. If this sync is `bidirectional`, then the
  /// `src` and `target` values are interchangeable.
  String get target => jsElement[r'target'];
  set target(String value) { jsElement[r'target'] = value; }
}
