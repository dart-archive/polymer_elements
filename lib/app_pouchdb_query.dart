// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_pouchdb_query`.
@HtmlImport('app_pouchdb_query_nodart.html')
library polymer_elements.lib.src.app_pouchdb.app_pouchdb_query;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'app_pouchdb_database_behavior.dart';

/// `app-pouchdb-query` allows for declarative, read-only querying into a PouchDB
/// database. The semantics for querying match those of the
/// [pouchdb-find plugin](https://github.com/nolanlawson/pouchdb-find).
///
/// In order to create an `app-pouchdb-query` against any field other than `_id`, at
/// least one index needs to have been created in your PouchDB database. You can use
/// `app-pouchdb-index` to do this declaratively. For example:
///
/// ```html
/// <app-pouchdb-index
///     db-name="cats"
///     fields='["name"]'>
/// </app-pouchdb-index>
/// <app-pouchdb-query
///     db-name="cats"
///     selector="name $exists true"
///     fields='["_id","name"]'
///     sort='["name"]'
///     data="{{cats}}">
/// </app-pouchdb-query>
/// ```
///
/// In the above example, an index is created on the "name" field of the "cats"
/// database. This allows the query to select by the "name" field, and sort by the
/// "name" field.
///
/// By default, PouchDB creates an index on the "_id" field, so if you don't
/// particularly care about sorting or selecting on other fields, you don't need to
/// create any extra indexes.
///
/// ## Describing selectors
///
/// This element requires a specialized selector syntax that maps to the semantics
/// of the pouchdb-find plugin. For example, if you wish to create the following
/// selector:
///
/// ```javascript
/// {
///   series: 'Mario',
///   debut: { $gt: 1990 }
/// }
/// ```
///
/// You should format the `selector` property this way:
///
/// ```javascript
/// "series $eq 'Mario', debut $gt 1990"
/// ```
///
/// This makes selectors more convenient to write declaratively, while still
/// maintaining the ability to express selectors with full fidelity. For more
/// documentation on pouchdb-find selectors, please check out the docs
/// [here](https://github.com/nolanlawson/pouchdb-find#dbfindrequest--callback).
@CustomElementProxy('app-pouchdb-query')
class AppPouchdbQuery extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppPouchDBDatabaseBehavior {
  AppPouchdbQuery.created() : super.created();
  factory AppPouchdbQuery() => new Element.tag('app-pouchdb-query');

  /// The results of the query, if any.
  List get data => jsElement[r'data'];
  set data(List value) { jsElement[r'data'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The fields to include in the returned documents.
  List get fields => jsElement[r'fields'];
  set fields(List value) { jsElement[r'fields'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The maximum number of documents that can be returned. The default (0)
  /// specifies no limit.
  num get limit => jsElement[r'limit'];
  set limit(num value) { jsElement[r'limit'] = value; }

  /// An object representing the parsed form of the selector, mapping to
  /// a valid selector value as described in
  /// [the pouchdb-find docs](https://github.com/nolanlawson/pouchdb-find).
  get parsedSelector => jsElement[r'parsedSelector'];
  set parsedSelector(value) { jsElement[r'parsedSelector'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// A configuration object suitable to be passed to the `find` method of
  /// the PouchDB database. For more information, refer to the docs
  /// [here](https://github.com/nolanlawson/pouchdb-find/blob/master/README.md#dbfindrequest--callback)
  get queryConfig => jsElement[r'query'];
  set queryConfig(value) { jsElement[r'query'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The selector to use when querying for documents. Fields referenced
  /// in the selector must have indexes created for them.
  String get selector => jsElement[r'selector'];
  set selector(String value) { jsElement[r'selector'] = value; }

  /// The number of documents to skip before returning results that match
  /// the query. In other words, the offset from the beginning of the
  /// of the result set to start at.
  num get skip => jsElement[r'skip'];
  set skip(num value) { jsElement[r'skip'] = value; }

  /// A list of field names to sort by. Fields in this list must have
  /// indexes created for them.
  List get sort => jsElement[r'sort'];
  set sort(List value) { jsElement[r'sort'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// PouchDB only notifies of additive changes to the result set of a query.
  /// In order to keep the query results up to date with other types of
  /// changes, this method can be called to perform the query again without
  /// changing any of this element's other properties.
  refresh() =>
      jsElement.callMethod('refresh', []);
}
