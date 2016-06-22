@HtmlImport('pouchdb.html')
library polymer_elements.pouchdb;

import 'package:web_components/web_components.dart';
import 'dart:js';
import 'dart:async';

// Thanks to @jakemac ---
Future _jsPromiseToFuture(JsObject promise) {
  var completer = new Completer();
  var done = new JsFunction.withThis((t, ret) {
    completer.complete(ret);
  });
  var error = new JsFunction.withThis((error, _) {
    completer.completeError(error);
  });
  promise.callMethod('then', [done, error]);
  return completer.future;
}

class PouchDB {
  JsObject pouchDBJS;

  PouchDB.fromJs(this.pouchDBJS);

  factory PouchDB(String name) => new PouchDB.fromJs(new JsObject(context["PouchDB"], [name]));

  destroy() => pouchDBJS.callMethod('destroy');

  Future get(docId) => _jsPromiseToFuture(pouchDBJS.callMethod('get',[docId]));
}
