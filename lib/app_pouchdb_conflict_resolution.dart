// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_pouchdb_conflict_resolution`.
@HtmlImport('app_pouchdb_conflict_resolution_nodart.html')
library polymer_elements.lib.src.app_pouchdb.app_pouchdb_conflict_resolution;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `app-pouchdb-conflict-resolution` enables declarative configuration of conflict
/// resolution strategies ordered by logical relationships in the DOM. Currently
/// two basic strategies are supported: `firstWriteWins` and `lastWriteWins`.
///
/// To use `app-pouchdb-conflict-resolution`, simply include the element somewhere
/// in a document subtree at or above the ShadowRoot of an `app-pouchdb-document`
/// or `app-pouchdb-query`:
///
/// ```html
/// <app-pouchdb-conflict-resolution
///     strategy="lastWriteWins">
/// </app-pouchdb-conflict-resolution>
/// <app-pouchdb-document
///     db-name="cats"
///     doc-id="parsnip">
/// </app-pouchdb-document>
/// ```
///
/// When a conflict occurs, the `app-pouchdb-document` will request fire an event
/// to notify of the conflict and request a resolution strategy. The
/// `app-pouchdb-conflict-resolution` element listens at its nearest ShadowRoot
/// boundary for conflict notifications, and responds to them as needed with a
/// configured strategy.
@CustomElementProxy('app-pouchdb-conflict-resolution')
class AppPouchdbConflictResolution extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  AppPouchdbConflictResolution.created() : super.created();
  factory AppPouchdbConflictResolution() => new Element.tag('app-pouchdb-conflict-resolution');

  /// By default, this element stops propagation of any conflict events
  /// that it is able to handle. If set to `true`, the element will allow
  /// such events to continue propagating, opening the possibility that
  /// another conflict resolution strategy higher up the document tree will
  /// superseed this one.
  bool get allowAncestralResolution => jsElement[r'allowAncestralResolution'];
  set allowAncestralResolution(bool value) { jsElement[r'allowAncestralResolution'] = value; }

  /// The name of the strategy to use to reslve the conflict. Supported
  /// strategies are `firstWriteWins` (the default) and `lastWriteWins`.
  String get strategy => jsElement[r'strategy'];
  set strategy(String value) { jsElement[r'strategy'] = value; }

  firstWriteWins(db, method, doc, error) =>
      jsElement.callMethod('firstWriteWins', [db, method, doc, error]);

  lastWriteWins(db, method, doc, error) =>
      jsElement.callMethod('lastWriteWins', [db, method, doc, error]);

  resolveConflict(event) =>
      jsElement.callMethod('resolveConflict', [event]);
}
