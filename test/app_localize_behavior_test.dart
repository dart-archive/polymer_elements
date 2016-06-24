// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_localize_behavior_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'fixtures/x_translate.dart';
import 'fixtures/x_translate2.dart';
import 'fixtures/x_translate_only_imperative.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  getRequestsCache(PolymerElement elem) {
    return elem.jsElement['__localizationCache']['requests'];
  }

  getStringsCache(PolymerElement elem) {
    return elem.jsElement['__localizationCache']['messages'];
  }

  resetRequestsCache(PolymerElement elem) {
    elem.jsElement['__localizationCache']['requests'] = new JsObject.jsify({});
  }

  resetStringsCache(PolymerElement elem) {
    elem.jsElement['__localizationCache']['messages'] = new JsObject.jsify({});
  }

  suite('basic', () {
    test('can translate a basic string', () {
      XTranslate app = fixture('basic');

      $assert.equal(app.language, 'en');
      $assert.equal(app.output.text, 'hello');

      app.set('language', 'fr');
      $assert.equal(app.language, 'fr');
      $assert.equal(app.output.text, 'bonjour');

      app.set('language', 'it');
      $assert.equal(app.language, 'it');
      $assert.equal(app.output.text, 'ciao');
    });

    test('can translate a string with a parameter', () {
      XTranslate2 app = fixture('interpolated');

      $assert.equal(app.language, 'en');
      $assert.equal(app.output.text, 'my name is batman. i have 3 cats.');

      app.set('language', 'fr');
      $assert.equal(app.language, 'fr');
      $assert.equal(app.output.text, 'je m\'apelle batman. j\'ai 3 chats.');

      app.set('language', 'it');
      $assert.equal(app.language, 'it');
      $assert.equal(app.output.text, 'Io mi chiamo batman. Ho 3 gatti.');
    });

    test('can translate strings imperatively', () {
      XTranslate app1 = fixture('basic');
      XTranslate2 app2 = fixture('interpolated');

      $assert.equal(app1.language, 'en');
      $assert.equal(app2.language, 'en');
      $assert.equal(app1.localize.apply(['greeting']), 'hello');
      $assert.equal(app2.localize.apply(['intro', 'name', 'robin', 'numCats', 17]), 'my name is robin. i have 17 cats.');

      app1.set('language', 'fr');
      app2.set('language', 'fr');
      $assert.equal(app1.language, 'fr');
      $assert.equal(app2.language, 'fr');

      $assert.equal(app1.localize.apply(['greeting']), 'bonjour');
      $assert.equal(app2.localize.apply(['intro', 'name', 'robin', 'numCats', 17]), 'je m\'apelle robin. j\'ai 17 chats.');

      app1.set('language', 'it');
      app2.set('language', 'it');
      $assert.equal(app1.language, 'it');
      $assert.equal(app2.language, 'it');

      $assert.equal(app1.localize.apply(['greeting']), 'ciao');
      $assert.equal(app2.localize.apply(['intro', 'name', 'robin', 'numCats', 17]), 'Io mi chiamo robin. Ho 17 gatti.');
    });
  });

  suite('external resources', () {
    var path;

    testAsync('can translate a basic string', (done) {
      XTranslate app = fixture('basic');

      // Keep the tests independent by resetting the internal cache.
      resetRequestsCache(app);

      app.on['app-resources-loaded'].listen((_) {
        $assert.equal(app.language, 'en');
        $assert.equal(app.output.text, 'hello');

        app.set('language', 'fr');
        $assert.equal(app.language, 'fr');
        $assert.equal(app.output.text, 'bonjour');

        app.set('language', 'it');
        $assert.equal(app.language, 'it');
        $assert.equal(app.output.text, 'ciao');

        done();
      });

      String url = app.jsElement.callMethod('resolveUrl', ['locales.json']);
      app.loadResources(url);
    });

    testAsync('can translate a string with a parameter', (done) {
      XTranslate2 app = fixture('interpolated');

      // Keep the tests independent by resetting the internal cache.
      resetRequestsCache(app);

      app.on['app-resources-loaded'].listen((_) {
        $assert.equal(app.language, 'en');
        $assert.equal(app.output.text, 'my name is batman. i have 3 cats.');

        app.set('language','fr');
        $assert.equal(app.language, 'fr');
        $assert.equal(app.output.text, 'je m\'apelle batman. j\'ai 3 chats.');

        done();
      });

      app.loadResources(app.jsElement.callMethod('resolveUrl', ['locales.json']));
    });

    testAsync('can translate strings imperatively', (done) {
      XTranslate app1 = fixture('basic');
      XTranslate2 app2 = fixture('interpolated');

      // Keep the tests independent by resetting the internal cache.
      resetRequestsCache(app1);
      resetRequestsCache(app2);

      app1.on['app-resources-loaded'].listen((_) {
        $assert.equal(app1.language, 'en');
        $assert.equal(app2.language, 'en');
        $assert.equal(app1.localize.apply(['greeting']), 'hello');
        $assert.equal(app2.localize.apply(['intro', 'name', 'robin', 'numCats', 17]), 'my name is robin. i have 17 cats.');

        app1.set('language','fr');
        app2.set('language','fr');
        $assert.equal(app1.language, 'fr');
        $assert.equal(app2.language, 'fr');
        $assert.equal(app1.localize.apply(['greeting']), 'bonjour');
        $assert.equal(app2.localize.apply(['intro', 'name', 'robin', 'numCats', 17]), 'je m\'apelle robin. j\'ai 17 chats.');

        done();
      });

      app1.loadResources(app1.jsElement.callMethod('resolveUrl', ['locales.json']));
      app2.loadResources(app2.jsElement.callMethod('resolveUrl', ['locales.json']));
    });
  });

  ObjectKeys(x) => context['Object']['keys'].apply([x]);

  suite('json loading and caching', () {
    testAsync('loads the same json only file once', (done) {
      // TL;DR: this test makes sure that objects of the same type, and of
      // different types play together in the same, nice, way.
      XTranslate app1 = fixture('basic');
      XTranslate app2 = fixture('basic2'); // different type.
      XTranslate2 app3 = fixture('interpolated');
      var path = app1.jsElement.callMethod('resolveUrl', ['locales.json']);

      // Keep the tests independent by resetting the internal cache.
      resetRequestsCache(app1);
      resetRequestsCache(app2);
      resetRequestsCache(app3);

      // Nothing in the cache.
      $assert.equal(0, ObjectKeys(getRequestsCache(app1)).length);
      $assert.equal(0, ObjectKeys(getRequestsCache(app2)).length);
      $assert.equal(0, ObjectKeys(getRequestsCache(app3)).length);

      // Once the first file has been loaded, it should be the only thing in the cache.
      app1.on['app-resources-loaded'].listen((_) {
        print(getRequestsCache(app1).toString());
        $assert.equal(1, ObjectKeys(getRequestsCache(app1)).length, 'there is 1 request cached in app1');
        $assert.equal(1, ObjectKeys(getRequestsCache(app2)).length, 'there is 1 request cached in app2');
        $assert.equal(1, ObjectKeys(getRequestsCache(app3)).length, 'there is 1 request cached in app3');

        var request1 = getRequestsCache(app1)[path];
        $assert.notEqual(null, request1, 'the cached request is ok');
        $assert.equal(app1.resources['fr']['greeting'], 'bonjour');

        // Loading the second file should not make an iron-ajax request, and re-use the one in the cache.
        app2.on['app-resources-loaded'].listen((_) {
          $assert.equal(1, ObjectKeys(getRequestsCache(app1)).length, 'there is 1 request cached in app1');
          $assert.equal(1, ObjectKeys(getRequestsCache(app2)).length, 'there is 1 request cached in app2');
          $assert.equal(1, ObjectKeys(getRequestsCache(app3)).length, 'there is 1 request cached in app3');

          $assert.equal(request1, getRequestsCache(app2)[path], 'the same request is cached');
          $expect(app1.resources).eql(app2.resources);
          $assert.equal(app2.resources['fr']['greeting'], 'bonjour');

          // Loading the third file should not make an iron-ajax request, and re-use the one in the cache.
          app3.on['app-resources-loaded'].listen((_) {
            $assert.equal(1, ObjectKeys(getRequestsCache(app1)).length, 'there is 1 request cached in app1');
            $assert.equal(1, ObjectKeys(getRequestsCache(app2)).length, 'there is 1 request cached in app2');
            $assert.equal(1, ObjectKeys(getRequestsCache(app3)).length, 'there is 1 request cached in app3');

            $assert.equal(request1, getRequestsCache(app3)[path], 'the same request is cached');
            $expect(app1.resources).eql(app2.resources);
            $expect(app1.resources).eql(app3.resources);
            $assert.equal(app2.resources['fr']['greeting'], 'bonjour');

            done();
          });
          app3.loadResources(path);
        });
        app2.loadResources(path);
      });
      app1.loadResources(path);
    });

    testAsync('can load different json files', (done) {
      XTranslate app1 = fixture('basic');
      XTranslate2 app2 = fixture('interpolated');

      // Keep the tests independent by resetting the internal cache.
      resetRequestsCache(app1);
      resetRequestsCache(app2);

      // Nothing in the cache.
      $assert.equal(0, ObjectKeys(getRequestsCache(app1)).length);
      $assert.equal(0, ObjectKeys(getRequestsCache(app2)).length);

      var path1 = app1.jsElement.callMethod('resolveUrl', ['locales.json']);
      var path2 = app1.jsElement.callMethod('resolveUrl', ['locales2.json']);

      // Once the first file has been loaded, it should be the only thing in the cache.
      app1.on['app-resources-loaded'].listen((_) {
        $assert.equal(1, ObjectKeys(getRequestsCache(app1)).length, 'there is 1 request cached in app1');
        $assert.equal(1, ObjectKeys(getRequestsCache(app2)).length, 'there is 1 request cached in app2');

        var request1 = getRequestsCache(app1)[path1];
        $assert.notEqual(null, request1, 'the cached request is ok');
        $assert.equal(app1.resources['fr']['greeting'], 'bonjour');

        // Loading a different file should make a different ajax request.
        app2.on['app-resources-loaded'].listen((_) {
          $assert.equal(2, ObjectKeys(getRequestsCache(app1)).length, 'there are 2 requests cached in app1');
          $assert.equal(2, ObjectKeys(getRequestsCache(app2)).length, 'there are 2 requests cached in app2');

          var request2 = getRequestsCache(app2)[path2];
          $assert.notEqual(request1, request2, 'the cached requests are different');
          $expect(app1.resources).to.not.eql(app2.resources, 'the apps don\'t have the same resources');
          $assert.equal(app2.resources['fr']['greeting'], 'bonjour!');

          done();
        });
        app2.loadResources(app2.jsElement.callMethod('resolveUrl', [path2]));
      });
      app1.loadResources(app1.jsElement.callMethod('resolveUrl', [path1]));
    });
  });

  suite('localized string caching', () {
    test('constructs the same string only once', () {
      XTranslateOnlyImperative app = fixture('only-imperative');

      // Keep the tests independent by resetting the internal cache.
      resetStringsCache(app);

      // Translating one string should add it to the cache.
      $assert.equal(app.localize.apply(['greeting']), 'hello');
      $assert.equal(1, ObjectKeys(getStringsCache(app)).length, 'there is 1 string cached');
      var cachedString = getStringsCache(app)['greetinghello'];
      $assert.isNotNull(cachedString, 'cached string has an object');

      // Translating the same string again should re-use it from the cache.
      $assert.equal(app.localize.apply(['greeting']), 'hello');
      $assert.equal(1, ObjectKeys(getStringsCache(app)).length, 'there is still 1 string cached');
      $assert.equal(cachedString, getStringsCache(app)['greetinghello'], 'cached string is the same');

      // Changing the language should reset the cache.
      app.set('language','fr');
      $assert.equal(0, ObjectKeys(getStringsCache(app)).length, 'the cache is empty');

      // But translating a new string will re-add it to the cache.
      $assert.equal(app.localize.apply(['greeting']), 'bonjour');
      $assert.equal(1, ObjectKeys(getStringsCache(app)).length, 'there is 1 string cached');
      var newCachedString = getStringsCache(app)['greetinghello'];
      $assert.notEqual(cachedString, newCachedString, 'cached string is different than before');
    });
  });
}
