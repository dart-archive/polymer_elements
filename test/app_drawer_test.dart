// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_fab_basic_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/app_layout/app_drawer/app_drawer.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();


  suite('basic features', () {
    AppDrawer drawer;
    var scrim, contentContainer;
    sinon.Spy transformSpy;

    fireKeydownEvent(Node target, keyCode, [shiftKey]) {
      var e = new CustomEvent('keydown', canBubble: true, cancelable: true);
      new JsObject.fromBrowserObject(e)['keyCode'] = keyCode;
      new JsObject.fromBrowserObject(e)['shiftKey'] = shiftKey == null ? false : shiftKey;
      target.dispatchEvent(e);
      return e;
    }

    assertDrawerStyles(num translateX, opacity, desc) {
      $assert.equal(transformSpy.lastCall.args[0], 'translate3d(${translateX.floor()}px,0,0)', desc);
      $assert.equal(parseFloat(scrim.style.opacity), opacity, desc);
    }

    assertDrawerStylesReset() {
      $assert.equal(scrim.style.opacity, '');
      $assert.equal(transformSpy.lastCall.args[0], '');
    }

    assertTransitionDuration(duration) {
      $assert.equal(contentContainer.style.transitionDuration, duration);
      $assert.equal(scrim.style.transitionDuration, duration);
    }

    assertTransitionDurationAbove(d) {
      $assert.isAbove(parseFloat(contentContainer.style.transitionDuration), d);
      $assert.isAbove(parseFloat(scrim.style.transitionDuration), d);
    }

    assertTransitionTimingFunction(timingFunction) {
      $assert.equal(contentContainer.style.transitionTimingFunction, timingFunction);
      $assert.equal(scrim.style.transitionTimingFunction, timingFunction);
    }

    setup(() {
      drawer = fixture('testDrawer');
      scrim = drawer.$['scrim'];
      contentContainer = drawer.$['contentContainer'];
      transformSpy = sinon.spy(drawer.jsElement, 'transform');



      // Document p;


    });

    setUpAll(showTestRunnerFrame);

    tearDownAll(hideTestRunnerFrame);

    test('default values', () {
      $assert.isFalse(drawer.opened);
      $assert.isFalse(drawer.persistent);
      $assert.equal(drawer.align, 'left');
      $assert.isFalse(drawer.swipeOpen);
      $assert.isFalse(drawer.noFocusTrap);
    });

    test('set scroll direction', () {
      $assert.equal(drawer.jsElement['__polymerGesturesTouchAction'], 'pan-y');
    });

    testAsync('transitions are enabled after attached', (done) async {
      assertTransitionDuration('0s');

      await wait(350);
      assertTransitionDuration('');
      done();
    });

    test('computed position', () {
      AppDrawer rtlDrawer = fixture('rtlDrawer');
      rtlDrawer.align = 'start';

      $assert.equal(drawer.position, 'left');

      drawer.align = 'end';

      $assert.equal(drawer.position, 'right');

      drawer.align = 'left';

      $assert.equal(drawer.position, 'left');

      drawer.align = 'right';

      $assert.equal(drawer.position, 'right');
    });

    test('computed position for RTL', () {
      AppDrawer rtlDrawer = fixture('rtlDrawer');
      rtlDrawer.align = 'start';

      $assert.equal(rtlDrawer.position, 'right');

      rtlDrawer.align = 'end';

      $assert.equal(rtlDrawer.position, 'left');

      rtlDrawer.align = 'right';

      $assert.equal(rtlDrawer.position, 'right');

      rtlDrawer.align = 'left';

      $assert.equal(rtlDrawer.position, 'left');
    });

    test('left drawer opens and closes', () {
      drawer.align = 'left';

      var contentContainerClientRect = contentContainer.getBoundingClientRect();
      $assert.isTrue(contentContainerClientRect.right <= 0);

      drawer.opened = true;

      contentContainerClientRect = contentContainer.getBoundingClientRect();
      $assert.equal(contentContainerClientRect.left, 0);

      drawer.opened = false;

      contentContainerClientRect = contentContainer.getBoundingClientRect();
      $assert.isTrue(contentContainerClientRect.right <= 0);
    });

    test('right drawer opens and closes', () {
      drawer.align = 'right';

      var contentContainerClientRect = contentContainer.getBoundingClientRect();
      $assert.isTrue(contentContainerClientRect.left >= window.innerWidth);

      drawer.opened = true;

      contentContainerClientRect = contentContainer.getBoundingClientRect();
      $assert.equal(contentContainerClientRect.right, window.innerWidth);

      drawer.opened = false;

      contentContainerClientRect = contentContainer.getBoundingClientRect();
      $assert.isTrue(contentContainerClientRect.left >= window.innerWidth);
    });

    test('open(), close(), and toggle()', () {
      $assert.isFalse(drawer.opened);

      drawer.open();

      $assert.isTrue(drawer.opened);

      drawer.close();

      $assert.isFalse(drawer.opened);

      drawer.toggle();

      $assert.isTrue(drawer.opened);

      drawer.toggle();

      $assert.isFalse(drawer.opened);
    });

    test('getWidth()', () {
      $assert.equal(drawer.getWidth(), contentContainer.offsetWidth);
    });

    testAsync('app-drawer-reset-layout', (done) async {
      sinon.DartSpyEventHandler listenerSpy = new sinon.DartSpyEventHandler.on(drawer, 'app-drawer-reset-layout');

      drawer.align = 'right';

      await wait(1);
      $assert.isTrue(listenerSpy.called);
      done();
    });

    testAsync('app-drawer-transitioned', (done) async {
      await wait(100);
      sinon.DartSpyEventHandler listenerSpy = new sinon.DartSpyEventHandler.on(drawer, 'app-drawer-transitioned');
      drawer.persistent = true;

      $assert.isFalse(listenerSpy.called, 'should not fire after toggling persistent when closed');

      drawer.opened = true;

      await wait(350);
      $assert.equal(listenerSpy.callCount, 1, 'should fire after toggling opened state');

      drawer.persistent = false;

      await wait(350);
      $assert.equal(listenerSpy.callCount, 2, 'should fire after toggling persistent when opened');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': -200, 'ddx': -200});

      await wait(350);
      $assert.isFalse(drawer.opened);
      $assert.equal(listenerSpy.callCount, 3, 'should fire after flinging');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 10, 'ddx': 10});
      drawer.fire('track', detail: {'state': 'end', 'dx': 10, 'ddx': 0});

      await wait(350);
      $assert.isFalse(drawer.opened);
      $assert.equal(listenerSpy.callCount, 4, 'should fire after swiping even if opened state unchanged');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 200, 'ddx': 200});
      drawer.fire('track', detail: {'state': 'end', 'dx': 200, 'ddx': 0});

      await wait(350);
      $assert.isTrue(drawer.opened);
      $assert.equal(listenerSpy.callCount, 5, 'should fire after swiping');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': -1000, 'ddx': -1000});
      drawer.fire('track', detail: {'state': 'end', 'dx': -1000, 'ddx': 0});

      await wait(350);
      $assert.isFalse(drawer.opened);
      $assert.equal(listenerSpy.callCount, 6, 'should fire after swiping beyond end state');
      done();
    });

    testAsync('track events block user selection', (done) async {
      await wait(350);
      var ev = drawer.fire('track', cancelable: true);

      $assert.isTrue(ev.defaultPrevented);
      done();
    });

    testAsync('styles reset after swiping', (done) async {
      await wait(350);
      drawer.fire('track', detail: {'state': 'start'});

      $assert.equal(drawer.style.visibility, 'visible');
      assertTransitionDuration('0s');

      drawer.fire('track', detail: {'state': 'track', 'dx': 200, 'ddx': 200});
      drawer.fire('track', detail: {'state': 'end', 'dx': 200, 'ddx': 0});

      $assert.equal(drawer.style.visibility, '');
      assertTransitionDuration('');
      assertDrawerStylesReset();
      done();
    });

    testAsync('styles reset after swiping beyond the end state', (done) async {
      await wait(350);
      drawer.fire('track', detail: {'state': 'start'});

      $assert.equal(drawer.style.visibility, 'visible');
      assertTransitionDuration('0s');

      drawer.fire('track', detail: {'state': 'track', 'dx': 1000, 'ddx': 1000});
      drawer.fire('track', detail: {'state': 'end', 'dx': 1000, 'ddx': 0});

      $assert.equal(drawer.style.visibility, '');
      assertTransitionDuration('');
      assertDrawerStylesReset();
      done();
    });

    testAsync('left drawer swiping', (done) async {
      await wait(350);
      var drawerWidth = drawer.getWidth();
      var halfWidth = drawerWidth / 2;
      drawer.align = 'left';
      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': -halfWidth, 'ddx': -halfWidth});

      assertDrawerStyles(-drawerWidth, 0, 'styles are lower bounded');

      drawer.fire('track', detail: {'state': 'track', 'dx': halfWidth, 'ddx': drawerWidth});

      assertDrawerStyles(-halfWidth, 0.5, 'style by track distance');

      drawer.fire('track', detail: {'state': 'track', 'dx': halfWidth + drawerWidth, 'ddx': drawerWidth});

      assertDrawerStyles(0, 1, 'styles are upper bounded');

      // Simulate break of track events.
      drawer.jsElement['_trackDetails'] = new JsArray.from([]);
      drawer.fire('track', detail: {'state': 'end', 'dx': halfWidth, 'ddx': -drawerWidth});

      $assert.isFalse(drawer.opened, 'drawer stays closed when track distance is small');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': halfWidth + 1, 'ddx': halfWidth + 1});
      drawer.fire('track', detail: {'state': 'end', 'dx': halfWidth + 1, 'ddx': 0});

      $assert.isTrue(drawer.opened, 'drawer opens when track distance is large');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': -halfWidth, 'ddx': -halfWidth});
      drawer.fire('track', detail: {'state': 'end', 'dx': -halfWidth, 'ddx': 0});

      $assert.isTrue(drawer.opened, 'drawer stays opened when track distance is small');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': -halfWidth - 1, 'ddx': -halfWidth - 1});
      drawer.fire('track', detail: {'state': 'end', 'dx': -halfWidth - 1, 'ddx': 0});

      $assert.isFalse(drawer.opened, 'drawer closes when track distance is large');
      done();
    });

    testAsync('right drawer swiping', (done) async {
      await wait(350);
      var drawerWidth = drawer.getWidth();
      var halfWidth = drawerWidth / 2;
      drawer.align = 'right';
      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': halfWidth, 'ddx': halfWidth});

      assertDrawerStyles(drawerWidth, 0, 'styles are lower bounded');

      drawer.fire('track', detail: {'state': 'track', 'dx': -halfWidth, 'ddx': -drawerWidth});

      assertDrawerStyles(halfWidth, 0.5, 'style by track distance');

      drawer.fire('track', detail: {'state': 'track', 'dx': -halfWidth - drawerWidth, 'ddx': -drawerWidth});

      assertDrawerStyles(0, 1, 'styles are upper bounded');

      // Simulate break of track events.
      drawer.jsElement['_trackDetails'] = new JsArray();
      drawer.fire('track', detail: {'state': 'end', 'dx': -halfWidth, 'ddx': drawerWidth});

      $assert.isFalse(drawer.opened, 'drawer stays closed when track distance is small');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': -halfWidth - 1, 'ddx': -halfWidth - 1});
      drawer.fire('track', detail: {'state': 'end', 'dx': -halfWidth - 1, 'ddx': 0});

      $assert.isTrue(drawer.opened, 'drawer opens when track distance is large');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': halfWidth, 'ddx': halfWidth});
      drawer.fire('track', detail: {'state': 'end', 'dx': halfWidth, 'ddx': 0});

      $assert.isTrue(drawer.opened, 'drawer stays opened when track distance is small');

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': halfWidth + 1, 'ddx': halfWidth + 1});
      drawer.fire('track', detail: {'state': 'end', 'dx': halfWidth + 1, 'ddx': 0});

      $assert.isFalse(drawer.opened, 'drawer closes when track distance is large');
      done();
    });

    testAsync('styles reset after flinging', (done) async {
      await wait(350);
      drawer.fire('track', detail: {'state': 'start'});

      $assert.equal(drawer.style.visibility, 'visible');
      assertTransitionDuration('0s');

      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': 200, 'ddx': 200});

      await wait(350);
      $assert.equal(drawer.style.visibility, '');
      assertTransitionDuration('');
      assertTransitionTimingFunction('');
      assertDrawerStylesReset();
      done();
    });

    testAsync('styles reset after flinging beyond the end state', (done) async {
      await wait(350);
      drawer.fire('track', detail: {'state': 'start'});

      $assert.equal(drawer.style.visibility, 'visible');
      assertTransitionDuration('0s');

      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': 1000, 'ddx': 1000});

      $assert.equal(drawer.style.visibility, '');
      assertTransitionDuration('');
      assertTransitionTimingFunction('');
      assertDrawerStylesReset();
      done();
    });

    testAsync('left drawer flinging open', (done) async {
      await wait(350);
      drawer.align = 'left';
      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': 0.1, 'ddx': 0.1});

      $assert.isFalse(drawer.opened, 'drawer stays closed when velocity is small');
      assertTransitionDuration('');
      assertTransitionTimingFunction('');
      assertDrawerStylesReset();

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': 6, 'ddx': 6});

      $assert.isTrue(drawer.opened, 'drawer opens when velocity is large');
      assertTransitionDurationAbove(60);
      assertTransitionTimingFunction(drawer.jsElement['_FLING_TIMING_FUNCTION']);
      assertDrawerStylesReset();
      done();
    });

    testAsync('left drawer flinging close', (done) async {
      await wait(350);
      drawer.align = 'left';
      drawer.opened = true;
      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': -0.1, 'ddx': -0.1});

      $assert.isTrue(drawer.opened, 'drawer stays opened when velocity is small');
      assertTransitionDuration('');
      assertTransitionTimingFunction('');
      assertDrawerStylesReset();

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': -6, 'ddx': -6});

      $assert.isFalse(drawer.opened, 'drawer closes when velocity is large');
      assertTransitionDurationAbove(60);
      assertTransitionTimingFunction(drawer.jsElement['_FLING_TIMING_FUNCTION']);
      assertDrawerStylesReset();
      done();
    });

    testAsync('right drawer flinging open', (done) async {
      await wait(350);
      drawer.align = 'right';
      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': -0.1, 'ddx': -0.1});

      $assert.isFalse(drawer.opened, 'drawer stays closed when velocity is small');
      assertTransitionDuration('');
      assertTransitionTimingFunction('');
      assertDrawerStylesReset();

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': -6, 'ddx': -6});

      $assert.isTrue(drawer.opened, 'drawer opens when velocity is large');
      assertTransitionDurationAbove(60);
      assertTransitionTimingFunction(drawer.jsElement['_FLING_TIMING_FUNCTION']);
      assertDrawerStylesReset();
      done();
    });

    testAsync('right drawer flinging close', (done) async {
      await wait(350);
      drawer.align = 'right';
      drawer.opened = true;
      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': 0.1, 'ddx': 0.1});

      $assert.isTrue(drawer.opened, 'drawer stays opened when velocity is small');
      assertTransitionDuration('');
      assertTransitionTimingFunction('');
      assertDrawerStylesReset();

      drawer.fire('track', detail: {'state': 'start'});
      drawer.fire('track', detail: {'state': 'track', 'dx': 0, 'ddx': 0});
      drawer.fire('track', detail: {'state': 'end', 'dx': 6, 'ddx': 6});

      $assert.isFalse(drawer.opened, 'drawer closes when velocity is large');
      assertTransitionDurationAbove(60);
      assertTransitionTimingFunction(drawer.jsElement['_FLING_TIMING_FUNCTION']);
      assertDrawerStylesReset();
      done();
    });

    testAsync('doc scroll', (done) async {
      await wait(100);
      drawer.opened = true;

      await wait(350);
      $assert.equal(document.body.style.overflow, 'hidden', 'should block scrolling when opened');

      drawer.persistent = true;

      await wait(350);
      $assert.equal(document.body.style.overflow, '', 'should not block scrolling when persistent');

      drawer.persistent = false;

      await wait(350);
      $assert.equal(document.body.style.overflow, 'hidden', 'should block scrolling when not persistent');

      drawer.opened = false;

      await wait(350);
      $assert.equal(document.body.style.overflow, '', 'should not block scrolling when closed');
      done();
    });

    testAsync('focus trap', (done) async {
      var focusDrawer = fixture('focusDrawer');
      var root = Polymer.dom(focusDrawer.root);
      var drawer = root.querySelector('app-drawer');
      InputElement input = Polymer.dom(drawer).querySelector('input');
      DivElement div = Polymer.dom(drawer).querySelector('div[tabindex]');
      var inputFocusSpy = sinon.spy(new JsObject.fromBrowserObject(input), 'focus');
      var divFocusSpy = sinon.spy(new JsObject.fromBrowserObject(div), 'focus');
      drawer.opened = true;

      await wait(350);
      $assert.isTrue(inputFocusSpy.called);

      var e = fireKeydownEvent(input, 9);

      $assert.isFalse(e.defaultPrevented, 'should not prevent default');

      input.focus();
      inputFocusSpy.reset();
      e = fireKeydownEvent(input, 9, true /* shiftKey */);

      $assert.isTrue(divFocusSpy.called);
      $assert.isTrue(e.defaultPrevented, 'should prevent default');

      e = fireKeydownEvent(div, 9, true /* shiftKey */);

      $assert.isFalse(e.defaultPrevented, 'should not prevent default');

      div.focus();
      e = fireKeydownEvent(div, 9);

      $assert.isTrue(inputFocusSpy.called);
      $assert.isTrue(e.defaultPrevented, 'should prevent default');
      done();
    });

    testAsync('focus trap with app-drawer tabindex set', (done) async {
      var focusDrawer = fixture('focusDrawer');
      var root = Polymer.dom(focusDrawer.root);
      AppDrawer drawer = root.querySelector('app-drawer');
      InputElement input = Polymer.dom(drawer).querySelector('input');
      var drawerFocusSpy = sinon.spy(drawer.jsElement, 'focus');
      var inputFocusSpy = sinon.spy(new JsObject.fromBrowserObject(input), 'focus');
      drawer.tabIndex = 0;
      drawer.opened = true;

      await wait(350);
      $assert.isTrue(drawerFocusSpy.called);
      $assert.isFalse(inputFocusSpy.called);
      done();
    });

    testAsync('no focus trap', (done) async {
      var focusDrawer = fixture('focusDrawer');
      var root = Polymer.dom(focusDrawer.root);
      var drawer = root.querySelector('app-drawer');
      InputElement input = Polymer.dom(drawer).querySelector('input');
      var inputFocusSpy = sinon.spy(new JsObject.fromBrowserObject(input), 'focus');
      drawer.noFocusTrap = true;
      drawer.opened = true;

      await wait(350);
      $assert.isFalse(inputFocusSpy.called);
      done();
    });

    testAsync('esc key handler', (done) async {
      drawer.opened = true;

      await wait(350);
      var e = fireKeydownEvent(document, 27);

      $assert.isFalse(drawer.opened, 'should close drawer on esc');
      $assert.isTrue(e.defaultPrevented, 'should prevent default');
      done();
    });

    test('scrim', () {
      scrim.style.transitionDuration = '0s';

      $assert.equal(scrim.getComputedStyle().opacity, '0');

      drawer.opened = true;

      $assert.equal(scrim.getComputedStyle().opacity, '1');

      drawer.persistent = true;

      $assert.equal(scrim.getComputedStyle().visibility, 'hidden');
    });

    test('tap on scrim closes drawer', () {
      drawer.opened = true;
      drawer.fire('tap', node: scrim);

      $assert.isFalse(drawer.opened);
    });

    test('persistent drawer should not cover content', () {
      drawer.opened = true;
      drawer.persistent = true;

      $assert.notEqual(document.elementFromPoint(400, 10).tagName, 'APP-DRAWER');
    },skip:'test runner window is too small');

    test('right persistent drawer should be in the correct position', () {
      drawer.align = 'right';
      drawer.opened = true;
      drawer.persistent = true;

      $assert.equal(drawer.getBoundingClientRect().right, window.innerWidth);
    });
  });
}

@PolymerRegister('focus-drawer')
class FocusDrawer extends PolymerElement {
  FocusDrawer.created() : super.created();
}
