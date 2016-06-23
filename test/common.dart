// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library iron_elements.test.mock_interactions;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_test_helpers.dart' as test_helpers;
import 'package:test/test.dart' as T;
import 'package:polymer/polymer.dart';

/// Used imports: [test_helpers]
final JsObject _MockInteractionsJs = context['MockInteractions'];

class Point {
  num x;
  num y;

  Point(this.x, this.y);

  Point.fromJsObject(JsObject object)
      : x = object['x'],
        y = object['y'];

  Map toMap() => {'x': x, 'y': y};
  JsObject toJsObject() => new JsObject.jsify(toMap());

  bool isApproximatelyEqualTo(other) {
    return this.x.round() == other.x.round() && this.y.round() == other.y.round();
  }
}

Point middleOfNode(node) => new Point.fromJsObject(_MockInteractionsJs.callMethod('middleOfNode', [node]));

Point topLeftOfNode(Node node) => new Point.fromJsObject(_MockInteractionsJs.callMethod('topLeftOfNode', [node]));

void makeEvent(String type, Point xy, Node node) {
  _MockInteractionsJs.callMethod('makeEvent', [type, xy.toJsObject(), node]);
}

void down(Node node, [Point xy]) {
  _MockInteractionsJs.callMethod('down', [node, xy == null ? null : xy.toJsObject()]);
}

void move(Node node, Point fromXY, Point toXY, int steps) {
  _MockInteractionsJs.callMethod('move', [fromXY.toJsObject(), toXY.toJsObject(), steps]);
}

void up(Node node, [Point xy]) {
  _MockInteractionsJs.callMethod('up', [node, xy == null ? null : xy.toJsObject()]);
}

void tap(Node node) {
  _MockInteractionsJs.callMethod('tap', [node]);
}

void focus(Node target) {
  _MockInteractionsJs.callMethod('focus', [target]);
}

void blur(Node target) {
  _MockInteractionsJs.callMethod('blur', [target]);
}

void downAndUp(Node target, [Function callback]) {
  var cb = Zone.current.bindCallback(callback);
  _MockInteractionsJs.callMethod('downAndUp', [target, cb]);
}

void track(Node target, int dx, int dy, [int steps]) {
  _MockInteractionsJs.callMethod('track', [target, dx, dy, steps]);
}

Event keyboardEventFor(String type, int keyCode) => _MockInteractionsJs.callMethod('keyboardEventFor', [type, keyCode]);

void keyEventOn(Node target, String type, int keyCode) {
  _MockInteractionsJs.callMethod('keyEventOn', [target, type, keyCode]);
}

void keyDownOn(Node target, int keyCode) {
  _MockInteractionsJs.callMethod('keyDownOn', [target, keyCode]);
}

void keyUpOn(Node target, int keyCode) {
  _MockInteractionsJs.callMethod('keyUpOn', [target, keyCode]);
}

void pressAndReleaseKeyOn(Node target, int keyCode, [List modifiers = const [], String name]) {
  _MockInteractionsJs.callMethod('pressAndReleaseKeyOn', [target, keyCode, modifiers, name]);
}

void pressEnter(Node target) {
  _MockInteractionsJs.callMethod('pressEnter', [target]);
}

void pressSpace(Node target) {
  _MockInteractionsJs.callMethod('pressSpace', [target]);
}

final JsObject _TestHelpersJs = context['TestHelpers'];

void flushAsynchronousOperations() {
  _TestHelpersJs.callMethod('flushAsynchronousOperations');
}

void forceXIfStamp(Node target) {
  _TestHelpersJs.callMethod('forceXIfStamp', [target]);
}

void fireEvent(String type, Map props, Node node) {
  _TestHelpersJs.callMethod('fireEvent', [type, props == null ? props : new JsObject.jsify(props), node]);
}

fixture(String id) {
  var container = document.querySelector('#testContainer');
  if (container == null) {
    container = new Element.html('<div id="testContainer"></div>');
  } else {
    container.remove();
  }

  container.children.clear();

  var elements = new List.from((document.importNode((querySelector('#$id') as TemplateElement).content, true) as DocumentFragment).children);
  for (var element in elements) {
    container.append(element);
  }

  // Do this last so that all elements get appended at once.
  document.body.append(container);
  return elements.length == 1 ? elements[0] : elements;
}

// TODO(jakemac): Remove once
// https://github.com/dart-lang/custom-element-apigen/issues/31 is resolved.
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

Future wait(int milliseconds) {
  return new Future.delayed(new Duration(milliseconds: milliseconds), () {});
}

Future requestAnimationFrame() {
  var completer = new Completer();
  window.requestAnimationFrame((done) {
    completer.complete();
  });
  return completer.future;
}

List keysOf(JsObject object) => context['Object'].callMethod('keys', [object]);

// Helper to let porting JS tests faster

Function when(x(void p_done([e]))) => () {
      Completer _done = new Completer();
      x(([e]) {
        if (e != null) {
          _done.completeError(e);
        } else {
          _done.complete(true);
        }
      });
      return _done.future;
    };

