@TestOn('browser')
library polymer_elements.test.iron_overlay_behavior_backdrop_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';
import 'fixtures/test_overlay.dart';
import 'fixtures/test_overlay2.dart';
import 'sinon/sinon.dart';
import 'package:polymer_elements/iron_overlay_manager.dart';
import 'fixtures/test_buttons.dart';
import 'package:polymer_elements/iron_overlay_backdrop.dart';
import 'fixtures/test_menu_button.dart';


Future runAfterOpen(overlay, cb) {
  Completer completer = new Completer();
  overlay.on['iron-overlay-opened'].take(1).listen((_) async {
    await wait(1);
    await cb();
    completer.complete();
  });
  overlay.open();
  return completer.future;
}

Future runAfterClose(overlay, cb) {
  Completer completer = new Completer();
  overlay.on['iron-overlay-closed'].take(1).listen((_) async {
    await wait(1);
    await cb();
    completer.complete();
  });
  overlay.close();
  return completer.future;
}

main() async {
  await initPolymer();

  suite('overlay with backdrop', () {
    TestOverlay overlay;

    setup(() {
      overlay = fixture('backdrop');
    });

    test('backdrop size matches parent size', when((done) {
      runAfterOpen(overlay, () {
        // Flush so we are sure backdrop is added in the DOM.
        PolymerDom.flush();
        var backdrop = overlay.backdropElement;
        var parent = backdrop.parent;
        $assert.strictEqual(backdrop.offsetWidth, parent.clientWidth, 'backdrop width matches parent width');
        $assert.strictEqual(backdrop.offsetHeight, parent.clientHeight, 'backdrop height matches parent height');
        done();
      });
    }));
  });
}
