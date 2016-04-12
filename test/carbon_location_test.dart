// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_icon_test;

import 'dart:html';
import 'dart:js';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/carbon_location.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:async';

main() async {
  await initWebComponents();
  group('<carbon-location>', () {
    AnchorElement clickableLink;
    var carbonLocation;


    void setLocation(url) {
      window.history.pushState({}, '', url);
      fireEvent('location-changed', {}, window.document );
    }

    // iron-location listens for the click, if it matches the url space
    // configuration, then it prevents default.
    setLocationClick(url) {
      clickableLink.href= url;
      tap(clickableLink);
    }

    setUp(() {
      clickableLink = fixture('ClickableLink');
      carbonLocation = fixture('BasicLocation');
    });

    test('it automatically exposes the current route', () {
      expect(carbonLocation.route, isNotNull);
      expect(carbonLocation.route['path'], window.location.pathname);
    });

    group('manipulating the route', () {
      var originalPath;
      var originalQueryParams;

      setUp(() {
        originalPath = carbonLocation.route['path'];
        originalQueryParams = carbonLocation.route['__queryParams'];
      });

      tearDown(() {
        carbonLocation.set('route.prefix', '');
        carbonLocation.set('route.path', originalPath);
        carbonLocation.set('route.__queryParams', originalQueryParams);
      });

      test('it reflects path to location.pathname', () {
        carbonLocation.set('route.path', '/foo/bar');
        expect(window.location.pathname, '/foo/bar');
      });

      test('it reflects queryParams values to location.search', () {
        carbonLocation.set('route.__queryParams.foo', 1);
        expect(window.location.search, matches("foo=1"));
      }, skip: "blocks");

      test('it reflects completely replaced queryParams', () {
        carbonLocation.set('route.__queryParams', {"bar": 1});
        expect(window.location.search, '?bar=1');
      });

      test('it reflects the prefix to location.pathname', () {
        carbonLocation.set('route.prefix', '/fiz');
        expect(window.location.pathname, '/fiz' + originalPath);
      });
    });

    /**
     * NOTE: For a more thorough spec describing this behavior, please refer
     * to the `iron-location` component.
     */
    group('manipulating the history state', () {
      var originalLocation;

      setUp(() {
        originalLocation = window.location.toString();
      });

      tearDown(() {
        setLocation(originalLocation);
      });

      test('it reflects location.pathname to route.path', () {
        setLocation('/fiz/buz');
        expect(carbonLocation.route['path'], '/fiz/buz');
      });

      test('it reflects location.search to route.__queryParams', () {
        setLocation('?fiz=buz');
        expect(carbonLocation.route['__queryParams'], {
          'fiz': 'buz'
        });
      });
    });

    group('manipulating the urlSpace', () {
      var pageUrl;
      var originalLocation;

      setUp(() {
        pageUrl = carbonLocation.$$('iron-location');
        originalLocation = window.location.toString();
      });

      tearDown(() {
        setLocation(originalLocation);
      });

      test('changing the urlSpace pattern and testing paths', () {
        setLocationClick('/test');

        carbonLocation.urlSpaceRegex = '/foo';

        expect(carbonLocation.route['path'], '/test');

        setLocationClick('/foo');
        expect(carbonLocation.route['path'], '/foo');

        setLocationClick('/foo/bar');
        expect(carbonLocation.route['path'], '/foo/bar');

        setLocationClick('/bar');
        expect(carbonLocation.route['path'], '/foo/bar');

        carbonLocation.urlSpaceRegex = '/foo/[0-9]+';

        setLocationClick('/foo/123');
        expect(carbonLocation.route['path'], '/foo/123');

        setLocationClick('/foo/');
        expect(carbonLocation.route['path'], '/foo/123');

        setLocationClick('/foo/456');
        expect(carbonLocation.route['path'], '/foo/456');
      });
    },skip:"Not working");


    group('using the hash as the route path', () {
      var carbonLocation;
      var originalLocation;

      setUp(() {
        originalLocation = window.location.toString();
        carbonLocation = fixture('LocationViaHash');
      });

      tearDown(() {
        setLocation(originalLocation);
      });


      test('it reflects location.hash to route.path', () {
        setLocation('#/fiz/buz');
        expect(carbonLocation.route['path'], '/fiz/buz');
      });

      test('it reflects route.path to location.hash', () {
        carbonLocation.set('route.path', '/foo/bar');
        expect(window.location.hash, '#/foo/bar');
      });
    });


  });
}
