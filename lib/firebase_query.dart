// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_query`.
@HtmlImport('firebase_query_nodart.html')
library polymer_elements.lib.src.polymerfire.firebase_query;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'firebase_database_behavior.dart';
import 'app_storage_behavior.dart';
import 'firebase_common_behavior.dart';
import 'app_network_status_behavior.dart';

/// `firebase-query` combines the given properties into query options that generate
/// a query, a request for a filtered, ordered, immutable set of Firebase data. The
/// results of this Firebase query are then synchronized into the `data` parameter.
///
/// Example usage:
/// ```html
/// <firebase-query
///     id="query"
///     app-name="notes"
///     path="/notes/[[uid]]"
///     data="{{data}}">
/// </firebase-query>
///
/// <template is="dom-repeat" items="{{data}}" as="{{note}}">
///   <sticky-note note-data="{{note}}"></sticky-note>
/// </template>
///
/// <script>
/// Polymer({
///   properties: {
///     uid: String,
///     data: {
///       type: Object,
///       observer: 'dataChanged'
///     }
///   },
///
///   dataChanged: function (newData, oldData) {
///     // do something when the query returns values
///   }
/// });
/// </script>
/// ```
@CustomElementProxy('firebase-query')
class FirebaseQuery extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppStorageBehavior, AppNetworkStatusBehavior, FirebaseCommonBehaviorImpl, FirebaseCommonBehavior, FirebaseDatabaseBehaviorImpl, FirebaseDatabaseBehavior {
  FirebaseQuery.created() : super.created();
  factory FirebaseQuery() => new Element.tag('firebase-query');

  /// The value to end at in the query.
  ///
  /// Changing this value generates a new `query` with the specified
  /// ending point. The generated `query` includes children which match
  /// the specified ending point.
  String get endAt => jsElement[r'endAt'];
  set endAt(String value) { jsElement[r'endAt'] = value; }

  /// Specifies a child-key value that must be matched for each candidate result.
  ///
  /// Changing this value generates a new `query` which includes children
  /// which match the specified value.
  get equalTo => jsElement[r'equalTo'];
  set equalTo(value) { jsElement[r'equalTo'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  get isNew => jsElement[r'isNew'];

  /// The maximum number of nodes to include in the query.
  ///
  /// Changing this value generates a new `query` limited to the first
  /// number of children.
  num get limitToFirst => jsElement[r'limitToFirst'];
  set limitToFirst(num value) { jsElement[r'limitToFirst'] = value; }

  /// The maximum number of nodes to include in the query.
  ///
  /// Changing this value generates a new `query` limited to the last
  /// number of children.
  num get limitToLast => jsElement[r'limitToLast'];
  set limitToLast(num value) { jsElement[r'limitToLast'] = value; }

  /// The child key of each query result to order the query by.
  ///
  /// Changing this value generates a new `query` ordered by the
  /// specified child key.
  String get orderByChild => jsElement[r'orderByChild'];
  set orderByChild(String value) { jsElement[r'orderByChild'] = value; }

  /// [`firebase.database.Query`](https://firebase.google.com/docs/reference/js/firebase.database.Query#property)
  /// object computed by the following parameters.
  get queryObject => jsElement[r'query'];
  set queryObject(value) { jsElement[r'query'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The value to start at in the query.
  ///
  /// Changing this value generates a new `query` with the specified
  /// starting point. The generated `query` includes children which match
  /// the specified starting point.
  String get startAt => jsElement[r'startAt'];
  set startAt(String value) { jsElement[r'startAt'] = value; }

  get zeroValue => jsElement[r'zeroValue'];

  child(key) =>
      jsElement.callMethod('child', [key]);

  memoryPathToStoragePath(path) =>
      jsElement.callMethod('memoryPathToStoragePath', [path]);

  setStoredValue(storagePath, value) =>
      jsElement.callMethod('setStoredValue', [storagePath, value]);

  storagePathToMemoryPath(storagePath) =>
      jsElement.callMethod('storagePathToMemoryPath', [storagePath]);
}
