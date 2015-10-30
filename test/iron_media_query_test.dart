// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_media_query_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/iron_media_query.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronMediaQuery mq;

    group('set query with different values', () {
      setUp(() {
        mq = fixture('basic');
      });

      test('small min-width value', () {
        mq.mediaQuery = '(min-width: 1px)';
        expect(mq.queryMatches, true);
      });

      test('large min-width value', () {
        mq.mediaQuery = '(min-width: 10000px)';
        expect(mq.queryMatches, false);
      });

      test('small max-width value', () {
        mq.mediaQuery = '(max-width: 1px)';
        expect(mq.queryMatches, false);
      });

      test('large max-width value', () {
        mq.mediaQuery = '(max-width: 10000px)';
        expect(mq.queryMatches, true);
      });
    
      test('automatically wrap with parens', () {
        mq.mediaQuery = 'min-width: 1px';
        expect(mq.queryMatches, true);
      });
  
      group('query does not activate on empty string or null', () {
  
        test('empty string', () {
          mq.mediaQuery = '';
          expect(mq.jsElement['_mq'], isNull);
        });
  
        test('null', () {
          mq.mediaQuery = null;
          expect(mq.jsElement['_mq'], isNull);
        });
  
      });
  
      test('media query destroys on detach', () {
        mq.mediaQuery = '(max-width: 800px)';
        mq.remove();
        PolymerDom.flush();
        expect(mq.jsElement['_mq'], isNull);
      });
  
      test('media query re-enables on attach', () {
        mq.mediaQuery = '(max-width: 800px)';
        var parent = mq.parentNode;
        mq.remove();
        PolymerDom.flush();
        parent.append(mq);
        PolymerDom.flush();
        expect(mq.jsElement['_mq'], isNotNull);
      });
    });
  });
}
