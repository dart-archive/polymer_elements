// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_meta_test;

import 'dart:js';
import 'package:polymer_elements/iron_meta.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<iron-meta>', () {
    group('basic behavior', () {
      IronMeta meta;

      setUp(() {
        meta = fixture('TrivialMeta');
      });

      tearDown(() {
        meta.key = null;
      });

      test('uses itself as the default value', () {
        expect(meta.value, meta);
      });

      test('can be assigned alternative values', () {
        meta.value = 'foobar';

        expect(meta.list[0], 'foobar');
      });

      test('can access same-type meta values by key', () {
        expect(meta.byKey(meta.key), meta.value);
      });

      test('yields a list of same-type meta data', () {
        expect(meta.list, isNotNull);
        expect(meta.list.length, 1);
        expect(meta.list[0], meta);
      });
    });

    group('many same-typed metas', () {
      List<IronMeta> metas;

      setUp(() {
        metas = fixture('ManyMetas');
      });

      tearDown(() {
        metas.forEach((meta) {
          meta.key = null;
        });
      });

      test('all cache all meta values', () {
        int i = 0;
        metas.forEach((meta) {
          expect(meta.list.length, metas.length);
          expect(meta.list[i].value, meta.value);
          i++;
        });
      });

      test('can be unregistered individually', () {
        metas[0].key = null;

        expect(metas[0].list.length, 2);
        expect(metas[0].list, [metas[1], metas[2]]);
      });

      test('can access each others value by key', () {
        expect(metas[0].byKey('default2'), metas[1].value);
      });
    });

    group('different-typed metas', () {
      var metas;

      setUp(() {
        metas = fixture('DifferentTypedMetas');
      });

      tearDown(() {
        metas.forEach((meta) {
          meta.key = null;
        });
      });

      test('cache their values separately', () {
        var fooMeta = metas[0];
        var barMeta = metas[1];

        expect(fooMeta.value, isNot(barMeta.value));
        expect(fooMeta.byKey('foobarKey'), fooMeta.value);
        expect(barMeta.byKey('foobarKey'), barMeta.value);
      });

      test('cannot access values of other types', () {
        var defaultMeta = metas[2];

        expect(defaultMeta.byKey('foobarKey'), isNull);
      });

      test('only list values of their type', () {
        metas.forEach((meta) {
          expect(meta.list.length, 1);
          expect(meta.list[0], meta.value);
        });
      });
    });

    group('metas with clashing keys', () {
      var metaPair;

      setUp(() {
        metaPair = fixture('ClashingMetas');
      });

      tearDown(() {
        metaPair.forEach((meta) {
          meta.key = null;
        });
      });

      test('let the last value win registration against the key', () {
        var registeredValue = metaPair[0].byKey(metaPair[0].key);
        var firstValue = metaPair[0].value;
        var secondValue = metaPair[1].value;

        expect(registeredValue, isNot(firstValue));
        expect(registeredValue, secondValue);
      });
    });
    
    group('singleton', () {

      test('only one ironmeta created', () {
        var ironMeta = context['Polymer']['IronMeta'];
        var first = ironMeta.callMethod('getIronMeta');
        var second = ironMeta.callMethod('getIronMeta');
        expect(first, second);
      });
    });
  });
}
