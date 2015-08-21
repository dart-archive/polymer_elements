@TestOn('browser')
library polymer_elements.test.iron_resizable_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'fixtures/iron_resizable_elements.dart';

main() async {
  await initWebComponents();

  group('iron-resizable-behavior', () {
    XLightResizable resizable;

    group('events across shadow boundaries', () {
      setUp(() {
        resizable = fixture('ResizableAndShadowBoundaries');
      });

      group('ancestor\'s iron-resize', () {
        test('only fires once for a notifying shadow descendent', () {
          resizable.$['childResizable1'].notifyResize();

          expect(resizable.ironResizeCount, 2);
        });

        test('only fires once when notifying descendent observables', () {
          resizable.notifyResize();

          expect(resizable.ironResizeCount, 2);
        });
      });

      group('descendant\'s iron-resize', () {
        test('only fires once for a notifying shadow root', () {
          resizable.notifyResize();

          expect(resizable.$['childResizable1'].ironResizeCount, 2);
          expect(resizable.$['childResizable2'].ironResizeCount, 2);
        });

        test('only fires once for a notifying descendent observable', () {
          resizable.$['childResizable1'].notifyResize();

          expect(resizable.$['childResizable1'].ironResizeCount, 2);
        });
      });

      group('window\'s resize', () {
        test('causes all iron-resize events to fire once', () {
          window.dispatchEvent(new CustomEvent('resize'));
          expect(resizable.ironResizeCount, 2);
          expect(resizable.$['childResizable1'].ironResizeCount, 2);
          expect(resizable.$['childResizable2'].ironResizeCount, 2);
        });
      });
    });

  });
}
