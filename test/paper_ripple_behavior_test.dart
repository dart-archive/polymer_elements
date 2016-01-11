// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_ripple_behavior_test;

import 'dart:html';

import 'package:test/test.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_elements/paper_ripple_behavior.dart';
import 'package:polymer/polymer.dart';

import 'common.dart';

main() async {
  await initPolymer();

  group('PaperRippleBehavior', () {
    var ripple;

    setUp(() {
      ripple = fixture('basic');
    });

    test('no ripple at startup', () {
      expect(ripple.hasRipple(), isFalse);
    });

    test('calling getRipple returns ripple', () {
      expect(ripple.getRipple(), isNotNull);
    });

    test('focus generates ripple', () {
      focus(ripple);
      expect(ripple.hasRipple(), isTrue);
    });

    test('down generates ripple', () {
      down(ripple);
      expect(ripple.hasRipple(), isTrue);
      up(ripple);
    });

    group('Correct Targeting', () {
      assertInteractionCausesRipple(host, node, expected, msg) {
        var ripple = host.getRipple();
        PolymerDom.flush();
        down(node);
        expect(ripple.ripples.length > 0, expected, reason: msg);
        up(node);
      }

      assertInteractionAtLocationCausesRipple(
          host, node, location, expected, msg) {
        var ripple = host.getRipple();
        PolymerDom.flush();
        down(node, location);
        expect(ripple.ripples.length > 0, expected, reason: msg);
        up(node);
      }

      group('basic', () {
        group('container = host', () {
          setUp(() {
            ripple = fixture('ShadowBasic');
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, true, 'ripple');
          });
          test('tap #wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], true, '#wrapper');
          });
          test('tap #separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], true, '#separate');
          });
        });

        group('container = wrapper', () {
          setUp(() {
            ripple = fixture('ShadowBasic');
            ripple..jsElement['_rippleContainer'] = ripple.$['wrapper'];
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, false, 'ripple');
          });

          test('tap #wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], true, '#wrapper');
          });

          test('tap #separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], false, '#separate');
          });
        });

        group('container = separate', () {
          setUp(() {
            ripple = fixture('ShadowBasic');
            ripple..jsElement['_rippleContainer'] = ripple.$['separate'];
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, false, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], false, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], true, '#separate');
          });
        });
      });

      group('distributed text', () {
        var textLocation;

        getTextLocation(ripple) {
          // build a Range to get the BCR of a given text node
          var r = document.createRange();
          r.selectNode(Polymer.dom(ripple.$['content']).getDistributedNodes()[0]);
          return middleOfNode(r);
        }

        group('container = host', () {
          setUp(() {
            ripple = fixture('ShadowText');
            textLocation = getTextLocation(ripple);
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, true, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], true, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], true, '#separate');
          });

          test('tap text', () {
            assertInteractionAtLocationCausesRipple(
                ripple, ripple.$['wrapper'], textLocation, true, 'text');
          });
        });

        group('container = wrapper', () {
          setUp(() {
            ripple = fixture('ShadowText');
            ripple..jsElement['_rippleContainer'] = ripple.$['wrapper'];
            textLocation = getTextLocation(ripple);
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, false, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], true, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], false, '#separate');
          });

          test('tap text', () {
            assertInteractionAtLocationCausesRipple(
                ripple, ripple.$['wrapper'], textLocation, true, 'text');
          });
        });

        group('container = separate', () {
          setUp(() {
            ripple = fixture('ShadowText');
            ripple..jsElement['_rippleContainer'] = ripple.$['separate'];
            textLocation = getTextLocation(ripple);
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, false, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], false, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], true, '#separate');
          });

          test('tap text', () {
            assertInteractionAtLocationCausesRipple(
                ripple, ripple.$['wrapper'], textLocation, false, 'text');
          });
        });
      });

      group('distributed element', () {
        var source;

        group('container = host', () {
          setUp(() {
            ripple = fixture('ShadowElement');
            source = Polymer.dom(ripple).querySelector('#source');
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, true, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], true, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], true, '#separate');
          });

          test('tap source', () {
            assertInteractionCausesRipple(ripple, source, true, '#source');
          });
        });

        group('container = wrapper', () {
          setUp(() {
            ripple = fixture('ShadowElement');
            ripple..jsElement['_rippleContainer'] = ripple.$['wrapper'];
            source = Polymer.dom(ripple).querySelector('#source');
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, false, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], true, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], false, '#separate');
          });

          test('tap source', () {
            assertInteractionCausesRipple(ripple, source, true, '#source');
          });
        });

        group('container = separate', () {
          setUp(() {
            ripple = fixture('ShadowElement');
            ripple..jsElement['_rippleContainer'] = ripple.$['separate'];
            source = Polymer.dom(ripple).querySelector('#source');
          });

          test('tap host', () {
            assertInteractionCausesRipple(ripple, ripple, false, 'ripple');
          });

          test('tap wrapper', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['wrapper'], false, '#wrapper');
          });

          test('tap separate', () {
            assertInteractionCausesRipple(
                ripple, ripple.$['separate'], true, '#separate');
          });

          test('tap source', () {
            assertInteractionCausesRipple(ripple, source, false, '#source');
          });
        });
      });
    });
  });
}

@PolymerRegister('test-ripple')
class TestRipple extends PolymerElement
    with
        IronA11yKeysBehavior,
        IronButtonState,
        IronControlState,
        PaperRippleBehavior {
  TestRipple.created() : super.created();
}

@PolymerRegister('sd-ripple')
class SdRipple extends PolymerElement
    with
        IronA11yKeysBehavior,
        IronButtonState,
        IronControlState,
        PaperRippleBehavior {
  SdRipple.created() : super.created();
}
