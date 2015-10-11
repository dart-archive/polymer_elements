// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.firebase_collection_test;

import 'dart:async';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/firebase_collection.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<firebase-collection>', () {
    FirebaseCollection firebase;

    group('collection manipulation', () {
      DomBind domBind;
      var dom;

      setUp(() {
        dom = fixture('BoundCollection');
        domBind = dom.querySelector('[is=dom-bind]');
        firebase = dom.querySelector('firebase-collection');
      });

      test('added values reflect 1-to-1 in the DOM', () {
        return firebase.on['firebase-value'].first.then((_) {
          var done = firebase.on['firebase-child-added'].first.then((_) {
            expect(dom.querySelectorAll('div').length, firebase.data.length);
          });
          domBind.insert('data', 0, {'value': 'blah'});
          domBind.render();
          return done;
        });
      });
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/62');

    group('basic usage', () {
      setUp(() {
        firebase = fixture('TrivialCollection');
      });

      tearDown(() {
        firebase.disconnect();
      });

      test('exposes data as an array', () {
        return firebase.on['firebase-child-added'].first.then((_) {
          expect(firebase.data is List, isTrue);
        });
      });

      test('receives data from Firebase location', () {
        return firebase.on['data-changed'].first.then((_) {
          expect(firebase.data[0]['value'], true);
        });
      });
    });

    group('ordered primitives', () {
      setUp(() {
        firebase = fixture('PrimitiveCollection');
      });

      tearDown(() {
        firebase.disconnect();
      });

      test('converts primitives into objects with a value key', () {
        return firebase.on['firebase-child-added'].first.then((_) {
          expect(firebase.data[0], isNotNull);
        });
      });

      test('orders primitives by value', () {
        return firebase.on['firebase-value'].first.then((_) {
          var lastValue = -1.0 / 0;
          expect(firebase.data.length, greaterThan(0));
          firebase.data.forEach((item) {
            expect(item['value'], greaterThanOrEqualTo(lastValue));
            lastValue = item['value'];
          });
        });
      });

      group('adding a value locally', () {
        setUp(() {
          return firebase.on['firebase-value'].first;
        });

        test('can be done with `add`', () {
          var length = firebase.data.length;
          var newValue = firebase.data[firebase.data.length - 1]['value'] + 1;
          var key;

          var done = firebase.on['firebase-child-added'].first.then((_) {
            expect(firebase.data.length, length + 1);
            expect(firebase.data[firebase.data.length - 1]['value'], newValue);
          }).then((_) async {
            await wait(1);
            firebase.removeByKey(key);
          });

          key = firebase.add(newValue).callMethod('key');
          return done;
        });
      });
    });

    group('a child changes', () {
      setUp(() {
        firebase = fixture('ChangingChildren');
        return firebase.on['firebase-value'].first;
      });

      test('updates the child key in place with the new value', () {
        var childrenKeys = [];

        var done = firebase.on['firebase-value'].first.then((_) async {
          // Wait for childrenKeys to be populated
          await new Future(() {});
          var middleValue = firebase.getByKey(childrenKeys[1]);
          var changes;

          expect(middleValue['foo'], 1);
          expect(middleValue['bar'], 1);

          changes = firebase.on['firebase-child-changed'].first;

          firebase.set('data.${firebase.data.indexOf(middleValue)}.bar', 2);

          return changes;
        }).then((_) {
          var middleValue = firebase.getByKey(childrenKeys[1]);

          expect(middleValue['foo'], 1);
          expect(middleValue['bar'], 2);
        }).then((_) {
          childrenKeys.forEach((key) {
            firebase.removeByKey(key);
          });
        });

        var index = -1;
        childrenKeys = [0, 1, 2].map((value) {
          index++;
          return firebase
              .add(new JsObject.jsify({'foo': value, 'bar': index}))
              .callMethod('key');
        }).toList();

        return done;
      });
    });

    group('syncing collections', () {
      FirebaseCollection localFirebase;
      FirebaseCollection remoteFirebase;

      setUp(() {
        var children = fixture('SyncingCollections');
        localFirebase = children[0];
        remoteFirebase = children[1];
        return Future.wait([
          localFirebase.on['firebase-value'].first,
          remoteFirebase.on['firebase-value'].first
        ]);
      });

      test('syncs a new item at the correct index', () {
        var data = {'foo': 100};
        var key;

        var done = remoteFirebase.on['firebase-value'].first.then((_) async {
          await wait(1);
          var value = remoteFirebase.getByKey(key);
          var lowValue = remoteFirebase.getByKey('lowValue');
          var highValue = remoteFirebase.getByKey('highValue');

          var index = remoteFirebase.data.indexOf(value);
          var lowIndex = remoteFirebase.data.indexOf(lowValue);
          var highIndex = remoteFirebase.data.indexOf(highValue);

          expect(value, isNotNull);
          expect(index, lessThan(highIndex));
          expect(index, greaterThan(lowIndex));
        }).then((_) {
          localFirebase.removeByKey(key);
        });

        key = localFirebase.add(new JsObject.jsify(data)).callMethod('key');

        return done;
      });
    });
  });
}
