// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_dialog_test;

import 'package:polymer_elements/paper_dialog.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'dart:js';

main() async {
  await initWebComponents();

  suite('modal', () {
    testAsync('backdrop element remains opened when closing top modal, closes when all modals are closed', (done) {
      var modals = fixture('opened-modals');
      modals[1].on['iron-overlay-opened'].listen((_) {
        $assert.isTrue(new JsObject.fromBrowserObject(modals[1].backdropElement)['opened'], 'backdrop is open');
        modals[1].close();
      });
      modals[1].on['iron-overlay-closed'].listen((_) {
        $assert.isTrue(new JsObject.fromBrowserObject(modals[1].backdropElement)['opened'], 'backdrop is still open');
        modals[0].close();
      });
      modals[0].on['iron-overlay-closed'].listen( (_) {
        $assert.isFalse(new JsObject.fromBrowserObject(modals[0].backdropElement)['opened'], 'backdrop is closed');
        done();
      });
    });
  });

  group('a11y', () {
    test('dialog has role="dialog"', () {
      PaperDialog dialog = fixture('basic');
      expect(dialog.getAttribute('role'), equals('dialog'), reason: 'should be role="dialog"');
    });
  });
}
