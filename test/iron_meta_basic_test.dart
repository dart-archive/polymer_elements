@TestOn('browser')
library polymer_elements.test.iron_media_query_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_meta.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    IronMeta meta;

    test('byKey', () {
      var meta = new IronMeta();
      expect(meta.byKey('info'), 'foo/bar');
    });

    test('list', () {
      var meta = new IronMeta();
      expect(meta.list.length, 1);
    });
  });
}
