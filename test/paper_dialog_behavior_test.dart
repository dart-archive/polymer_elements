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
import 'package:polymer_elements/paper_dialog_shared_styles.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initPolymer();

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
          event = convertToDart(event);
          expect(event.detail['canceled'], isFalse, reason: 'dialog is not canceled');
          expect(event.detail['confirmed'], isFalse, reason: 'dialog is not confirmed');
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
          event = convertToDart(event);
          expect(event.detail['canceled'], isFalse, reason: 'dialog is not canceled');
          expect(event.detail['confirmed'], isTrue, reason: 'dialog is confirmed');
          done.complete();
        });
        Polymer.dom(dialog).querySelector('[dialog-confirm]').click();
      });
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

    test('multiple modal dialogs opened, handle focus change', when((done) {
      var dialogs = fixture('multiple');

      runAfterOpen(dialogs[0], () {
        runAfterOpen(dialogs[1], () async {
          // Each modal dialog will trap the focus within its children.
          // Multiple modal dialogs doing it might result in an infinite loop
          // dialog1 focus -> dialog2 focus -> dialog1 focus -> dialog2 focus...
          // causing a "Maximum call stack size exceeded" error.
          // Wait 50ms and verify this does not happen.
          await wait(50);
          done();
        });
      });
    }));

    test('multiple modal dialogs opened, handle outside click', when((done) {
      var dialogs = fixture('multiple');

      runAfterOpen(dialogs[0], () {
        runAfterOpen(dialogs[1], () async {
          // Click should be handled only by dialogs[1].
          tap(document.body);
          // Each modal dialog will trap the focus within its children.
          // Multiple modal dialogs doing it might result in an infinite loop
          // dialog1 focus -> dialog2 focus -> dialog1 focus -> dialog2 focus...
          // causing a "Maximum call stack size exceeded" error.
          // Wait 50ms and verify this does not happen.
          await wait(50);
          // Should not enter in an infinite loop.
          done();
        });
      });
    }));

    test('focus is given to the autofocus element when clicking on backdrop', when((done) {
      TestDialog dialog = fixture('modal');


      onSecondOpen(_) async {
        tap(document.body);
        await wait(10);
        $assert.equal(document.activeElement, Polymer.dom(dialog).querySelector('[autofocus]'), 'document.activeElement is the autofocused button');
        done();
      }

      onFirstClose(_) {
        dialog.on['iron-overlay-opened'].take(1).listen(onSecondOpen);
        dialog.open();
      }

      onFirstOpen(_) {
        dialog.on['iron-overlay-closed'].take(1).listen(onFirstClose);
        // Set the focus on dismiss button
        focus(new PolymerDom(dialog).querySelector('[dialog-dismiss]'));
        // Close the dialog
        dialog.close();
      }

      dialog.on['iron-overlay-opened'].take(1).listen(onFirstOpen);
      dialog.open();




    }));
    
    
  });

  group('a11y', () {
    test('dialog has role="dialog"', () {
      var dialog = fixture('basic');
      $assert.equal(dialog.attributes['role'], 'dialog', 'has role="dialog"');
    });

    test('dialog has aria-modal=false', () {
      var dialog = fixture('basic');
      $assert.equal(dialog.attributes['aria-modal'], 'false', 'has aria-modal="false"');
    });

    test('modal dialog has aria-modal=true', () {
      var dialog = fixture('modal');
      $assert.equal(dialog.attributes['aria-modal'], 'true', 'has aria-modal="true"');
    });
  });
}

runAfterOpen(TestDialog dialog, cb) {
  dialog.on['iron-overlay-opened'].take(1).listen((_) {
    cb();
  });
  dialog.open();
}

@PolymerRegister('test-dialog')
class TestDialog extends PolymerElement
    with
        IronFitBehavior,
        IronResizableBehavior,
        IronOverlayBehavior,
        PaperDialogBehavior {
  TestDialog.created() : super.created();
}

@PolymerRegister('test-buttons')
class TestButtons extends PolymerElement
    {
      TestButtons.created() : super.created();
}
