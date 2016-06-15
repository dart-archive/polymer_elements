@TestOn('browser')
library polymer_elements.test.iron_menu_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/test_menu.dart';

getOwnerRoot(Element e) => new PolymerDom(e).getOwnerRoot() !=null ? new PolymerDom(e).getOwnerRoot(): document;

main() async {
  await initPolymer();

  group('menu a11y tests', () {
    TestMenu menu;
    group('basic', () {
      setUp(() async {
        menu = fixture('basic');
        await new Future(() {});
      });

      test('menu has role="menu"', () {
        expect(menu.getAttribute('role'), 'menu', reason: 'has role="menu"');
      });

      test('first item gets focus when menu is focused', () async {
        focus(menu);
        // wait for async in _onFocus
        await wait(200);
        var ownerRoot = getOwnerRoot(menu.children.first);
        var activeElement = new PolymerDom(ownerRoot).activeElement;
        expect(activeElement, menu.children.first, reason:'menu.firstElementChild is focused');
      });

      test('selected item gets focus when menu is focused', () async {
        menu.selected = 1;
        focus(menu);
        // wait for async in _onFocus
        await wait(200);
        var ownerRoot = getOwnerRoot(menu.selectedItem);
        var activeElement = Polymer.dom(ownerRoot).activeElement;
        expect(activeElement, menu.selectedItem, reason:'menu.selectedItem is focused');
      });


      test('focusing non-item content does not auto-focus an item', () async {
        TestMenu menu = fixture('basic');
        menu.extraContent.focus();
        await wait(200);
        var menuOwnerRoot = getOwnerRoot(menu.extraContent);
        var menuActiveElement = new PolymerDom(menuOwnerRoot).activeElement;
        expect(menuActiveElement, menu.extraContent, reason: 'menu.extraContent is focused');
        expect(new PolymerDom(document).activeElement, menu, reason: 'menu is document.activeElement');
      });


    });

    group('multi', () {
      setUp(() async {
        menu = fixture('multi');
        await new Future(() {});
      });

      test('last activated item in a multi select menu is focused', () async {
        menu.selected = 0;
        tap(menu.items[1]);
        // wait for async in _onFocus
        await wait(200);
        var ownerRoot = getOwnerRoot(menu.items[1]);
        var activeElement = Polymer.dom(ownerRoot).activeElement;
        expect(activeElement, menu.items[1], reason: 'menu.items[1] is focused');
      }, skip: 'fails in test runner');

      test('deselection in a multi select menu focuses deselected item',
          () async {
        menu.selected = 0;
        tap(menu.items[0]);
        // wait for async in _onFocus
        await wait(200);
        var ownerRoot = getOwnerRoot(menu.items[0]);
        var activeElement = Polymer.dom(ownerRoot).activeElement;
        expect(activeElement, menu.items[0],reason:  'menu.items[0] is focused');
      });
    });

      test('keyboard events should not bubble', () async {
        var menu = fixture('nested');
        var keyCounter = 0;

        menu.addEventListener('keydown', (event) {
          if (menu.keyboardEventMatchesKeys(event, 'esc')) {
            keyCounter++;
          }
          if (menu.keyboardEventMatchesKeys(event, 'up')) {
            keyCounter++;
          }
          if (menu.keyboardEventMatchesKeys(event, 'down')) {
            keyCounter++;
          }
        });

        // up
        keyDownOn(menu.children.first, 38);
        // down
        keyDownOn(menu.children.first, 40);
        // esc
        keyDownOn(menu.children.first, 27);

        await wait(200);
        expect(menu.children.first.tagName, 'TEST-MENU');
        expect(keyCounter, 0);
      });

    test('empty menus don\'t unfocus themselves', () async {
    var menu = fixture('empty');

    menu.focus();
    await wait(200);

    expect(Polymer.dom(document).activeElement, menu);

    });
  });
}
