import 'dart:async';
import 'dart:js';

Future jsPromiseToFuture(JsObject promise) {
  var completer = new Completer();
  var done = new JsFunction.withThis((_, __) {
    completer.complete(__);
  });
  var error = new JsFunction.withThis((error, _) {
    completer.completeError(error);
  });
  promise.callMethod('then', [done, error]);
  return completer.future;
}