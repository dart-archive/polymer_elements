@TestOn('browser')
library polymer_elements.test.paper_dialog_scrollable_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_dialog_scrollable.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

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
          expect(scrollable.getComputedStyle('::before').content, isNotNull);
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
          expect(scrollable.getComputedStyle('::after').content, isNotNull,
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
        runAfterScroll(scrollable.scrollTarget,
            scrollable.scrollTarget.scrollHeight -
                scrollable.scrollTarget.offsetHeight, () {
          var content = scrollable.getComputedStyle('::after').content;
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
          var contentBefore = scrollable.getComputedStyle('::before').content;
          expect(contentBefore, anyNoneMatch,
              reason: '::before should not have content');

          var contentAfter = scrollable.getComputedStyle('::after').content;
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
        var contentAfter = scrollable.getComputedStyle('::after').content;
        expect(contentAfter, anyNoneMatch,
            reason: '::after should not have content');
        done.complete();
      });
      return done.future;
    });
  });
}
