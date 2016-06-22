// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_toolbar_test;

import 'package:polymer_interop/polymer_interop.dart';

import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_container.dart';
import 'package:polymer_elements/app_pouchdb_document.dart';
import 'package:polymer_elements/app_pouchdb_conflict_resolution.dart';
import 'package:polymer_elements/pouchdb.dart';
import 'dart:async';

testAppStorageDocumentCompatibility(Map extendedContext) {
  Map context = {
    'tagName': 'unknown-element',
    'awaitUpdate': new Future.value(true),
    'fetchStoredValue': when((done) => done()),
    'unsetValue': (storage) {
      storage.set('data', null);
      return storage.transactionsComplete;
    }
  };

  awaitStoredValue(AppPouchdbDocument storage, path) {
    return jsPromiseToFuture(storage.transactionsComplete).then((_) {
      return context['fetchStoredValue'](storage.memoryPathToStoragePath(path), storage);
    });
  }

  context.addAll(extendedContext);
  //Object.assign(context, extendedContext);

  suite('app storage compatibility: <' + context['tagName'] + '>', () {
    suite('basic storage scenarios', () {
      AppPouchdbDocument storage;

      setup(() {
        storage = fixture('BasicStorage');
        storage.set('data', {});
        return jsPromiseToFuture(storage.transactionsComplete);
      });

      tearDown(() {
        return context['unsetValue'](storage);
      });

      suite('setting properties', () {
        test('sets primitive values', () {
          storage.set('data.numberProperty', 1);
          return awaitStoredValue(storage, 'data.numberProperty').then((value) {
            storage;
            $expect(value).to.be.equal(1);
          });
        });

        test('sets object values', () {
          storage.set('data.objectProperty', {'foo': 1});
          return awaitStoredValue(storage, 'data.objectProperty').then((value) {
            $expect(value).to.be.equal({'foo': 1});
          });
        });

        test('sets array values', () {
          storage.set('data.arrayProperty', [1, 2, 3]);
          return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
            $expect(value).to.be.eql([1, 2, 3]);
          });
        });
      });

      suite('updating properties', () {
        test('updates primitive values', () {
          storage.set('data.numberProperty', 1);

          return awaitStoredValue(storage, 'data.numberProperty').then((value) {
            storage.set('data.numberProperty', 2);
            return awaitStoredValue(storage, 'data.numberProperty');
          }).then((value) {
            $expect(value).to.be.eql(2);
          });
        });

        test('updates object values', () {
          storage.set('data.objectProperty', {'foo': 1});

          return awaitStoredValue(storage, 'data.objectProperty').then((value) {
            storage.set('data.objectProperty.bar', 2);
            return awaitStoredValue(storage, 'data.objectProperty');
          }).then((value) {
            $expect(value).to.be.eql({'foo': 1, 'bar': 2});
          });
        });

        test('updates array values', () {
          storage.set('data.arrayProperty', [1, 2, 3]);

          return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
            storage.set('data.arrayProperty', [1, 2, 3, 4]);
            return awaitStoredValue(storage, 'data.arrayProperty');
          }).then((value) {
            $expect(value).to.be.eql([1, 2, 3, 4]);
          });
        });

        suite('manipulating arrays', () {
          setup(() {
            storage.set('data.arrayProperty', [1, 2, 3]);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 2, 3]);
            });
          });

          test('updates after array push', () {
            storage.add('data.arrayProperty', 4);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 2, 3, 4]);
            });
          });

          test('updates after array pop', () {
            storage.removeLast('data.arrayProperty');

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 2]);
            });
          });

          test('updates after additive array splice', () {
            storage.replaceRange('data.arrayProperty', 1, 1, [4]);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 4, 2, 3]);
            });
          });

          test('updates after subtractive array splice', () {
            storage.replaceRange('data.arrayProperty', 1, 2, []);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 3]);
            });
          });

          test('updates after complex array splice', () {
            storage.replaceRange('data.arrayProperty', 1, 2, [4]);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 4, 3]);
            });
          });
        });
      });

      suite('removing properties', () {
        test('removes primitive values', () {
          storage.set('data.numberProperty', 1);

          return awaitStoredValue(storage, 'data.numberProperty').then((_) {
            storage.set('data.numberProperty', null);
            return awaitStoredValue(storage, 'data.numberProperty');
          }).then((value) {
            $expect(value).to.not.be.ok;
          });
        });

        test('removes object values', () {
          storage.set('data.objectProperty', {'foo': 1, 'bar': 2});

          return awaitStoredValue(storage, 'data.objectProperty').then((_) {
            storage.set('data.objectProperty.bar', null);
            return awaitStoredValue(storage, 'data.objectProperty');
          }).then((Map value) {
            $expect(value['foo']).to.be.ok;
            $expect(value['bar']).to.not.be.ok;
          });
        });

        test('removes array values', () {
          storage.set('data.arrayProperty', [1, 2, 3]);

          return awaitStoredValue(storage, 'data.arrayProperty').then((_) {
            storage.removeLast('data.arrayProperty');
            return awaitStoredValue(storage, 'data.arrayProperty');
          }).then((value) {
            storage;
            $expect(value).to.be.eql([1, 2]);
          });
        });
      });
    });

    suite('syncing storage scenarios', () {
      AppPouchdbDocument storageOne;
      AppPouchdbDocument storageTwo;

      setup(() {
        var syncingStorage = fixture('SyncingStorage');

        storageOne = syncingStorage[0];
        storageTwo = syncingStorage[1];

        return Future.wait([storageOne.transactionsComplete, storageTwo.transactionsComplete].map(jsPromiseToFuture));
      });

      tearDown(() {
        context['unsetValue'](storageOne);
        return context['awaitUpdate'](storageTwo).then((_) {
          $expect(storageTwo.data).to.be.eql(storageOne.data);
        });
      });

      test('syncs primitives across elements', () {
        storageOne.set('data.numberProperty', 1);

        return Future.wait([awaitStoredValue(storageOne, 'data.numberProperty'), context['awaitUpdate'](storageTwo)]).then((results) {
          var value = results[0];
          $expect(value).to.be.equal(1);
          $expect(storageOne.get('data.numberProperty')).to.be.equal(value);
          $expect(storageTwo.get('data.numberProperty')).to.be.equal(value);
        });
      },skip:'change event not fired in dart, need investigation');

      test('syncs object values across elements', () {
        var objectValue = {'foo': 1};
        storageOne.set('data.objectProperty', objectValue);

        return Future.wait([awaitStoredValue(storageOne, 'data.objectProperty.foo'), context['awaitUpdate'](storageTwo)]).then((results) {
          var value = results[0];
          $expect(value).to.be.equal(1);
          $expect(storageOne.get('data.objectProperty')).to.be.eql(objectValue);
          $expect(storageTwo.get('data.objectProperty')).to.be.eql(objectValue);
        });
      },skip:'change event not fired in dart, need investigation');

      test('syncs array values across elements', () {
        var arrayValue = [1, 2, 3];
        storageOne.set('data.arrayProperty', arrayValue);

        return Future.wait([awaitStoredValue(storageOne, 'data.arrayProperty.0'), context['awaitUpdate'](storageTwo)]).then((results) {
          var value = results[0];
          $expect(value).to.be.equal(1);
          $expect(storageOne.get('data.arrayProperty')).to.be.eql(arrayValue);
          $expect(storageTwo.get('data.arrayProperty')).to.be.eql(arrayValue);
        });
      },skip:'change event not fired in dart, need investigation');
    });
  });
}

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  group("basic", () {
    tearDownAll(() {
      return new PouchDB('test-db').destroy();
    });

    testAppStorageDocumentCompatibility({
      'tagName': 'app-pouchdb-document',
      'awaitUpdate': (AppPouchdbDocument element) {
        Completer resolve = new Completer();
        JsFunction onChange;
        onChange = new JsFunction.withThis (([a,b,c,d,e,f,g,h,i])  {
          element.changes.callMethod('removeListener',[onChange]);

          resolve.complete();
        });
        element.changes.callMethod('on',['change',onChange]);

        return resolve.future;
      },
      'fetchStoredValue': (storagePath, AppPouchdbDocument element) {
        return new PouchDB('test-db').get(element.docId).then((doc) {
          return element.get(storagePath,{'data':doc});
        });
      },
      'unsetValue': (storage) {
        storage.set('data._deleted', true);
        return jsPromiseToFuture(storage.transactionsComplete);
      }
    });
  });
}
