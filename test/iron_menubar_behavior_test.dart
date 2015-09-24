@TestOn('browser')
library polymer_elements.test.iron_menubar_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/test_menubar.dart';

main() async {
  await initWebComponents();

  group('menubar a11y tests', () {
    test('menubar has role="menubar"', () {
      TestMenuBar menubar = fixture('basic');
      expect(menubar.getAttribute('role'), 'menubar',
          reason: 'has role="menubar"');
    });

    test('first item gets focus when menubar is focused', () async {
      TestMenuBar menubar = fixture('basic');
      focus(menubar);
      // wait for async in _onFocus
      await wait(200);
      expect(document.activeElement, menubar.children.first,
          reason: 'document.activeElement is first item');
    });

    test('selected item gets focus when menubar is focused', () async {
      TestMenuBar menubar = fixture('basic');
      menubar.selected = 1;
      focus(menubar);
      // wait for async in _onFocus
      await wait(200);
      expect(document.activeElement, menubar.selectedItem,
          reason: 'document.activeElement is selected item');
    });

    test('last activated item in a multi select menubar is focused', () async {
      TestMenuBar menubar = fixture('multi');
      menubar.selected = 0;
      tap(menubar.items[1]);
      // wait for async in _onFocus
      await wait(200);
      expect(document.activeElement, menubar.items[1],
          reason: 'document.activeElement is last activated item');
    });

    test('deselection in a multi select menubar focuses deselected item',
        () async {
          TestMenuBar menubar = fixture('multi');
      menubar.selected = 0;
      tap(menubar.items[0]);
      // wait for async in _onFocus
      await wait(200);
      expect(document.activeElement, menubar.items[0],
          reason: 'document.activeElement is last activated item');
    });
  });
}
