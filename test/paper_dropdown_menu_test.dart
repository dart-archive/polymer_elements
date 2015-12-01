// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_dropdown_menu_test;

import 'dart:async';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_listbox.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-dropdown-menu>', () {
    PaperDropdownMenu dropdownMenu;
    PaperListbox content;

    setUp(() {
      dropdownMenu = fixture('TrivialDropdownMenu');
      content = Polymer.dom(dropdownMenu).querySelector('.dropdown-content');
    });

    test('opens when tapped', () async {
      var contentRect = content.getBoundingClientRect();

      expect(contentRect.width, 0);
      expect(contentRect.height, 0);

      tap(dropdownMenu);
      expect(dropdownMenu.opened, true);

      await wait(1);
      contentRect = content.getBoundingClientRect();

      expect(dropdownMenu.opened, true);

      expect(contentRect.width, greaterThan(0));
      expect(contentRect.height, greaterThan(0));
    });

    test('closes when an item is activated', () async {
      tap(dropdownMenu);

      await wait(1);
      var firstItem = Polymer.dom(content).querySelector('paper-item');

      tap(firstItem);

      await wait(1);
      expect(dropdownMenu.opened, false);
    });

    test('sets selected item to the activated item', () async {
      tap(dropdownMenu);

      await wait(1);
      var firstItem = Polymer.dom(content).querySelector('paper-item');

      tap(firstItem);

      await wait(1);
      expect(dropdownMenu.selectedItem, firstItem);
    });

    group('when a value is preselected', () {
      setUp(() async {
        dropdownMenu = fixture('PreselectedDropdownMenu');
        await new Future(() {});
      });

      test('the input area shows the correct selection', () {
        PolymerDom.flush();
        var secondItem =
            Polymer.dom(dropdownMenu).querySelectorAll('paper-item')[1];
        expect(dropdownMenu.selectedItem, secondItem);
      });
    });
    
    group('deselecting', () {
      var menu;

      setUp(() {
        dropdownMenu = fixture('PreselectedDropdownMenu');
        menu = Polymer.dom(dropdownMenu).querySelector('.dropdown-content');
      });

      test('an `iron-deselect` event clears the current selection', () {
        PolymerDom.flush();
        menu.selected = null;
        expect(dropdownMenu.selectedItem, null);
      });
    });

    group('validation', () {
      var menu;

      test('a non required dropdown is valid regardless of its selection', () {
        PaperDropdownMenu dropdownMenu = fixture('TrivialDropdownMenu');
        menu = Polymer.dom(dropdownMenu).querySelector('.dropdown-content');

        // no selection.
        expect(dropdownMenu.validate(null), isTrue);
        expect(dropdownMenu.invalid, isFalse);
        expect(dropdownMenu.value, isNull);

        // some selection.
        menu.selected = 1;
        expect(dropdownMenu.validate(null), isTrue);
        expect(dropdownMenu.invalid, isFalse);
        expect(dropdownMenu.value, 'Bar');
      });

      test('a required dropdown is invalid without a selection', () async {
        PaperDropdownMenu dropdownMenu = fixture('TrivialDropdownMenu');
        PolymerDom.flush();

        await new Future(() {});
        dropdownMenu.required = true;

        // no selection.
        expect(dropdownMenu.validate(null), isFalse);
        expect(dropdownMenu.invalid, isTrue);
        expect(dropdownMenu.value, isNull);
      });

      test('a required dropdown is valid with a selection', () async {
        PaperDropdownMenu dropdownMenu = fixture('PreselectedDropdownMenu');
        await new Future(() {});
        PolymerDom.flush();

        dropdownMenu.required = true;

        expect(dropdownMenu.validate(null), isTrue);
        expect(dropdownMenu.invalid, isFalse);
        expect(dropdownMenu.value, 'Bar');
      });
    });
  });
}
