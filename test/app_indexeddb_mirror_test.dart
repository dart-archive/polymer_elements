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
import 'package:polymer_elements/app_storage/app_indexeddb_mirror/app_indexeddb_mirror.dart';

import 'dart:async';


import 'app_storage/app_storage_test_helpers.dart' as appStorageTestHelpers;

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  var dbVersion = 2;

  Future getPersistedValue(key) {
    return jsPromiseToFuture(appStorageTestHelpers.getIdbObjectStoreValue('app-mirror', dbVersion, 'mirrored_data', key));
  }

  Future setPersistedValue(key, value) {
    return jsPromiseToFuture(appStorageTestHelpers.setIdbObjectStoreValue('app-mirror', dbVersion, 'mirrored_data', key, value));
  }

  Future expectPersistedValue(key, value) {
    return getPersistedValue(key).then((persistedValue) {
      $expect(persistedValue).to.be.deep.equal(value);
    });
  }

  suite('<app-indexeddb-mirror>', () {
    teardown(() {
      appStorageTestHelpers.restoreNavigatorOnLine();
      return jsPromiseToFuture(appStorageTestHelpers.deleteIdbDatabase('app-mirror'));
    });

    suite('basic mirroring', () {
      AppIndexeddbMirror mirror;

      setup(() {
        mirror = fixture('BasicMirror');
        return jsPromiseToFuture(mirror.transactionsComplete);
      });

      teardown(() {
        return mirror.client.callMethod('closeDb');
      });

      suite('when online', () {
        test('mirrors data into IndexedDB', () {
          if (!mirror.client['supportsMirroring']) {
            return new Future.value(true);
          }

          mirror.set('data',{'foo': 'bar'});

          return jsPromiseToFuture(mirror.transactionsComplete).then((_) {
            return expectPersistedValue(mirror.key, mirror.data);
          });
        });

        test('passes changes to persistedData through to data', () {
          if (!mirror.client['supportsMirroring']) {
            return new Future.value(true);
          }

          mirror.set('data',{'foo': 'bar'});

          $expect(mirror.persistedData).to.be.deep.equal(mirror.data);

          mirror.set('persistedData.foo', 'baz');

          $expect(mirror.data).to.be.deep.equal(mirror.persistedData);

          return jsPromiseToFuture(mirror.transactionsComplete).then((_) {
            return expectPersistedValue(mirror.key, mirror.data);
          });
        });
      });

      suite('when offline', () {
        test('boots up with persisted value', () {
          if (!mirror.client['supportsMirroring']) {
            return new Future.value(true);
          }

          var persistedValue = {'foo': 'bar'};
          AppIndexeddbMirror secondMirror;

          mirror.set('data',persistedValue);

          return jsPromiseToFuture(mirror.transactionsComplete).then((_) {
            appStorageTestHelpers.goOffline();
            secondMirror = fixture('SecondMirror');
            return jsPromiseToFuture(secondMirror.transactionsComplete);
          }).then((_) {
            $expect(secondMirror.persistedData).to.be.deep.equal(new JsObject.jsify(persistedValue));
          });
        });

        test('sets persistedData to value in IDB', () {
          if (!mirror.client['supportsMirroring']) {
            return new Future.value(true);
          }

          mirror.set('data',{'foo': 'bar'});

          var persistedValue = {'foo': 'baz'};

          return jsPromiseToFuture(mirror.transactionsComplete).then((_) {
            return setPersistedValue(mirror.key, new JsObject.jsify(persistedValue));
          }).then((_) {
            appStorageTestHelpers.goOffline();
            return jsPromiseToFuture(mirror.transactionsComplete);
          }).then((_) {
            $expect(mirror.persistedData).to.be.deep.equal(new JsObject.jsify(persistedValue));
          });
        });
      });
    });
  });
}