suite(title, test(), {skip}) => T.group(title, test, skip: skip);

setup(fn) => T.setUp(fn);

teardown(fn) => T.tearDown(fn);

class Assert {
  const Assert();

  equal(a, b, [reason]) => T.expect(a, b, reason: reason);

  strictEqual(a, b, [reason]) => T.expect(a, b, reason: reason);

  deepEqual(a, b, [reason]) => T.expect(a, b, reason: reason); // TODO:  a better way to implement this ?

  isFalse(a, [reason]) => T.expect(a, T.isFalse, reason: reason);

  isUndefined(x, [reason]) => T.expect(x, T.isNull, reason: reason);

  void isTrue(bool x, [reason]) => T.expect(x, T.isTrue, reason: reason);

  void ok(x, [reason]) => T.expect(x, T.isNotNull, reason: reason);

  void isAbove(num x, num what, [reason]) => T.expect(x, T.greaterThan(what), reason: reason);
  void isBelow(num x, num what, [reason]) => T.expect(x, T.lessThan(what), reason: reason);

  void isOk(thing, [reason]) => ok(thing, reason);

  void notEqual(x, what, [reason]) => T.expect(x, T.isNot(what), reason: reason);

  void isNotOk(x, [reason]) => T.expect(x, T.isNull, reason: reason);

  void lengthOf(List list, int len, [reason]) => T.expect(list.length, len, reason: reason);

  void call(x, [reason]) => $assert.isTrue(x, reason);

  void isNotNull(thing, [reason]) => T.expect(thing, T.isNotNull, reason: reason);

  void isFunction(f) => T.expect(f, const T.isInstanceOf<Function>());
}

void testAsync(name, body(done()), {skip}) {
  T.test(name, when((done) {
    body(done);
  }), skip: skip);
}

const Assert $assert = const Assert();

void showTestRunnerFrame() {
  // Make testrunner iFrame visible otherwise transitions not get fired ...

  WindowBase w = window.parent;

  JsObject doc = new JsObject.fromBrowserObject(w)['document'];

  JsObject res = doc.callMethod("querySelector", ['iframe']);
  res['style']['visibility'] = 'visible';
}

void hideTestRunnerFrame() {
  WindowBase w = window.parent;

  JsObject doc = new JsObject.fromBrowserObject(w)['document'];

  JsObject res = doc.callMethod("querySelector", ['iframe']);
  res['style']['visibility'] = '';
}

$$assert(x, [reason]) => $assert.isTrue(x, reason);

jsDeepEquals(JsObject a, JsObject b) {
  List<String> x = context['Object']['keys'].apply([a]);
  return x.every((x) => a[x] == b[x]);
}

class _expect {
  var something;
  bool _deep = false;

  _expect(this.something);

  _expect get to => this;

  _expect get be => this;

  get $true => T.expect(something, T.isTrue);

  get $false => T.expect(something, T.isFalse);

  get ok => T.expect(something, T.isNotNull);

  _expect get deep {
    _deep = true;
    return this;
  }

  equal(expected) {
    if (expected is JsObject && _deep) {
      T.expect(jsDeepEquals(something, expected), T.isTrue);
    } else {
      T.expect(something, expected);
    }
  }

  _not get not => new _not(this);

  greaterThan(num i) => T.expect(something, T.greaterThan(i));

  void eql(x) => T.expect(something, x);
}

class _not {
  _expect _exp;
  _not(this._exp);

  _not get be => this;
  _not get to => this;

  get $null => T.expect(_exp.something, T.isNotNull);

  get ok => T.expect(_exp.something, T.isNull);

  equal(expected) => T.expect(_exp.something, T.isNot(expected));

  void eql(resources, [reason]) => T.expect(_exp.something, T.isNot(resources),reason:reason);

}

_expect $expect(something) => new _expect(something);

num parseFloat(String dimension) {
  return num.parse(dimension.replaceAll(new RegExp("[^0-9.]+"), ""));
}

int parseInt(x, [_]) => parseFloat(x).floor();

Future flush(cb) async {
  PolymerDom.flush();
  await wait(1);
  await cb();
}

Future $async(cb, [delay = 1]) async {
  await wait(delay);
  return await cb();
}

bool sameCSS(Element el, String css) {
  DivElement dummy = new DivElement();
  dummy.style.cssText = css;
  document.body.children.add(dummy);
  CssStyleDeclaration expected = dummy.getComputedStyle();
  CssStyleDeclaration actual = el.getComputedStyle();

  return css.split(";").every((String style) {
    if (style.trim().isEmpty) {
      return true;
    }
    List<String> p = style.split(":");
    String name = p[0].trim();
    String val1 = actual.getPropertyValue(name);
    String val2 = expected.getPropertyValue(name);
    if (val1 != null && val1.isNotEmpty) T.expect(val1, val2);
    return true;
  });
}
