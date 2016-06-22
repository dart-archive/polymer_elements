// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('sinon.html')
library polymer_elements.test.src.sinon;

import 'dart:js';
import 'package:web_components/web_components.dart';
import 'dart:html';
import 'dart:async';

JsObject _Sinon = context['sinon'];

Spy spy([JsObject object, String methodName]) =>
    new Spy(_Sinon.callMethod('spy', [object, methodName]));


match(Map options) => _Sinon.callMethod('match', [new JsObject.jsify(options)]);

get matchAny => _Sinon['match']['any'];

class Stub {
  int calls=0;

  void call([_]) {
    calls++;
  }

  bool get calledOnce => calls==1;

}

class DartSpyEventHandler {
  List<Event> calls = [];

  bool get called => calls.isNotEmpty;

  get callCount => calls.length;
  void call([Event e]) {
    calls.add(e);
  }

  DartSpyEventHandler();

  factory DartSpyEventHandler.on(Element target,String eventName,[int max])  =>
    new DartSpyEventHandler()
      ..attach(target,eventName,max);

  StreamSubscription _sub;

  void attach(Element target,String eventName,[int max=null]) {
    if (max!=null) {
      _sub = target.on[eventName].take(max).listen(this);
    } else {
      _sub = target.on[eventName].listen(this);
    }
  }

  void detach() {
    _sub.cancel();
    _sub=null;
  }
}


class Spy {
  JsObject jsObject;

  get called => jsObject["called"];

  Spy(this.jsObject);

  bool get calledOnce => jsObject['calledOnce'];

  int get callCount => jsObject['callCount'];

  bool calledWith(List<JsObject> matchers) =>
      jsObject.callMethod('calledWith', matchers);

  reset() => jsObject.callMethod('reset');

  SpyCall get lastCall => new SpyCall(jsObject['lastCall']);

  SpyCall getCall(int arg) => new SpyCall(jsObject.callMethod("getCall",[arg]));

  EventListener get eventListener => (Event e) => (jsObject as JsFunction).apply([e]);

  bool calledAfter(Spy otherSpy) => jsObject.callMethod("calledAfter", [otherSpy.jsObject]);

}

class SpyCall {
  JsObject jsObject;

  SpyCall(this.jsObject);

  JsArray get args => jsObject["args"];
}
