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
import 'package:polymer_elements/iron_scroll_threshold.dart';

Future flush() async {
  PolymerDom.flush();
  await PolymerRenderStatus.afterNextRender(document);
}

main() async {
  await initPolymer();



  group('basic features', () {
    IronScrollThreshold scrollThreshold;

    setUp(() {
      scrollThreshold = fixture('trivialScrollThreshold');
    });

    tearDown(() {
      scrollThreshold.clearTriggers();
      scrollThreshold.jsElement['_scrollTop'] = 0;
    });

    test('default', () {
      expect(scrollThreshold.jsElement['_defaultScrollTarget'], scrollThreshold, reason: '_defaultScrollTarget');
      expect(scrollThreshold.scrollTarget, scrollThreshold, reason: 'scrollTarget');
      expect(scrollThreshold.upperThreshold, 100, reason: 'upperThreshold');
      expect(scrollThreshold.lowerThreshold, 100, reason: 'lowerThreshold');
      expect(scrollThreshold.horizontal, false, reason: 'horizontal');
      expect(scrollThreshold.scrollTarget
                 .getComputedStyle()
                 .overflow, 'auto', reason: 'overflow');
    });

    test('upper-threshold event', when((done) async {
      await flush();
      scrollThreshold.on['upper-threshold'].take(1).listen((_) {
        expect(scrollThreshold.upperTriggered, isTrue);
        done();
      });
      expect(scrollThreshold.upperTriggered, isTrue);

      scrollThreshold.clearTriggers();
      scrollThreshold.jsElement['_scrollTop'] = scrollThreshold.jsElement['_scrollTop'] + 1;
    }));

    test('lower-threshold event', when((done) async {
      await flush();
      scrollThreshold.on['lower-threshold'].take(1).listen((_) {
        expect(scrollThreshold.lowerTriggered, isTrue);
        done();
      });
      scrollThreshold.jsElement['_scrollTop'] = scrollThreshold.scrollTarget.scrollHeight;
    }));

    test('clearTriggers', when((done) async {
      await flush();
      expect(scrollThreshold.upperTriggered, isTrue);
      scrollThreshold.clearTriggers();
      expect(scrollThreshold.upperTriggered, isFalse);
      done();
    }));

    test('checkScrollThesholds', when((done) async {
      await flush();
      scrollThreshold.jsElement['_scrollTop'] = scrollThreshold.scrollTarget.scrollHeight;

      expect(scrollThreshold.lowerTriggered, isFalse, reason: 'check assumption');
      scrollThreshold.checkScrollThesholds();
      expect(scrollThreshold.lowerTriggered, isTrue, reason: 'check triggers');
      scrollThreshold.clearTriggers();
      expect(scrollThreshold.lowerTriggered, isFalse, reason: 'reset triggers');
      done();
    }));

    test('horizontal', when((done) async {
      scrollThreshold.horizontal = true;
      await flush();
      scrollThreshold.clearTriggers();
      scrollThreshold.jsElement['_scrollLeft'] = scrollThreshold.scrollTarget.scrollWidth;

      expect(scrollThreshold.lowerTriggered, isFalse, reason: 'check assumption');
      scrollThreshold.checkScrollThesholds();
      expect(scrollThreshold.lowerTriggered, isTrue, reason: 'check lowerTriggered');
      scrollThreshold.jsElement['_scrollLeft'] = 0;
      scrollThreshold.checkScrollThesholds();
      expect(scrollThreshold.upperTriggered, isTrue, reason: 'upperTriggered');
      done();
    }));
  });

  group('document scroll', () {
    IronScrollThreshold scrollThreshold;

    setUp(() {
      scrollThreshold = fixture('trivialDocumentScrolling');
    });

    tearDown(() {
      scrollThreshold.clearTriggers();
      scrollThreshold.jsElement['_scrollTop'] = 0;
    });

    test('default', () {
      expect(scrollThreshold.scrollTarget, scrollThreshold.jsElement['_doc'], reason: 'scrollTarget');
      expect(scrollThreshold.upperThreshold, 100, reason: 'upperThreshold');
      expect(scrollThreshold.lowerThreshold, 100, reason: 'lowerThreshold');
      expect(scrollThreshold.horizontal, false, reason: 'horizontal');
    });

    test('upper-threshold event', when((done) async {
      await flush();
      scrollThreshold.on['upper-threshold'].take(1).listen((_) {
        expect(scrollThreshold.upperTriggered, isTrue);
        done();
      });
      expect(scrollThreshold.upperTriggered, isTrue);

      scrollThreshold.clearTriggers();
      scrollThreshold.jsElement['_scrollTop'] = scrollThreshold.jsElement['_scrollTop'] + 1;
    }));

    test('lower-threshold event', when((done) async {
      await flush();
      scrollThreshold.on['lower-threshold'].take(1).listen((_) {
        expect(scrollThreshold.lowerTriggered, isTrue);
        done();
      });
      scrollThreshold.jsElement['_scrollTop'] = scrollThreshold.scrollTarget.scrollHeight;
    }));

    test('clearTriggers', when((done) async {
      await flush();
      expect(scrollThreshold.upperTriggered, isTrue);
      scrollThreshold.clearTriggers();
      expect(scrollThreshold.upperTriggered, isFalse);
      done();
    }));

    test('checkScrollThesholds', when((done) async {
      await flush();
      scrollThreshold.jsElement['_scrollTop'] = scrollThreshold.scrollTarget.scrollHeight;

      expect(scrollThreshold.lowerTriggered, isFalse, reason: 'check assumption');
      scrollThreshold.checkScrollThesholds();
      expect(scrollThreshold.lowerTriggered, isTrue, reason: 'check triggers');
      scrollThreshold.clearTriggers();
      expect(scrollThreshold.lowerTriggered, isFalse, reason: 'reset triggers');
      done();
    }));


    test('horizontal', when((done) async {
      scrollThreshold.horizontal = true;
      await flush();
      scrollThreshold.clearTriggers();
      scrollThreshold.jsElement['_scrollLeft'] = scrollThreshold.scrollTarget.scrollWidth;

      expect(scrollThreshold.lowerTriggered, isFalse, reason: 'check assumption');
      scrollThreshold.checkScrollThesholds();
      expect(scrollThreshold.lowerTriggered, isTrue, reason: 'check lowerTriggered');
      scrollThreshold.jsElement['_scrollLeft'] = 0;
      scrollThreshold.checkScrollThesholds();
      expect(scrollThreshold.upperTriggered, isTrue, reason: 'upperTriggered');
      done();
    }));
  });
}
