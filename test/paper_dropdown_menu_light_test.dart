// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_dropdown_menu_test;

import 'dart:async';
import 'package:polymer_elements/paper_dropdown_menu_light.dart';
import 'package:polymer_elements/paper_listbox.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';
import 'dart:html';

main() async {
  await initPolymer();

  runAfterOpen(PaperDropdownMenuLight menu, callback()) {
    menu.$['menuButton'].$['dropdown'].on['iron-overlay-opened'].listen((_) async {
      await wait(1);
      callback();
    });
    tap(menu);
  }

  suite('<paper-dropdown-menu-light>', () {
    PaperDropdownMenuLight dropdownMenu;
    Element content;

    setup(() {
      dropdownMenu = fixture('TrivialDropdownMenu');
      content = Polymer.dom(dropdownMenu).querySelector('.dropdown-content');
    });

    test('opens when tapped', when((done) {
      Rectangle contentRect = content.getBoundingClientRect();

      $expect(contentRect.width).to.be.equal(0);
      $expect(contentRect.height).to.be.equal(0);

      runAfterOpen(dropdownMenu, () {
        contentRect = content.getBoundingClientRect();

        $expect(dropdownMenu.opened).to.be.equal(true);

        $expect(contentRect.width).to.be.greaterThan(0);
        $expect(contentRect.height).to.be.greaterThan(0);
        done();
      });

      $expect(dropdownMenu.opened).to.be.equal(true);
    }));

    test('closes when an item is activated', when((done) {
      runAfterOpen(dropdownMenu, () {
        var firstItem = Polymer.dom(content).querySelector('paper-item');

        tap(firstItem);

        $async(() {
          $expect(dropdownMenu.opened).to.be.equal(false);
          done();
        });
      });
    }));

    test('sets selected item to the activated item', when((done) {
      runAfterOpen(dropdownMenu, () {
        var firstItem = Polymer.dom(content).querySelector('paper-item');

        tap(firstItem);

        $async(() {
          $expect(dropdownMenu.selectedItem).to.be.equal(firstItem);
          done();
        });
      });
    }));

    suite('when a value is preselected', () {
      setup(() {
        dropdownMenu = fixture('PreselectedDropdownMenu');
      });

      test('the input area shows the correct selection', () {
        PolymerDom.flush();
        var secondItem = Polymer.dom(dropdownMenu).querySelectorAll('paper-item')[1];
        $expect(dropdownMenu.selectedItem).to.be.equal(secondItem);
      });
    });

    suite('deselecting', () {
      var menu;

      setup(() {
        dropdownMenu = fixture('PreselectedDropdownMenu');
        menu = Polymer.dom(dropdownMenu).querySelector('.dropdown-content');
      });

      test('an `iron-deselect` event clears the current selection', () {
        PolymerDom.flush();
        menu.selected = null;
        $expect(dropdownMenu.selectedItem).to.be.equal(null);
      });
    });

    suite('validation', () {
      test('a non required dropdown is valid regardless of its selection', () {
        PaperDropdownMenuLight dropdownMenu = fixture('TrivialDropdownMenu');
        var menu = Polymer.dom(dropdownMenu).querySelector('.dropdown-content');

        // no selection.
        $expect(dropdownMenu.validate("")).to.be.$true;
        $expect(dropdownMenu.invalid).to.be.$false;
        $expect(dropdownMenu.value).to.not.be.ok;

        // some selection.
        menu.selected = 1;
        $expect(dropdownMenu.validate("")).to.be.$true;
        $expect(dropdownMenu.invalid).to.be.$false;
        $expect(dropdownMenu.value).to.be.equal('Bar');
      });

      test('a required dropdown is invalid without a selection', () {
        PaperDropdownMenuLight dropdownMenu = fixture('TrivialDropdownMenu');
        dropdownMenu.required = true;

        // no selection.
        $expect(dropdownMenu.validate("")).to.be.$false;
        $expect(dropdownMenu.invalid).to.be.$true;
        $expect(dropdownMenu.value).to.not.be.ok;
      });

      test('a required dropdown is valid with a selection', () {
        PaperDropdownMenuLight dropdownMenu = fixture('PreselectedDropdownMenu');
        PolymerDom.flush();

        dropdownMenu.required = true;

        $expect(dropdownMenu.validate("")).to.be.$true;
        $expect(dropdownMenu.invalid).to.be.$false;
        $expect(dropdownMenu.value).to.be.equal('Bar');
      });
    });
  });
}
