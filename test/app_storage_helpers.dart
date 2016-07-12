import 'dart:async';

import 'common.dart';
import 'package:test/test.dart';
import 'package:polymer_elements/app_storage_behavior.dart';
import 'package:polymer/polymer.dart';

testAppStorageDocumentCompatibility(Map extendedContext) {
  Map context = {
    'tagName': 'unknown-element',
    'awaitUpdate': new Future.value(true),
    'fetchStoredValue': (storagePath, AppStorageBehavior element) => new Future.value(null),
    'unsetValue': (storage) {
      storage.set('data', null);
      return jsPromiseToFuture(storage.transactionsComplete);
    }
  };

  awaitStoredValue(AppStorageBehavior storage, path) {
    return jsPromiseToFuture(storage.transactionsComplete).then((_) {
      return context['fetchStoredValue'](storage.memoryPathToStoragePath(path), storage);
    });
  }

  context.addAll(extendedContext);
  //Object.assign(context, extendedContext);

  suite('app storage compatibility: <' + context['tagName'] + '>', () {
    suite('basic storage scenarios', () {
      AppStorageBehavior storage;

      setup(() {
        storage = fixture('BasicStorage');
        (storage as PolymerBase).set('data', {});
        return jsPromiseToFuture(storage.transactionsComplete);
      });

      tearDown(() {
        return context['unsetValue'](storage);
      });

      suite('setting properties', () {
        test('sets primitive values', () {
          (storage as PolymerBase).set('data.numberProperty', 1);
          return awaitStoredValue(storage, 'data.numberProperty').then((value) {
            storage;
            $expect(value).to.be.equal(1);
          });
        });

        test('sets object values', () {
          (storage as PolymerBase).set('data.objectProperty', {'foo': 1});
          return awaitStoredValue(storage, 'data.objectProperty').then((value) {
            $expect(value).to.be.equal({'foo': 1});
          });
        });

        test('sets array values', () {
          (storage as PolymerBase).set('data.arrayProperty', [1, 2, 3]);
          return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
            $expect(value).to.be.eql([1, 2, 3]);
          });
        });
      });

      suite('updating properties', () {
        test('updates primitive values', () {
          (storage as PolymerBase).set('data.numberProperty', 1);

          return awaitStoredValue(storage, 'data.numberProperty').then((value) {
            (storage as PolymerBase).set('data.numberProperty', 2);
            return awaitStoredValue(storage, 'data.numberProperty');
          }).then((value) {
            $expect(value).to.be.eql(2);
          });
        });

        test('updates object values', () {
          (storage as PolymerBase).set('data.objectProperty', {'foo': 1});

          return awaitStoredValue(storage, 'data.objectProperty').then((value) {
            (storage as PolymerBase).set('data.objectProperty.bar', 2);
            return awaitStoredValue(storage, 'data.objectProperty');
          }).then((value) {
            $expect(value).to.be.eql({'foo': 1, 'bar': 2});
          });
        });

        test('updates array values', () {
          (storage as PolymerBase).set('data.arrayProperty', [1, 2, 3]);

          return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
            (storage as PolymerBase).set('data.arrayProperty', [1, 2, 3, 4]);
            return awaitStoredValue(storage, 'data.arrayProperty');
          }).then((value) {
            $expect(value).to.be.eql([1, 2, 3, 4]);
          });
        });

        suite('manipulating arrays', () {
          setup(() {
            (storage as PolymerBase).set('data.arrayProperty', [1, 2, 3]);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 2, 3]);
            });
          });

          test('updates after array push', () {
            (storage as PolymerBase).add('data.arrayProperty', 4);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 2, 3, 4]);
            });
          });

          test('updates after array pop', () {
            (storage as PolymerBase).removeLast('data.arrayProperty');

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 2]);
            });
          });

          test('updates after additive array splice', () {
            (storage as PolymerBase).replaceRange('data.arrayProperty', 1, 1, [4]);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 4, 2, 3]);
            });
          });

          test('updates after subtractive array splice', () {
            (storage as PolymerBase).replaceRange('data.arrayProperty', 1, 2, []);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 3]);
            });
          });

          test('updates after complex array splice', () {
            (storage as PolymerBase).replaceRange('data.arrayProperty', 1, 2, [4]);

            return awaitStoredValue(storage, 'data.arrayProperty').then((value) {
              $expect(value).to.be.eql([1, 4, 3]);
            });
          });
        });
      });

      suite('removing properties', () {
        test('removes primitive values', () {
          (storage as PolymerBase).set('data.numberProperty', 1);

          return awaitStoredValue(storage, 'data.numberProperty').then((_) {
            (storage as PolymerBase).set('data.numberProperty', null);
            return awaitStoredValue(storage, 'data.numberProperty');
          }).then((value) {
            $expect(value).to.not.be.ok;
          });
        });

        test('removes object values', () {
          (storage as PolymerBase).set('data.objectProperty', {'foo': 1, 'bar': 2});

          return awaitStoredValue(storage, 'data.objectProperty').then((_) {
            (storage as PolymerBase).set('data.objectProperty.bar', null);
            return awaitStoredValue(storage, 'data.objectProperty');
          }).then((Map value) {
            $expect(value['foo']).to.be.ok;
            $expect(value['bar']).to.not.be.ok;
          });
        });

        test('removes array values', () {
          (storage as PolymerBase).set('data.arrayProperty', [1, 2, 3]);

          return awaitStoredValue(storage, 'data.arrayProperty').then((_) {
            (storage as PolymerBase).removeLast('data.arrayProperty');
            return awaitStoredValue(storage, 'data.arrayProperty');
          }).then((value) {
            storage;
            $expect(value).to.be.eql([1, 2]);
          });
        });
      });
    });

    suite('syncing storage scenarios', () {
      AppStorageBehavior storageOne;
      AppStorageBehavior storageTwo;

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
        (storageOne as PolymerBase).set('data.numberProperty', 1);

        return Future.wait([awaitStoredValue(storageOne, 'data.numberProperty'), context['awaitUpdate'](storageTwo)]).then((results) {
          var value = results[0];
          $expect(value).to.be.equal(1);
          $expect((storageOne as PolymerBase).get('data.numberProperty')).to.be.equal(value);
          $expect((storageTwo as PolymerBase).get('data.numberProperty')).to.be.equal(value);
        });
      },skip:'change event not fired in dart, need investigation');

      test('syncs object values across elements', () {
        var objectValue = {'foo': 1};
        (storageOne as PolymerBase).set('data.objectProperty', objectValue);

        return Future.wait([awaitStoredValue(storageOne, 'data.objectProperty.foo'), context['awaitUpdate'](storageTwo)]).then((results) {
          var value = results[0];
          $expect(value).to.be.equal(1);
          $expect((storageOne as PolymerBase).get('data.objectProperty')).to.be.eql(objectValue);
          $expect((storageTwo as PolymerBase).get('data.objectProperty')).to.be.eql(objectValue);
        });
      },skip:'change event not fired in dart, need investigation');

      test('syncs array values across elements', () {
        var arrayValue = [1, 2, 3];
        (storageOne as PolymerBase).set('data.arrayProperty', arrayValue);

        return Future.wait([awaitStoredValue(storageOne, 'data.arrayProperty.0'), context['awaitUpdate'](storageTwo)]).then((results) {
          var value = results[0];
          $expect(value).to.be.equal(1);
          $expect((storageOne as PolymerBase).get('data.arrayProperty')).to.be.eql(arrayValue);
          $expect((storageTwo as PolymerBase).get('data.arrayProperty')).to.be.eql(arrayValue);
        });
      },skip:'change event not fired in dart, need investigation');
    });
  });
}