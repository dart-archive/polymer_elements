// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_dialog_scrollable_test;

import 'dart:async';
import 'dart:html';
// IGNORE : unused_import
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/paper_dialog_scrollable.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_dialog.dart';

main() async {
  await initPolymer();

  Matcher anyNoneMatch = anyOf('""', "''", '', 'none');

  void runAfterScroll(HtmlElement node, int scrollTop, callback) {
    node.scrollTop = scrollTop;

    void timeout() {
      node.scrollTop = scrollTop;
      if (node.scrollTop == scrollTop) {
        wait(250).then((_) {
          callback();
        });
      } else {
        wait(10).then((_) {
          timeout();
        });
      }
    }

    wait(1).then((_) {
      timeout();
    });
  }

  group('basic', () {
    test('shows top divider if scrolled', () {
      Completer done = new Completer();

      HtmlElement container = fixture('basic');
      PaperDialogScrollable scrollable =
      container.querySelector('paper-dialog-scrollable');

      wait(10).then((_) {
        runAfterScroll(scrollable.scrollTarget, 10, () {
          expect(scrollable
                     .getComputedStyle('::before')
                     .content, isNotNull);
          done.complete();
        });
      });
      return done.future;
    });

    test('shows bottom divider if scrollable', () {
      Completer done = new Completer();

      HtmlElement container = fixture('basic');

      wait(10).then((_) {
        PaperDialogScrollable scrollable =
        container.querySelector('paper-dialog-scrollable');

        window.requestAnimationFrame((_) {
          expect(scrollable
                     .getComputedStyle('::after')
                     .content, isNotNull,
                     reason: '::after should have content');
          done.complete();
        });
      });
      return done.future;
    });

    test('hides bottom divider if scrolled to bottom', () {
      Completer done = new Completer();

      HtmlElement container = fixture('basic');
      PaperDialogScrollable scrollable =
      container.querySelector('paper-dialog-scrollable');

      wait(10).then((_) {
        runAfterScroll(
            scrollable.scrollTarget,
            scrollable.scrollTarget.scrollHeight -
                scrollable.scrollTarget.offsetHeight, () {
          var content = scrollable
              .getComputedStyle('::after')
              .content;
          expect(content, anyNoneMatch,
                     reason: '::after should not have content');
          done.complete();
        });
      });
      return done.future;
    });

    test('does not show dividers if scrolled and only child', () {
      Completer done = new Completer();

      HtmlElement container = fixture('only-child');
      PaperDialogScrollable scrollable =
      container.querySelector('paper-dialog-scrollable');

      wait(10).then((_) {
        runAfterScroll(scrollable.scrollTarget, 10, () {
          var contentBefore = scrollable
              .getComputedStyle('::before')
              .content;
          expect(contentBefore, anyNoneMatch,
                     reason: '::before should not have content');

          var contentAfter = scrollable
              .getComputedStyle('::after')
              .content;
          expect(contentAfter, anyNoneMatch,
                     reason: '::after should not have content');
          done.complete();
        });
      });
      return done.future;
    });

    test('does not show bottom divider if not scrollable', () {
      Completer done = new Completer();

      HtmlElement container = fixture('short');
      PaperDialogScrollable scrollable =
      container.querySelector('paper-dialog-scrollable');

      wait(10).then((_) {
        var contentAfter = scrollable
            .getComputedStyle('::after')
            .content;
        expect(contentAfter, anyNoneMatch,
                   reason: '::after should not have content');
        done.complete();
      });
      return done.future;
    });

    test('can be added dynamically', when((done) async {
      PaperDialogScrollable scrollable = document.createElement('paper-dialog-scrollable');
      document.body.children.add(scrollable);
      await wait(10);
      $assert.isTrue(scrollable.dialogElement == document.body, 'dialogElement is body');
      document.body.children.remove(scrollable);
      done();
    }));

    test('correctly sized (container = section)', () async {
      HtmlElement container = fixture('basic');
      await wait(1);
      PaperDialogScrollable scrollable = new PolymerDom(container).querySelector('paper-dialog-scrollable');
      var cRect = container.getBoundingClientRect();
      var sRect = scrollable.getBoundingClientRect();
      var stRect = scrollable.scrollTarget.getBoundingClientRect();
      $assert.equal(sRect.width, cRect.width, 'scrollable width ok');
      $assert.isAbove(sRect.height, 0, 'scrollable height bigger than 0');
      $assert.isBelow(sRect.height, cRect.height, 'scrollable height contained in container height');
      $assert.equal(stRect.width, sRect.width, 'scrollTarget width ok');
      $assert.equal(stRect.height, sRect.height, 'scrollTarget height ok');
    },skip: "--layout flex not woriking in test runner ?");

    test('correctly sized (container = paper-dialog[opened])', when((done) {
      PaperDialog dialog = fixture('dialog');
      PaperDialogScrollable scrollable = Polymer.dom(dialog).querySelector('paper-dialog-scrollable');
      // Wait for dialog to be opened and styles applied.
      dialog.on['iron-overlay-opened'].take(1).listen((_) {
        var dRect = dialog.getBoundingClientRect();
        var sRect = scrollable.getBoundingClientRect();
        var stRect = scrollable.scrollTarget.getBoundingClientRect();
        $assert.equal(sRect.width, dRect.width, 'scrollable width ok');
        $assert.isAbove(sRect.height, 0, 'scrollable height bigger than 0');
        $assert.isBelow(sRect.height, dRect.height, 'scrollable height contained in dialog height');
        $assert.equal(stRect.width, sRect.width, 'scrollTarget width ok');
        $assert.equal(stRect.height, sRect.height, 'scrollTarget height ok');
        done();
      });
    }));
  });
}
