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
  await initPolymer();

  group('menubar a11y tests', () {
    TestMenuBar menubar;
    group('basic', () {
      setUp(() async {
        menubar = fixture('basic');
        await new Future(() {});
      });
      
      test('menubar has role="menubar"', () {
        expect(menubar.getAttribute('role'), 'menubar',
            reason: 'has role="menubar"');
      });

      test('first item gets focus when menubar is focused', () async {
        focus(menubar);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menubar.children.first,
            reason: 'document.activeElement is first item');
      });

      test('selected item gets focus when menubar is focused', () async {
        menubar.selected = 1;
        focus(menubar);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menubar.selectedItem,
            reason: 'document.activeElement is selected item');
      });
    });

    group('multi', () {
      setUp(() async {
        menubar = fixture('multi');
        await new Future(() {});
      });

      test('last activated item in a multi select menubar is focused',
          () async {
        menubar.selected = 0;
        tap(menubar.items[1]);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menubar.items[1],
            reason: 'document.activeElement is last activated item');
      });

      test('deselection in a multi select menubar focuses deselected item',
          () async {
        menubar.selected = 0;
        tap(menubar.items[0]);
        // wait for async in _onFocus
        await wait(200);
        expect(document.activeElement, menubar.items[0],
            reason: 'document.activeElement is last activated item');
      });
    });
  });
}
