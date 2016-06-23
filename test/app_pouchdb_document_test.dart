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
import 'app_storage_helpers.dart';



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
