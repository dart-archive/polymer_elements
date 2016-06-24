// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_scroll_effects_fade_background_test;

import 'package:polymer_interop/polymer_interop.dart';

import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_container.dart';
import 'package:polymer_elements/app_layout/app_scroll_effects/effects/fade_background.dart';
import 'package:polymer_elements/app_layout_helpers.dart';

/// Used tests: [IronIcon], [iron_icons]

main() async {
  await initPolymer();

  suite('Polymer.AppLayout.registerEffect', () {
    test('should register the effects', () {
      AppLayout.registerEffect('test', {'setUp': () {}, 'run': () {}, 'tearDown': () {}});

      $assert.isFunction(AppLayout.jsObject['_scrollEffects']['test']['setUp']);
      $assert.isFunction(AppLayout.jsObject['_scrollEffects']['test']['run']);
      $assert.isFunction(AppLayout.jsObject['_scrollEffects']['test']['tearDown']);
    });
  });
}
