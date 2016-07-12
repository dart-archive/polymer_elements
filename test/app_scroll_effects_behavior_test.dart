// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_scroll_effects_behavior_test;

import 'package:polymer_interop/polymer_interop.dart';


import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_container.dart';
import 'package:polymer_elements/app_layout_helpers.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  scrollTestHelper(Element scroller, List<Map> tests) {
    // DART NOTE : THIS IS TO LET THE TEST ROLL IN DART TEST RUNNER
    if (scroller == document.documentElement) {
      document.body.style.overflow = 'hidden';
      document.body.parent.style.overflow = 'auto';
    }
    Function scrollEventHandler;
    triggerScrollEvent() {
      var scrollTop = scroller == document.documentElement ? window.pageYOffset : scroller.scrollTop;
      if (tests[0]['y'] == scrollTop) {
// Scrolling to the same position won't trigger a scroll event,
// so just call the scroll event handler.
        scrollEventHandler();
      } else {
        if (scroller == document.documentElement)
          window.scrollTo(0, tests[0]['y']);
        else
          scroller.scrollTop = tests[0]['y'];
      }
    }
    scrollEventHandler = ([_]) {
      if (tests.isEmpty) {
        return;
      }
      Map nextTest = tests.removeAt(0);
      nextTest['callback']();
      if (tests.length > 0) triggerScrollEvent();
    };

    if (tests.length > 0) {
      var scrollTarget = scroller == document.documentElement ? window : scroller;
      scrollTarget.onScroll.listen(scrollEventHandler);
      triggerScrollEvent();
    }
  }

  suite('basic features', () {
    XContainer container;
    Map testEffect;

    setUpAll(() {
      testEffect = {'setUp': sinon.spy(), 'tearDown': sinon.spy(), 'run': sinon.spy()};
      AppLayout.registerEffect('test-effect', new JsObject.jsify(testEffect));
      showTestRunnerFrame();
    });

    setup(() {
      container = fixture('testHeader');
      testEffect['setUp'].reset();
      testEffect['tearDown'].reset();
      testEffect['run'].reset();
    });

    testAsync('simple effect', (done) {
      container.effects = 'test-effect';

      flush(() {
        scrollTestHelper(container.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              $assert.isTrue((testEffect['setUp'] as sinon.Spy).called);
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, 0]);
            }
          },
          {
            'y': container.offsetHeight * 0.5,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0.5, container.offsetHeight * 0.5]);
            }
          },
          {
            'y': container.offsetHeight,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [1, container.offsetHeight]);
            }
          },
          {
            'y': container.offsetHeight * 2,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [2, container.offsetHeight * 2]);
            }
          },
          {
            'y': container.offsetHeight * 3,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [3, container.offsetHeight * 3]);
              container.effects = '';
              $assert.isTrue((testEffect['tearDown'] as sinon.Spy).called);
              done();
            }
          }
        ]);
      });
    });

    testAsync('effect with config', (done) {
      var testEffectConfig = {'startsAt': 0.5, 'endsAt': 1};

      container.effects = 'test-effect';
      container.effectsConfig = {'test-effect': testEffectConfig};

      flush(() {
        scrollTestHelper(container.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              $assert.isTrue((testEffect['setUp'] as sinon.Spy).called);
              $assert.deepEqual((testEffect['setUp'] as sinon.Spy).lastCall.args[0]['startsAt'], testEffectConfig['startsAt']);
              $assert.deepEqual((testEffect['setUp'] as sinon.Spy).lastCall.args[0]['endsAt'], testEffectConfig['endsAt']);

              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, 0]);
            }
          },
          {
            'y': container.offsetHeight * 0.25,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, container.offsetHeight * 0.25]);
            }
          },
          {
            'y': container.offsetHeight * 0.5,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, container.offsetHeight * 0.5]);
            }
          },
          {
            'y': container.offsetHeight * 0.75,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0.5, container.offsetHeight * 0.75]);
            }
          },
          {
            'y': container.offsetHeight,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [1, container.offsetHeight]);
              container.effects = '';
              $assert.isTrue((testEffect['tearDown'] as sinon.Spy).called);
              done();
            }
          }
        ]);
      });
    });
  });
}
