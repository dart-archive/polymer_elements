// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_drawer_layout_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/app_layout/app_header/app_header.dart';

import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'package:polymer_elements/app_layout/app_toolbar/app_toolbar.dart';
import 'package:polymer_elements/app_layout_helpers.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  scrollTestHelper(Element scroller, List<Map> tests) {
    // DART NOTE : THIS IS TO LET THE TEST ROLL IN DART TEST RUNNER
    if (scroller == document.documentElement) {
      document.body.style.overflow='hidden';
      document.body.parent.style.overflow='auto';
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

  assertHeaderIsFullSized(Element header) {
    Rectangle headerClientRect = header.getBoundingClientRect();
    $assert.equal(headerClientRect.top, 0);
    $assert.equal(headerClientRect.bottom, headerClientRect.height);
  }

  assertHeaderIsCondensed(AppHeader header) {
    var headerClientRect = header.getBoundingClientRect();
    $assert.equal(headerClientRect.top + headerClientRect.height, header.jsElement['_primaryEl'].offsetHeight);
  }

  assertHeaderIsHidden(header) {
    var headerClientRect = header.getBoundingClientRect();
    $assert.isBelow(headerClientRect.bottom, 0);
  }

  suite('basic features', () {
    DivElement container;
    AppHeader header;
    AppToolbar toolbar;
    Map testEffect;

    setUpAll(() {
      testEffect = {'setUp':sinon.spy(), 'tearDown': sinon.spy(), 'run': sinon.spy()};
      AppLayout.registerEffect('test-effect', new JsObject.jsify(testEffect));
      showTestRunnerFrame();
    });

    // If you hide the last test will fail ... (!!!???)
    //tearDownAll(hideTestRunnerFrame);

    setup(() {
      container = fixture('testHeader');
      header = container.querySelector('app-header');
      toolbar = container.querySelector('app-toolbar');

      testEffect['setUp'].reset();
      testEffect['tearDown'].reset();
      testEffect['run'].reset();
    });

    test('default values', () {
      $assert.isFalse(header.condenses);
      $assert.isFalse(header.fixed);
      $assert.isFalse(header.reveals);
      $assert.isFalse(header.shadow);
    });

    testAsync('condenses', (done) {
      header.condenses = true;

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              assertHeaderIsCondensed(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 10,
            'callback': () {
              assertHeaderIsHidden(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 5,
            'callback': () {
              assertHeaderIsHidden(header);
            }
          },
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
              done();
            }
          }
        ]);
      });
    });

    testAsync('fixed', (done) {
      header.fixed = true;

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 10,
            'callback': () {
              assertHeaderIsFullSized(header);
              done();
            }
          }
        ]);
      });
    });

    testAsync('reveals', (done) {
      header.reveals = true;

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 10,
            'callback': () {
              assertHeaderIsHidden(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 5,
            'callback': () {
              assertHeaderIsFullSized(header);
              done();
            }
          }
        ]);
      });
    });

    testAsync('condenses and reveals', (done) {
      header.condenses = true;
      header.reveals = true;

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              assertHeaderIsCondensed(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 10,
            'callback': () {
              assertHeaderIsHidden(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 5,
            'callback': () {
              assertHeaderIsCondensed(header);
            }
          },
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
              done();
            }
          }
        ]);
      });
    });

    testAsync('condenses and fixed', (done) {
      header.condenses = true;
      header.fixed = true;

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              assertHeaderIsCondensed(header);
            }
          },
          {
            'y': toolbar.offsetHeight * 10,
            'callback': () {
              assertHeaderIsCondensed(header);
              done();
            }
          }
        ]);
      });
    });

    testAsync('simple effect', (done) {
      header.effects = 'test-effect';

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              $assert.isTrue((testEffect['setUp'] as sinon.Spy).called);
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, 0]);
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [1, 64]);
            }
          },
          {
            'y': toolbar.offsetHeight * 2,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [2, 128]);
            }
          },
          {
            'y': toolbar.offsetHeight * 3,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [2.078125, 133]);
            }
          },
          {
            'y': toolbar.offsetHeight * 4,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [2.078125, 133]);

              header.effects = '';

              $assert.isTrue((testEffect['tearDown'] as sinon.Spy).called);
              done();
            }
          }
        ]);
      });
    });

    testAsync('effect with config', (done) {
      var testEffectConfig = {'startsAt': 0.5, 'endsAt': 0.75};

      header.effects = 'test-effect';
      header.effectsConfig = {'test-effect': testEffectConfig};

      flush(() {
        scrollTestHelper(header.scrollTarget, [
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
            'y': 32,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, 32]);
            }
          },
          {
            'y': 40,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0.5, 40]);
            }
          },
          {
            'y': 48,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [1, 48]);
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [2, 64]);

              header.effects = '';

              $assert.isTrue((testEffect['tearDown'] as sinon.Spy).called);
              done();
            }
          }
        ]);
      });
    });

    testAsync('disabled state', (done) {
      header.effects = 'test-effect';

      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              $assert.isTrue((testEffect['setUp'] as sinon.Spy).called);
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, 0]);

              header.disabled = true;
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [0, 0]);

              header.disabled = false;
            }
          },
          {
            'y': toolbar.offsetHeight * 2,
            'callback': () {
              $assert.deepEqual((testEffect['run'] as sinon.Spy).lastCall.args, [2, 128]);

              done();
            }
          }
        ]);
      });
    });

    testAsync('isOnScreen', (done) {
      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              $assert.isTrue(header.isOnScreen());
            }
          },
          {
            'y': toolbar.offsetHeight,
            'callback': () {
              $assert.isTrue(header.isOnScreen());
            }
          },
          {
            'y': toolbar.offsetHeight * 2,
            'callback': () {
              $assert.isFalse(header.isOnScreen());
              header.fixed = true;
            }
          },
          {
            'y': toolbar.offsetHeight * 3,
            'callback': () {
              $assert.isTrue(header.isOnScreen());
              done();
            }
          }
        ]);
      });
    });

    testAsync('DOM references', (done) {
      flush(() {
        $assert.isNotNull(header.jsElement.callMethod('_getDOMRef', ['backgroundFrontLayer']));
        $assert.isNotNull(header.jsElement.callMethod('_getDOMRef', ['backgroundRearLayer']));
        $assert.isNotNull(header.jsElement.callMethod('_getDOMRef', ['title']));
        $assert.isNotNull(header.jsElement.callMethod('_getDOMRef', ['condensedTitle']));
        done();
      });
    });
  });

  suite('Primary element', () {
    DivElement container;
    AppHeader header;

    setup(() {
      container = fixture('testPrimaryElement');
      header = container.querySelector('app-header');
    });

    test('primary element reference', () {
      $assert.equal(header.jsElement.callMethod('_getPrimaryEl'), header.querySelector('[primary]'));
    });

    testAsync('should reveal the entire header', (done) {
      flush(() {
        scrollTestHelper(header.scrollTarget, [
          {
            'y': 0,
            'callback': () {
              assertHeaderIsFullSized(header);
            }
          },
          {
            'y': 1000,
            'callback': () {
              assertHeaderIsCondensed(header);
            }
          },
          {
            'y': 980,
            'callback': () async {
              await wait(100);
              assertHeaderIsFullSized(header);
              done();
            }
          }
        ]);
      });
    });
  });
}
