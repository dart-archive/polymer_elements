library iron_elements.test.mock_interactions;

import 'dart:async';
import 'dart:html';
import 'dart:js';
// For the html import (which contains the js libraries)
import 'package:polymer_elements/iron_test_helpers.dart';

final JsObject _MockInteractionsJs = context['MockInteractions'];

class Point {
  final x;
  final y;

  Point.fromJsObject(JsObject object)
      : x = object['x'],
        y = object['y'];

  Map toMap() => {'x': x, 'y': y};
  JsObject toJsObject() => new JsObject.jsify(toMap());
}

Point middleOfNode(Node node) => new Point.fromJsObject(
    _MockInteractionsJs.callMethod('middleOfNode', [node]));

Point topLeftOfNode(Node node) => new Point.fromJsObject(
    _MockInteractionsJs.callMethod('topLeftOfNode', [node]));

void makeEvent(String type, Point xy, Node node) {
  _MockInteractionsJs.callMethod('makeEvent', [type, xy.toJsObject(), node]);
}

void down(Node node, Point xy) {
  _MockInteractionsJs.callMethod('down', [node, xy.toJsObject()]);
}

void move(Node node, Point fromXY, Point toXY, int steps) {
  _MockInteractionsJs.callMethod(
      'move', [fromXY.toJsObject(), toXY.toJsObject(), steps]);
}

void up(Node node, Point xy) {
  _MockInteractionsJs.callMethod('up', [node, xy.toJsObject()]);
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
  _MockInteractionsJs.callMethod(
      'downAndUp', [target, new JsFunction.withThis(callback)]);
}

void track(Node target, int dx, int dy, int steps) {
  _MockInteractionsJs.callMethod('track', [target, dx, dy, steps]);
}

Event keyboardEventFor(String type, int keyCode) =>
    _MockInteractionsJs.callMethod('keyboardEventFor', [type, keyCode]);

void keyEventOn(Node target, String type, int keyCode) {
  _MockInteractionsJs.callMethod('keyEventOn', [target, type, keyCode]);
}

void keyDownOn(Node target, int keyCode) {
  _MockInteractionsJs.callMethod('keyDownOn', [target, keyCode]);
}

void keyUpOn(Node target, int keyCode) {
  _MockInteractionsJs.callMethod('keyUpOn', [target, keyCode]);
}

void pressAndReleaseKeyOn(Node target, int keyCode) {
  _MockInteractionsJs.callMethod('pressAndReleaseKeyOn', [target, keyCode]);
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

void forceXIfStamp() {
  _TestHelpersJs.callMethod('forceXIfStamp');
}

void fireEvent() {
  _TestHelpersJs.callMethod('fireEvent');
}

fixture(String id) {
  return (document.importNode(
      (querySelector('#$id') as TemplateElement).content,
      true) as DocumentFragment).children[0];
}

// TODO(jakemac): Remove once
// https://github.com/dart-lang/custom-element-apigen/issues/31 is resolved.
Future jsPromiseToFuture(JsObject promise) {
  var completer = new Completer();
  var done = new JsFunction.withThis((_, __) {
    completer.complete();
  });
  var error = new JsFunction.withThis((error, _) {
    completer.completeError(error);
  });
  promise.callMethod('then', [done, error]);
  return completer.future;
}
