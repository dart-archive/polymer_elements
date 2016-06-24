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

    testAsync('dialog-dismiss on a custom element is handled', (done) {
      TestDialog dialog = fixture('custom-element-button');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((event) {
          event = convertToDart(event);
          $assert.isFalse(event.detail['canceled'], 'dialog is not canceled');
          $assert.isFalse(event.detail['confirmed'], 'dialog is not confirmed');
          done();
        });
        tap(new PolymerDom(dialog).querySelector('[dialog-dismiss]'));
      });
    });

    testAsync('dialog-dismiss button inside a custom element is handled', (done) {
      TestDialog dialog = fixture('buttons');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((event) {
          event = convertToDart(event);
          $assert.isFalse(event.detail['canceled'], 'dialog is not canceled');
          $assert.isFalse(event.detail['confirmed'], 'dialog is not confirmed');
          done();
        });
        tap((new PolymerDom(dialog).querySelector('test-buttons') as TestButtons).$['dismiss']);
      });
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
        new PolymerDom(dialog).querySelector('[dialog-confirm]').click();
      });
    });

    testAsync('dialog-confirm on a custom element handled', (done) {
      TestDialog dialog = fixture('custom-element-button');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((event) {
          event = convertToDart(event);
          $assert.isFalse(event.detail['canceled'], 'dialog is not canceled');
          $assert.isTrue(event.detail['confirmed'], 'dialog is confirmed');
          done();
        });
        tap(new PolymerDom(dialog).querySelector('[dialog-confirm]'));
      });
    });

    testAsync('dialog-confirm button inside a custom element is handled', (done) {
      var dialog = fixture('buttons');
      runAfterOpen(dialog, () {
        dialog.on['iron-overlay-closed'].take(1).listen((event) {
          event = convertToDart(event);
          $assert.isFalse(event.detail['canceled'], 'dialog is not canceled');
          $assert.isTrue(event.detail['confirmed'], 'dialog is confirmed');
          done();
        });
        tap((new PolymerDom(dialog).querySelector('test-buttons') as TestButtons).$['confirm']);
      });
    });

    testAsync('clicking dialog-dismiss button closes only the dialog where is contained', (done) async {
      var dialog = fixture('nestedmodals');
      TestDialog innerDialog = new PolymerDom(dialog).querySelector('test-dialog');
      tap(new PolymerDom(innerDialog).querySelector('[dialog-dismiss]'));
      await wait(10);
      $assert.isFalse(innerDialog.opened, 'inner dialog is closed');
      $assert.isTrue(dialog.opened, 'dialog is still open');
      done();
    });

    testAsync('clicking dialog-confirm button closes only the dialog where is contained', (done) async {
      TestDialog dialog = fixture('nestedmodals');
      TestDialog innerDialog = new PolymerDom(dialog).querySelector('test-dialog');
      tap(new PolymerDom(innerDialog).querySelector('[dialog-confirm]'));
      await wait(10);
      $assert.isFalse(innerDialog.opened, 'inner dialog is closed');
      $assert.isTrue(dialog.opened, 'dialog is still open');
      done();
    });

    List<String> properties = ['noCancelOnEscKey', 'noCancelOnOutsideClick', 'withBackdrop'];

    // Could use polymer accessors or underlining js props but this way is more a 'dartish'
    getProperty(TestDialog x, propName) {
      Map<String, Function> getters = {
        'noCancelOnEscKey': (TestDialog x) => x.noCancelOnEscKey,
        'noCancelOnOutsideClick': (TestDialog x) => x.noCancelOnOutsideClick,
        'withBackdrop': (TestDialog x) => x.withBackdrop
      };

      return getters[propName](x);
    }

    setProperty(TestDialog x, propName, val) {
      Map<String, Function> setters = {
        'noCancelOnEscKey': (TestDialog x, val) => x.noCancelOnEscKey = val,
        'noCancelOnOutsideClick': (TestDialog x, val) => x.noCancelOnOutsideClick = val,
        'withBackdrop': (TestDialog x, val) => x.withBackdrop = val
      };

      setters[propName](x, val);
    }

    properties.forEach((String property) {
      test('modal sets ' + property + ' to true', () {
        TestDialog dialog = fixture('modal');
        $assert.isTrue(getProperty(dialog, property), property);
      });

      test('modal toggling keeps current value of ' + property, () {
        var dialog = fixture('modal');
        // Changed to false while modal is true.
        setProperty(dialog, property, false);
        dialog.modal = false;
        $assert.isFalse(getProperty(dialog, property), property + ' is false');
      });

      test('modal toggling keeps previous value of ' + property, () {
        var dialog = fixture('basic');
        // Changed before modal is true.
        setProperty(dialog, property, true);
        // Toggle twice to trigger observer.
        dialog.modal = true;
        dialog.modal = false;
        $assert.isTrue(getProperty(dialog, property), property + ' is still true');
      });

      test('default modal does not override ' + property + ' (attribute)', () {
        // Property is set on ready from attribute.
        var dialog = fixture('like-modal');
        $assert.isTrue(getProperty(dialog, property), property + ' is true');
      });

      test('modal toggling keeps previous value of ' + property + ' (attribute)', () {
        // Property is set on ready from attribute.
        var dialog = fixture('like-modal');
        // Toggle twice to trigger observer.
        dialog.modal = true;
        dialog.modal = false;
        $assert.isTrue(getProperty(dialog, property), property + ' is still true');
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
class TestDialog extends PolymerElement with IronFitBehavior, IronResizableBehavior, IronOverlayBehavior, PaperDialogBehavior {
  TestDialog.created() : super.created();
}

@PolymerRegister('test-buttons')
class TestButtons extends PolymerElement {
  TestButtons.created() : super.created();
}
