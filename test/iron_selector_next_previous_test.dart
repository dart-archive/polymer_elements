@TestOn('browser')
library polymer_elements.test.iron_selector_next_previous_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_selector.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  IronSelector s;

  assertAndSelect(Function method, expectedIndex) {
    expect(s.selected, expectedIndex);
    method();
  }

  group('next/previous', () {
    setUp(() {
      s = fixture('test1');
    });

    test('selectNext', () {
      expect(s.selected, '0');
      assertAndSelect(s.selectNext, '0');
      assertAndSelect(s.selectNext, 1);
      assertAndSelect(s.selectNext, 2);
      expect(s.selected, 0);
    });

    test('selectPrevious', () {
      expect(s.selected, '0');
      assertAndSelect(s.selectPrevious, '0');
      assertAndSelect(s.selectPrevious, 2);
      assertAndSelect(s.selectPrevious, 1);
      expect(s.selected, 0);
    });

    test('selectNext/Previous', () {
      expect(s.selected, '0');
      assertAndSelect(s.selectNext, '0');
      assertAndSelect(s.selectNext, 1);
      assertAndSelect(s.selectPrevious, 2);
      assertAndSelect(s.selectNext, 1);
      assertAndSelect(s.selectPrevious, 2);
      expect(s.selected, 1);
    });
  });

  group('next/previous attrForSelected', () {
    setUp(() {
      s = fixture('test2');
    });

    test('selectNext', () {
      expect(s.selected, 'foo');
      assertAndSelect(s.selectNext, 'foo');
      assertAndSelect(s.selectNext, 'bar');
      assertAndSelect(s.selectNext, 'zot');
      expect(s.selected, 'foo');
    });

    test('selectPrevious', () {
      expect(s.selected, 'foo');
      assertAndSelect(s.selectPrevious, 'foo');
      assertAndSelect(s.selectPrevious, 'zot');
      assertAndSelect(s.selectPrevious, 'bar');
      expect(s.selected, 'foo');
    });

    test('selectNext/Previous', () {
      expect(s.selected, 'foo');
      assertAndSelect(s.selectNext, 'foo');
      assertAndSelect(s.selectNext, 'bar');
      assertAndSelect(s.selectPrevious, 'zot');
      assertAndSelect(s.selectNext, 'bar');
      assertAndSelect(s.selectPrevious, 'zot');
      expect(s.selected, 'bar');
    });
  });
}
