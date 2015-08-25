// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_doc_viewer_test;

import 'package:polymer_elements/iron_doc_viewer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  var ELEMENT = {
    "is": "awesome-sauce",
    "properties": [
      {"name": "isAwesome", "type": "boolean", "desc": "Is it awesome?"},
    ]
  };
  
  group('<iron-doc-viewer>', ()
  {
    IronDocViewer page;

    tearDown(() {
      page = null;
      // Make sure that we don't reuse another test's element.
    });

    group('with a bound descriptor', () {
      setUp(() {
        page = fixture('bound');
        page.descriptor = ELEMENT;
      });

      test('loads the descriptor', () {
        expect(page.descriptor['is'], 'awesome-sauce');
        expect(page.descriptor['properties'].length, 1);
      });
    });

    group('with a JSON descriptor', () {
      setUp(() {
        page = fixture('json');
      });

      test('loads the descriptor', () {
        expect(page.descriptor['is'], 'awesome-sauce');
        expect(page.descriptor['properties'].length, 1);
      });
    });

    group('edge cases', () {
      test('throws when a bound and JSON descriptor are provided', () {
        expect(() {
          fixture('json-and-bound')
            ..descriptor = ELEMENT;
        }, throws);
      });
    });
  });
}

