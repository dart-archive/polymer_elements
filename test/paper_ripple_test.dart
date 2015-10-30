// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_ripple_test;

import 'dart:html' hide Point;
import 'package:polymer_elements/paper_ripple.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-ripple>', () {
    CustomEvent mouseEvent;
    DivElement rippleContainer;
    PaperRipple ripple;

    group('when tapped', () {
      setUp(() {
        rippleContainer = fixture('TrivialRipple');
        ripple = rippleContainer.children.first;
      });

      test('creates a ripple', () {
        expect(ripple.ripples.length, 0);
        down(ripple);
        expect(ripple.ripples.length, 1);
      });

      test('may create multiple ripples that overlap', () {
        expect(ripple.ripples.length, 0);
        for (var i = 0; i < 3; ++i) {
          down(ripple);
          expect(ripple.ripples.length, i + 1);
        }
      });
    });
    
    group('when holdDown is togggled', () {
      setUp( () {
        rippleContainer = fixture('TrivialRipple');
        ripple = rippleContainer.children.first;
      });

      test('generates a ripple', () {
        ripple.holdDown = true;
        expect(ripple.ripples.length, 1);
      });

      test('generates a ripple when noink', () {
        ripple.noink = true;
        ripple.holdDown = true;
        expect(ripple.ripples.length, 1);

      });

    });

    group('when target is noink',  () {
      setUp( () {
        rippleContainer = fixture('NoinkTarget');
        ripple = rippleContainer.children.first;
      });

      test('tapping does not create a ripple',  () {
        expect(ripple.keyEventTarget, ripple);
        expect(ripple.ripples.length, 0);
        down(ripple);
        expect(ripple.ripples.length, 0);
      });

      test('ripples can be manually created',  () {
        expect(ripple.ripples.length, 0);
        ripple.simulatedRipple();
        expect(ripple.ripples.length, 1);
      });
    });

    group('with the `center` attribute set to true', () {
      setUp(() {
        rippleContainer = fixture('CenteringRipple');
        ripple = rippleContainer.children.first;
      });

      test('ripples will center', () {
        var waveContainerElement;
        // let's ask the browser what `translate3d(0px, 0px, 0)` will actually look like
        var div = document.createElement('div');
        div.style.transform = 'translate3d(0px, 0px, 0)';
        down(ripple);
        waveContainerElement = ripple.ripples[0]['waveContainer'];
        up(ripple);
        return requestAnimationFrame().then((_) {
          var currentTransform = waveContainerElement.style.transform;
          expect(div.style.transform, isNotNull);
          expect(currentTransform, isNotNull);
          expect(currentTransform, div.style.transform);
        });
      });
    });

    group('with the `recenters` attribute set to true', () {
      setUp(() {
        rippleContainer = fixture('RecenteringRipple');
        ripple = rippleContainer.children.first;
        mouseEvent = fakeMouseEvent(ripple, 10, 10);
      });

      test('ripples will gravitate towards the center', () {
        var waveContainerElement;
        var waveTranslateString;
        down(ripple, new Point(10, 10));
        waveContainerElement = ripple.ripples[0]['waveContainer'];
        waveTranslateString = waveContainerElement.style.transform;
        up(ripple);
        return requestAnimationFrame().then((_) {
          expect(waveTranslateString, isNotNull);
          expect(waveContainerElement.style.transform, isNotNull);
          expect(
              waveContainerElement.style.transform, isNot(waveTranslateString));
        });
      });
    });
  });
}

CustomEvent fakeMouseEvent(Element target, int relativeX, int relativeY) {
  var rect = target.getBoundingClientRect();
  return new CustomEvent('',
      detail: {'x': rect.left + relativeX, 'y': rect.top + relativeY});
}
