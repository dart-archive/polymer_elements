// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_dropdown_menu_test;

import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-dropdown-menu>', () {
    PaperDropdownMenu dropdownMenu;
    PaperMenu content;

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
      setUp(() {
        dropdownMenu = fixture('PreselectedDropdownMenu');
      });

      test('the input area shows the correct selection', () {
        var secondItem = Polymer.dom(dropdownMenu).querySelectorAll('paper-item')[1];
        expect(dropdownMenu.selectedItem, secondItem);
      });
    });
  });
}
