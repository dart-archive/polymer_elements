// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_menu_button_test;

import 'dart:html';
import 'dart:js';
import 'dart:async';
import 'package:polymer_elements/paper_menu_button.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';

main() async {
  await initWebComponents();

  group('<paper-menu-button>', () {
    PaperMenuButton menuButton;
    SpanElement trigger;
    SpanElement content;

    setUp(() {
      menuButton = fixture('TrivialMenuButton');
      trigger = menuButton.querySelector('span.dropdown-trigger');
      content = menuButton.querySelector('span.dropdown-content');
    });

    test('opens when trigger is clicked', () {
      Completer done = new Completer();

      Rectangle contentRect = content.getBoundingClientRect();
      expect(contentRect.width, equals(0));
      expect(contentRect.height, equals(0));



      menuButton.on['paper-dropdown-open'].take(1).listen( (_) {
      $expect(menuButton.opened).to.be.equal(true);
      done.complete();
      });

      tap(trigger);

      return done.future;
    });

    test('closes when trigger is clicked again', when((done) {
      menuButton.on['paper-dropdown-open'].take(1).listen((_)async  {
      menuButton.on['paper-dropdown-close'].take(1).listen((_)  {
      $expect(menuButton.opened).to.be.equal(false);
      done();
      });

      await wait(1);
      tap(trigger);

      });

      tap(trigger);
    }));

    test('closes when disabled while open', () {
      Rectangle contentRect;

      menuButton.opened = true;
      menuButton.disabled = true;
      expect(menuButton.opened, isFalse);

      contentRect = content.getBoundingClientRect();
      expect(contentRect.width, equals(0));
      expect(contentRect.height, equals(0));
    });

    test('has aria-haspopup attribute', () {
      expect(menuButton.getAttribute('aria-haspopup'), isNotNull);
    });


    suite('when there are two buttons', () {
      PaperMenuButton menuButton;
      SpanElement trigger;
      PaperMenuButton otherButton;
      SpanElement otherTrigger;

      setup(() {
        var buttons = fixture('TwoMenuButtons');
        menuButton = buttons[0];
        otherButton = buttons[1];
        trigger = new PolymerDom(menuButton).querySelector('.dropdown-trigger');
        otherTrigger = new PolymerDom(otherButton).querySelector('.dropdown-trigger');
      });

      test('closes current and opens other', when((done) {
        $expect(menuButton.opened).to.be.equal(false);
        $expect(otherButton.opened).to.be.equal(false);

        /*
          NOTE: iron-overlay-behavior adds listeners asynchronously when the
          overlay opens, so we need to wait for this event which is a
          more-explicit signal that tells us that the overlay is really opened.
         */
        menuButton.on['iron-overlay-opened'].take(1).listen((_) async {
          $expect(menuButton.opened).to.be.equal(true);
          $expect(otherButton.opened).to.be.equal(false);

          var firstClosed = false;
          var secondOpened = false;

          menuButton.on['paper-dropdown-close'].take(1).listen( (_) {
            firstClosed = true;
          });

          otherButton.on['paper-dropdown-open'].take(1).listen( (_) {
            secondOpened = true;
          });

          await wait(1);
          tap(otherTrigger);


          await wait(1);
          $expect(firstClosed).to.be.equal(true);
          $expect(secondOpened).to.be.equal(true);

          done();
        });

        tap(trigger);
      }));
    });
    
  });
}
