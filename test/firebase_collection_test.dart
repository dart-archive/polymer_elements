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
import 'firebase_test_helpers.dart';

main() async {
  await initWebComponents();

  group('firebase-collection', () {
    FirebaseCollection firebase;

    tearDown(() {
      if (firebase != null) removeFirebase(firebase);
    });

    group('basic usage', () {
      var numberOfItems;

      setUp(() {
        numberOfItems = 3;
        firebase =
            fixtureFirebase('TrivialCollection', arrayOfObjects(numberOfItems));
        return wait(1);
      });

      test('exposes data as an array', () {
        expect(firebase.data is List, isTrue);
        expect(firebase.data.length, numberOfItems);
      });

      test('receives data from Firebase location', () {
        expect(firebase.data[0]['value'] is num, isTrue);
      });
    });

    group('ordered primitives', () {
      var numberOfItems;

      setUp(() {
        numberOfItems = 5;
        firebase = fixtureFirebase(
            'TrivialCollection', arrayOfPrimitives(numberOfItems));
        firebase.orderByValue = true;
      });

      test('converts primitives into objects with a value key', () {
        expect(firebase.data[0] is JsObject, isTrue);
      });

      test('orders primitives by value', () {
        var lastValue = -1;

        expect(firebase.data.length, numberOfItems);

        firebase.data.forEach((datum) {
          expect(datum['value'], isNot(lessThan(lastValue)));
          lastValue = datum['value'];
        });
      });
    });

    group('removing a value locally', () {
      var numberOfItems;
      setUp(() {
        numberOfItems = 3;
        firebase =
            fixtureFirebase('TrivialCollection', arrayOfObjects(numberOfItems));
      });

      test('works for data-bound changes', () {
        firebase.removeAt('data', 0);
        expect(firebase.data.length, numberOfItems - 1);
      });

      test('can be done with `remove`', () {
        var objectToBeRemoved = firebase.data[0];
        firebase.firebaseRemove(objectToBeRemoved);

        expect(firebase.data.length, numberOfItems - 1);
        expect(firebase.data.indexOf(objectToBeRemoved), -1);
      });
    });

    group('adding a value locally', () {
      setUp(() {
        firebase = fixtureFirebase('TrivialCollection');
      });

      test('works for data-bound changes', () {
        var done = new Completer();
        var intendedValue = randomInt();
        // Can't call `add` since it is overridden
        firebase.add('data', intendedValue);
        var index = firebase.data.length - 1;

        // NOTE(cdata): See polymer/polymer#2491.
        firebase.async(() {
          expect(firebase.data[index]['value'], isNotNull);
          expect(firebase.data[index]['value'], intendedValue);
          done.complete();
        }, waitTime: 1);

        return done.future;
      });

      test('can be done with `add`', () {
        var done = new Completer();
        var object = randomObject();
        var length = firebase.data.length;
        var foundObject;

        firebase.firebaseAdd(new JsObject.jsify(object));

        // NOTE(cdata): See polymer/polymer#2491.
        firebase.async(() {
          expect(firebase.data.length, length + 1);

          firebase.data.forEach((datum) {
            if (datum['value'] == object['value']) {
              foundObject = datum;
            }
          });

          expect(foundObject, isNotNull);
          expect(foundObject['value'], object['value']);
          done.complete();
        }, waitTime: 1);

        return done.future;
      });
    });

    group('a changing child', () {
      var numberOfItems;
      var remoteFirebase;

      setUp(() {
        numberOfItems = 3;
        firebase =
            fixtureFirebase('TrivialCollection', arrayOfObjects(numberOfItems));
        remoteFirebase = new JsObject(context['Firebase'], [firebase.location]);
      });

      test('updates the child key in place with the new value', () {
        var datum = firebase.data[0];
        var newValue = 99999;
        var key = context['Polymer']['Collection']
            .callMethod('get', [firebase.data]).callMethod('getKey', [datum]);

        firebase.set('data.$key.value', newValue);

        expect(firebase.data[0]['value'], newValue);
      });
    });

    group('syncing collections', () {
      var numberOfItems;
      var remoteFirebase;

      setUp(() {
        numberOfItems = 3;

        firebase = fixtureFirebase('TrivialCollection', arrayOfObjects(3));
        firebase.orderValueType = 'number';
        firebase.orderByValue = true;

        remoteFirebase = new JsObject(context['Firebase'], [firebase.location]);
      });

      test('sync a new item at the correct index', () {
        var firstValue = firebase.data[0];
        var secondValue = firebase.data[1];
        var datum = firebase.data[0];
        var key = context['Polymer']['Collection']
            .callMethod('get', [firebase.data]).callMethod('getKey', [datum]);
        var remoteValue;

        remoteFirebase.callMethod('on', [
          'value',
          (snapshot) {
            remoteValue = snapshot.callMethod('val');
          }
        ]);

        expect(remoteValue[0]['value'], firebase.data[0]['value']);
      });
    });

    group('data-bound collection manipulation', () {
      var numberOfItems;
      var elements;
      DomBind domBind;

      setUp(() {
        elements = fixture('BoundCollection');
        domBind = elements.querySelector('[is=dom-bind]');
        firebase = elements.querySelector('firebase-collection');
        firebase.location = fixtureLocation(arrayOfObjects(3));
        numberOfItems = 3;
      });

      test('splices reflect in Firebase data', () {
        var done = new Completer();
        domBind.removeAt('data', 0);
        domBind.add('data', randomObject());
        domBind.removeAt('data', 0);
        domBind.addAll('data', arrayOfObjects(2));

        // NOTE(cdata): See polymer/polymer#2491.
        firebase.async(() {
          expect(firebase.data.length, domBind['data'].length);

          for (int i = 0; i < firebase.data.length; i++) {
            var datum = firebase.data[i];
            expect(domBind['data'][i]['value'], datum['value']);
          }

          done.complete();
        }, waitTime: 1);

        done.future;
      });

      test('splices reflect in the DOM', () {
        var divs;
        var done = new Completer();

        firebase.addAll('data', arrayOfObjects(3));

        firebase.async(() {
          divs = elements.querySelectorAll('div');
          expect(divs.length, firebase.data.length);

          domBind.removeAt('data', 2);
          domBind.add('data', randomObject());

          firebase.async(() {
            divs = elements.querySelectorAll('div');
            expect(divs.length, firebase.data.length);

            for (int i = 0; i < firebase.data.length; i++) {
              var datum = firebase.data[i];
              var divValue = int.parse(divs[i].text);
              expect(datum.value, divValue);
            }

            done.complete();
          }, waitTime: 1);
        }, waitTime: 1);

        return done.future;
      }, skip: 'https://github.com/dart-lang/polymer_elements/issues/62');
    });
  });
}
