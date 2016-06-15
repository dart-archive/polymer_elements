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

getOwnerRoot(Element e) => new PolymerDom(e).getOwnerRoot() !=null ? new PolymerDom(e).getOwnerRoot(): document;

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
        expect(new PolymerDom(document).activeElement, menubar.children.first,
            reason: 'document.activeElement is first item');
      });

      test('selected item gets focus when menubar is focused', () async {
        menubar.selected = 1;
        focus(menubar);
        // wait for async in _onFocus
        await wait(200);
        expect(new PolymerDom(document).activeElement, menubar.selectedItem,
            reason: 'document.activeElement is selected item');
      });


      test('focusing non-item content does not auto-focus an item', () async {
        TestMenuBar menubar = fixture('basic');
        menubar.extraContent.focus();
        await wait(200);
        var ownerRoot = getOwnerRoot(menubar.extraContent);
        var activeElement = Polymer
            .dom(ownerRoot)
            .activeElement;
        expect(activeElement, menubar.extraContent, reason: 'menubar.extraContent is focused');
        expect(Polymer
                   .dom(document)
                   .activeElement, menubar, reason: 'menubar is document.activeElement');
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
        expect(new PolymerDom(document).activeElement, menubar.items[1],
            reason: 'document.activeElement is last activated item');
      });

      test('deselection in a multi select menubar focuses deselected item',
          () async {
        menubar.selected = 0;
        tap(menubar.items[0]);
        // wait for async in _onFocus
        await wait(200);
        expect(new PolymerDom(document).activeElement, menubar.items[0],
            reason: 'document.activeElement is last activated item');
      });
    });

    group('left / right keys are reversed when the menubar has RTL directionality', () {
      const int LEFT = 37;
      const int RIGHT = 39;

      test('left key moves to the next item', () {
        var rtlContainer = fixture('rtl');
        var menubar = rtlContainer.querySelector('test-menubar');
        menubar.selected = 0;
        menubar.items[1].click();

        expect(new PolymerDom(document).activeElement, menubar.items[1]);

        pressAndReleaseKeyOn(menubar, LEFT);

        expect(new PolymerDom(document).activeElement, menubar.items[2],
                   reason: '`document.activeElement` should be the next item.');
        expect(menubar.selected, 1,
                   reason: '`menubar.selected` should not change.');
      });

      test('right key moves to the previous item', () {
        var rtlContainer = fixture('rtl');
        var menubar = rtlContainer.querySelector('test-menubar');
        menubar.selected = 0;
        menubar.items[1].click();

        expect(new PolymerDom(document).activeElement, menubar.items[1]);

        pressAndReleaseKeyOn(menubar, RIGHT);

        expect(new PolymerDom(document).activeElement, menubar.items[0],
                   reason: '`document.activeElement` should be the previous item');
        expect(menubar.selected, 1,
                   reason: '`menubar.selected` should not change.');
      });
    });


  });
}
