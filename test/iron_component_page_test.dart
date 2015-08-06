@TestOn('browser')
library polymer_elements.test.iron_component_page_test;

import 'dart:async';
import 'dart:convert';
import 'dart:js';
import 'package:polymer_elements/iron_component_page.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('active-state', () {
    IronComponentPage testElement;
    setUp(() {
      testElement = fixture('basic');
    });

    test('basic', () {
      expect(testElement is IronComponentPage, isTrue);
    });
  });
}

