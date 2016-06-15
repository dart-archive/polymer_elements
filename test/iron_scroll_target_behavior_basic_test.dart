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
import 'fixtures/x_scrollable.dart';
import 'fixtures/x_nested_scrollable.dart';

Future flush() async {
  PolymerDom.flush();
  await PolymerRenderStatus.afterNextRender(document);
}

main() async {
  await initPolymer();


  group('basic features', () {
    DivElement scrollingRegion;
    XScrollable xScroll;

    setUp(() {
      scrollingRegion = fixture('trivialScrollable');
      xScroll = Polymer.dom(scrollingRegion).querySelector('x-scrollable');
    });

    test('default', () {
      expect(xScroll.jsElement['_scrollTop'], 0, reason: '_scrollTop');
      expect(xScroll.jsElement['_scrollLeft'], 0, reason: '_scrollLeft');
      expect(xScroll.jsElement['_scrollTargetWidth'], 0, reason: '_scrollTargetWidth');
      expect(xScroll.jsElement['_scrollTargetHeight'], 0, reason: '_scrollTargetHeight');
      expect(xScroll.jsElement['scrollTarget'], null, reason: 'scrollTarget');
      expect(xScroll.jsElement['_defaultScrollTarget'], xScroll.scrollTarget, reason: '_defaultScrollTarget');
    });

    test('invalid `scrollTarget` selector', when((done) async {
      await flush();
      xScroll.scrollTarget = 'invalid-id';
      expect(xScroll.scrollTarget, null);
      done();
    }));

    test('valid `scrollTarget` selector', when((done) async {
      await flush();
      xScroll.scrollTarget = 'temporaryScrollingRegion';
      expect(xScroll.scrollTarget, scrollingRegion);
      done();
    }));
  });


  group('scrolling region', () {
    DivElement scrollingRegion;
    XScrollable xScrollable;

    setUp(() {
      scrollingRegion = fixture('trivialScrollingRegion');
      xScrollable = Polymer.dom(scrollingRegion).querySelector('x-scrollable');
    });

    tearDown(() {
      xScrollable.jsElement['_scrollTop'] = 0;
      xScrollable.jsElement['_scrollLeft'] = 0;
    });

    test('scrollTarget reference', when((done) async {
      await flush();
      expect(xScrollable.scrollTarget, scrollingRegion);
      done();
    }));

    test('invalid scrollTarget', when((done) async {
      await flush();
      expect(xScrollable.scrollTarget, scrollingRegion);
      done();
    }));

    test('setters', when((done) async {
      await flush();
      xScrollable.jsElement['_scrollTop'] = 100;
      xScrollable.jsElement['_scrollLeft'] = 100;

      expect(scrollingRegion.scrollTop, 100);
      expect(scrollingRegion.scrollLeft, 100);

      done();
    }));

    test('getters', when((done) async {
      await flush();
      scrollingRegion.scrollTop = 50;
      scrollingRegion.scrollLeft = 50;

      expect(xScrollable.jsElement['_scrollTop'], 50, reason: '_scrollTop');
      expect(xScrollable.jsElement['_scrollLeft'], 50, reason: '_scrollLeft');
      expect(xScrollable.jsElement['_scrollTargetWidth'], scrollingRegion.offsetWidth, reason: '_scrollTargetWidth');
      expect(xScrollable.jsElement['_scrollTargetHeight'], scrollingRegion.offsetHeight, reason: '_scrollTargetHeight');

      done();
    }));

    test('scroll method', when((done) async {
      await flush();
      xScrollable.scroll(110, 110);

      expect(xScrollable.jsElement['_scrollTop'], 110);
      expect(xScrollable.jsElement['_scrollLeft'], 110);

      xScrollable.scroll(0, 0);

      expect(xScrollable.jsElement['_scrollTop'], 0);
      expect(xScrollable.jsElement['_scrollLeft'], 0);

      done();
    }));
  });

  group('document scroll', () {
    XScrollable xScrollable;

    setUp(() {
      xScrollable = fixture('trivialDocumentScroll');
    });

    tearDown(() {
      xScrollable.jsElement['_scrollTop'] = 0;
      xScrollable.jsElement['_scrollLeft'] = 0;
    });

    test('scrollTarget reference', when((done) async {
      await flush();
      expect(xScrollable.scrollTarget, document.documentElement);
      done();
    }));

    test('setters', when((done) async {
      await flush();
      xScrollable.jsElement['_scrollTop'] = 100;
      xScrollable.jsElement['_scrollLeft'] = 100;

      expect(window.pageXOffset, 100);
      expect(window.pageYOffset, 100);

      done();
    }));

    test('getters', when((done) async {
      await flush();
      window.scrollTo(50, 50);

      expect(xScrollable.jsElement['_scrollTop'], 50, reason: '_scrollTop');
      expect(xScrollable.jsElement['_scrollLeft'], 50, reason: '_scrollLeft');
      expect(xScrollable.jsElement['_scrollTargetWidth'], window.innerWidth, reason: '_scrollTargetWidth');
      expect(xScrollable.jsElement['_scrollTargetHeight'], window.innerHeight, reason: '_scrollTargetHeight');

      done();
    }));

    test('scroll method', when((done) async {
      await flush();

      xScrollable.scroll(1, 2);

      expect(xScrollable.jsElement['_scrollLeft'], 1);
      expect(xScrollable.jsElement['_scrollTop'], 2);

      xScrollable.scroll(3, 4);

      expect(xScrollable.jsElement['_scrollLeft'], 3);
      expect(xScrollable.jsElement['_scrollTop'], 4);

      done();
    }));
  });

  group('nested scrolling region', () {
    DivElement xScrollingRegion;
    XScrollable xScrollable;

    setUp(() {
      XNestedScrollable nestedScrollingRegion = fixture('trivialNestedScrollingRegion');
      xScrollable = nestedScrollingRegion.$['xScrollable'];
      xScrollingRegion = nestedScrollingRegion.$['xRegion'];
    });

    tearDown(() {
      xScrollable.jsElement['_scrollTop'] = 0;
      xScrollable.jsElement['_scrollLeft'] = 0;
    });

    test('scrollTarget reference', when((done) async {
      await flush();
      expect(xScrollable.scrollTarget, xScrollingRegion);
      done();
    }));

    test('setters', when((done) async {
      await flush();
      xScrollable.jsElement['_scrollTop'] = 10;
      xScrollable.jsElement['_scrollLeft'] = 20;

      expect(xScrollingRegion.scrollTop, 10);
      expect(xScrollingRegion.scrollLeft, 20);

      done();
    }));

    test('getters', when((done) async {
      await flush();
      xScrollable.jsElement['_scrollTop'] = 10;
      xScrollable.jsElement['_scrollLeft'] = 20;

      expect(xScrollable.jsElement['_scrollTop'], 10, reason: '_scrollTop');
      expect(xScrollable.jsElement['_scrollLeft'], 20, reason: '_scrollLeft');

      done();
    }));

    test('scroll method', when((done) async {
      await flush();

      xScrollable.scroll(1, 2);

      expect(xScrollable.jsElement['_scrollLeft'], 1);
      expect(xScrollable.jsElement['_scrollTop'], 2);

      xScrollable.scroll(3, 4);

      expect(xScrollable.jsElement['_scrollLeft'], 3);
      expect(xScrollable.jsElement['_scrollTop'], 4);

      done();
    }));
  });
}
