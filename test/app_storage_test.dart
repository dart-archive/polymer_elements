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
import 'package:polymer_elements/app_storage/app_localstorage/app_localstorage_document.dart';



/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  group("basic", () {


    testAppStorageDocumentCompatibility({'tagName':'app-localstorage-document'});
  },skip:'is this really working in js ? seams totally scrambled');
}
