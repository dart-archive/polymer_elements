// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_ripple_test;

import 'dart:async';
import 'dart:html' hide Point;
import 'package:polymer_elements/paper_ripple.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';

main() async {
  await initWebComponents();

  group('<paper-ripple>', () {
    CustomEvent mouseEvent;
    DivElement rippleContainer;
    PaperRipple ripple;

    group('when tapped', () {
      setUp(() async {
        rippleContainer = fixture('TrivialRipple');
        await new Future(() {});
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
      setUp(() async {
        rippleContainer = fixture('TrivialRipple');
        await new Future(() {});
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

    group('when target is noink', () {
      setUp(() async {
        rippleContainer = fixture('NoinkTarget');
        await new Future(() {});
        ripple = rippleContainer.children.first;
      });

      test('tapping does not create a ripple', () {
        expect(ripple.ripples.length, 0);
        down(ripple);
        expect(ripple.ripples.length, 0);
      });

      test('ripples can be manually created', () {
        expect(ripple.ripples.length, 0);
        ripple.simulatedRipple();
        expect(ripple.ripples.length, 1);
      });
    });

    group('with the `center` attribute set to true', () {
      setUp(() async {
        rippleContainer = fixture('CenteringRipple');
        await new Future(() {});
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
      setUp(() async {
        rippleContainer = fixture('RecenteringRipple');
        await new Future(() {});
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
          expect(waveContainerElement.style.transform, isNot(waveTranslateString));
        });
      });
    });

    suite('remove a paper ripple', () {
      setup(() {
        rippleContainer = fixture('NoRipple');
      });
      testAsync('add and remove a paper-ripple', (done) {
        PaperRipple ripple = document.createElement('paper-ripple');
        ripple.on['transitionend'].take(1).listen((_) {
          $expect(ripple.parentNode).to.be.ok;
          new PolymerDom(rippleContainer).removeChild(ripple);
          done();
        });
        new PolymerDom(rippleContainer).append(ripple);
        ripple.downAction(null);
        ripple.upAction(null);
      });

      testAsync('reuse a paper-ripple', (done) {
        PaperRipple ripple = document.createElement('paper-ripple');
        new PolymerDom(rippleContainer).append(ripple);
        new PolymerDom(rippleContainer).removeChild(ripple);

        ripple.on['transitionend'].listen((_) {
          $expect(ripple.parentNode).to.be.ok;
          new PolymerDom(document.body).removeChild(ripple);
          done();
        });
        new PolymerDom(document.body).append(ripple);
        ripple.downAction(null);
        ripple.upAction(null);
      });
    });

    suite('avoid double transitionend event', () {
      setup(() {
        rippleContainer = fixture('NoRipple');
      });
      testAsync('the transitionend event should only fire once', (done) {
        PaperRipple ripple = document.createElement('paper-ripple');
        var transitionedEventCount = 0;
        ripple.on['transitionend'].take(1).listen((_) async {
          ++transitionedEventCount;
          $expect(transitionedEventCount).to.be.eql(1);
          new PolymerDom(rippleContainer).removeChild(ripple);
          await wait(1);
          done();
        });
        new PolymerDom(rippleContainer).append(ripple);
        ripple.downAction(null);
        ripple.upAction(null);
      });
    });
  });
}

CustomEvent fakeMouseEvent(Element target, int relativeX, int relativeY) {
  var rect = target.getBoundingClientRect();
  return new CustomEvent('', detail: {'x': rect.left + relativeX, 'y': rect.top + relativeY});
}
