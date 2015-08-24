@TestOn('browser')
library polymer_elements.test.paper_dialog_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_fit_behavior.dart';
import 'package:polymer_elements/iron_overlay_behavior.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:polymer_elements/paper_dialog_behavior.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

    group('basic', () {

    test('clicking dialog does not cancel the dialog', () {
      var done = new Completer();
      var dialog = fixture('basic');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((_) {
          // Fires after test is done, but thats ok.
          if (done.isCompleted) return;
          done.completeError('dialog should not close');
        });
        dialog.click();
        wait(100).then((_) {
          done.complete();
        });
      });
      return done.future;
    });

    test('clicking dialog-dismiss button closes the dialog without confirmation', () {
      var done = new Completer();
      var dialog = fixture('basic');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((event) {
          expect(eventDetail(event)['canceled'], isFalse, reason: 'dialog is not canceled');
          expect(eventDetail(event)['confirmed'], isFalse, reason: 'dialog is not confirmed');
          done.complete();
        });
        Polymer.dom(dialog).querySelector('[dialog-dismiss]').click();
      });
      return done.future;
    });

    test('clicking dialog-confirm button closes the dialog with confirmation', () {
      var done = new Completer();
      var dialog = fixture('basic');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((event) {
          expect(eventDetail(event)['canceled'], isFalse, reason: 'dialog is not canceled');
          expect(eventDetail(event)['confirmed'], isTrue, reason: 'dialog is confirmed');
          done.complete();
        });
        Polymer.dom(dialog).querySelector('[dialog-confirm]').click();
      });
    });

    test('with-backdrop works', () {
      var dialog = fixture('backdrop');
      runAfterOpen(dialog, () {
        expect(dialog.backdropElement.opened, isTrue, reason: 'backdrop is open');
      });
    });

    test('modal dialog has backdrop', () {
      var dialog = fixture('modal');
      expect(dialog.withBackdrop, isTrue, reason: 'withBackdrop is true');
    });

    test('modal dialog has no-cancel-on-outside-click', () {
      var dialog = fixture('modal');
      expect(dialog.noCancelOnOutsideClick, isTrue, reason: 'noCancelOnOutsideClick is true');
    });

    test('clicking outside a modal dialog does not move focus from dialog', () {
      var done = new Completer();
      var dialog = fixture('modal');
      runAfterOpen(dialog, () {
        dialog.backdropElement.click();
        wait(10).then((_) {
          expect(document.activeElement, Polymer.dom(dialog).querySelector('[autofocus]'), reason: 'document.activeElement is the autofocused button');
          done.complete();
        });
      });
      return done.future;
    });

    test('removing a child element on click does not cause an exception', () {
      var done = new Completer();
      var dialog = fixture('basic');
      runAfterOpen(dialog, () {
        var button = Polymer.dom(dialog).querySelector('[extra]');
        button.on['click'].take(1).listen((event) {
          Polymer.dom(event.target.parentNode).removeChild(event.target);
          // should not throw exception here
          done.complete();
        });
        button.click();
      });
      return done.future;
    });

  });

  group('a11y', () {

    test('dialog has role="dialog"', () {
      var dialog = fixture('basic');
      expect(dialog.getAttribute('role'), 'dialog', reason: 'has role="dialog"');
    });

    test('dialog has aria-modal=false', () {
      var dialog = fixture('basic');
      expect(dialog.getAttribute('aria-modal'), 'false', reason: 'has aria-modal="false"');
    });

    test('modal dialog has aria-modal=true', () {
      var dialog = fixture('modal');
      expect(dialog.getAttribute('aria-modal'), 'true', reason: 'has aria-modal="true"');
    });

    test('dialog with header has aria-labelledby', () {
      var dialog = fixture('header');
      var header = Polymer.dom(dialog).querySelector('h2');
      expect(header.getAttribute('id'), isNotNull, reason: 'header has auto-generated id');
      expect(dialog.getAttribute('aria-labelledby'), header.getAttribute('id'), reason: 'aria-labelledby is set to header id');
    });

    test('dialog with lazily created header has aria-labelledby', () {
      var done = new Completer();
      var dialog = fixture('basic');
      var header = document.createElement('h2');
      Polymer.dom(dialog).append(header);
      PolymerDom.flush();
      wait(10).then((_) {
        expect(header.getAttribute('id'), isNotNull, reason: 'header has auto-generated id');
        expect(dialog.getAttribute('aria-labelledby'), header.getAttribute('id'), reason: 'aria-labelledby is set to header id');
        done.complete();
      });
      return done.future;
    });

    test('dialog with header with id preserves id and has aria-labelledby', () {
      var dialog = fixture('header-with-id');
      var header = Polymer.dom(dialog).querySelector('h2');
      expect(header.getAttribute('id'), 'header', reason: 'header has preset id');
      expect(dialog.getAttribute('aria-labelledby'), 'header', reason: 'aria-labelledby is set to header id');
    });

  });
}

runAfterOpen(TestDialog dialog, cb) {
  dialog.on['iron-overlay-opened'].take(1).listen((_) {
    cb();
  });
  dialog.open();
}

@jsProxyReflectable
@PolymerRegister('test-dialog')
class TestDialog extends PolymerElement
    with
        IronFitBehavior,
        IronResizableBehavior,
        IronOverlayBehavior,
        PaperDialogBehavior {
  TestDialog.created() : super.created();
}
