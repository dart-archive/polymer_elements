@TestOn('browser')
library polymer_elements.test.iron_list_mutations_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'iron_list_test_helpers.dart';

main() async {
  await initWebComponents();

  group('mutations to items', () {
    IronList list;
    JsObject container;

    setUp(() {
      container = new JsObject.fromBrowserObject(fixture('trivialList'));
      list = container['list'];
    });
    
    test('update physical item', () {
      var setSize = 100;
      var phrase = 'It works!';
      list.items = buildDataSet(setSize);
      // TODO(jakemac): Update once we resolve
      // https://github.com/dart-lang/polymer_interop/issues/6
      list.jsElement.callMethod('set', ['items.0.index', phrase]);
      return new Future(() {}).then((_) {
        expect(getFirstItemFromList(list).text, phrase);
      });
    });
    
    test('update virtual item', () {
      var done = new Completer();
      var setSize = 100;
      var phrase = 'It works!';
      list.items = buildDataSet(setSize);
      
      scrollBackUp([_]) {
        simulateScroll({
          'list': list,
          'contribution': 100,
          'target': 0
        }, ([_]) {
          new Future(() {}).then((_) {
            expect(getFirstItemFromList(list).text, phrase);
            done.complete();
          });
        });
      }

      new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        // scroll down
        simulateScroll({
          'list': list,
          'contribution': 100,
          'target': setSize*rowHeight
        }, ([_]) {
          // TODO(jakemac): Update once we resolve
          // https://github.com/dart-lang/polymer_interop/issues/6
          list.jsElement.callMethod('set', ['items.0.index', phrase]);
          new Future(() {}).then(scrollBackUp);
        });
      });

      return done.future;
    });

    test('push', () {
      var done = new Completer();
      var setSize = 100;
      list.items = buildDataSet(setSize);
      setSize = list.items.length;
      // TODO(jakemac): Update once we resolve
      // https://github.com/dart-lang/polymer_interop/issues/6
      list.jsElement.callMethod('push', ['items', buildItem(setSize)]);
      expect(list.items.length, setSize + 1);
      new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        var viewportHeight = list.offsetHeight;
        var itemsPerViewport = (viewportHeight / rowHeight).floor();
        expect(getFirstItemFromList(list).text, '0');
        simulateScroll({
          'list': list,
          'contribution': rowHeight,
          'target': list.items.length*rowHeight
        }, ([_]) {
          expect(getFirstItemFromList(list).text,
              (list.items.length - itemsPerViewport).toString());
          done.complete();
        });
      });
      return done.future;
    });

    test('pop', () {
      var done = new Completer();
      var setSize = 100;
      list.items = buildDataSet(setSize);
      new Future(() {}).then((_) {
        var rowHeight = list.jsElement['_physicalItems'][0].offsetHeight;
        simulateScroll({
          'list': list,
          'contribution': rowHeight,
          'target': setSize*rowHeight
        }, ([_]) {
          var viewportHeight = list.offsetHeight;
          var itemsPerViewport = (viewportHeight / rowHeight).floor();
          // TODO(jakemac): Update once we resolve
          // https://github.com/dart-lang/polymer_interop/issues/6
          list.jsElement.callMethod('pop', ['items']);
          new Future(() {}).then((_) {
            expect(list.items.length, setSize-1);
            expect(getFirstItemFromList(list).text, '${setSize - 3 - 1}');
            done.complete();
          });
        });
      });
      return done.future;
    });
    
    test('splice', () {
      var setSize = 45;
      var phrase = 'It works!';
      list.items = buildDataSet(setSize);
      // TODO(jakemac): Update once we resolve
      // https://github.com/dart-lang/polymer_interop/issues/6
      list.jsElement.callMethod(
          'splice', ['items', 0, setSize, buildItem(phrase)]);
      return new Future(() {}).then((_) {
        expect(list.items.length, 1);
        expect(getFirstItemFromList(list).text, phrase);
      });
    });
  });
}
