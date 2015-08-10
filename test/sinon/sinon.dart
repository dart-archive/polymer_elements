@HtmlImport('sinon.html')
library polymer_elements.test.src.sinon;

import 'dart:html';
import 'dart:js';
import 'package:web_components/web_components.dart';

JsObject _Sinon = context['sinon'];

Spy spy([JsObject object, String methodName]) =>
    new Spy(_Sinon.callMethod('spy', [object, methodName]));

match(Map options) => _Sinon.callMethod('match', [new JsObject.jsify(options)]);

get matchAny => _Sinon['match']['any'];

class Spy {
  JsObject jsObject;

  Spy(this.jsObject);

  bool get calledOnce => jsObject['calledOnce'];

  bool calledWith(List<JsObject> matchers) =>
      jsObject.callMethod('calledWith', matchers);

  reset() => jsObject.callMethod('reset');
}
