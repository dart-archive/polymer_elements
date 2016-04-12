// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_icon_test;

import 'dart:html';
import 'dart:js';
// ignore: UNUSED_IMPORT
import 'package:polymer_elements/carbon_route.dart';
// ignore: UNUSED_IMPORT
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:async';
import 'dart:convert';
// ignore: UNUSED_IMPORT
import 'fixtures/chained_routes.dart';

Map asMap(JsObject x) => JSON.decode(context["JSON"].callMethod("stringify",[x]))??{};


main() async {
  await initPolymer();

  group('<carbon-route>', () {
    ChangedRouteTest chainedRoutes = fixture('ChainedRoutes');


    ChangedRouteTest fixtureChainedRoutes(route) {
      chainedRoutes.set('numberOneTopRoute', {
        'path': route['path'] ?? '',
        'prefix': route['prefix'] ?? '',
        '__queryParams': route['__queryParams'] ?? {}
      });

      return chainedRoutes;
    };


    CarbonRoute route;

    setUp(() {
      route = fixture('BasicRoute');

      // This works around a bug in `dom-template` that is somehow
      // exaserbated by the `carbon-route` implementation. A reduced test case
      // is hard to come by. Track polymerelements/test-fixture#31 and remove
      // this when that has been resolved:

      // @dam0vm3nt: how we do this in Dart test suite ? is it needed ?
      // var tmpl = document.querySelector('#ChainedRoutes').fixtureTemplates[0];
      // tmpl._parentProps = {};
    });

    test('it parses a path', () {
      route.route = {
        'prefix': '',
        'path': '/user/papyrus/details',
        '__queryParams': {}
      };

      expect(route.tail['prefix'], '/user/papyrus');
      expect(route.tail['path'], '/details');
      expect(route.data['username'], 'papyrus');
    });

    test('it bidirectionally maps changes between tail and route', () {
      route.route = {
        'prefix': '',
        'path': '/user/papyrus/details',
        '__queryParams': {}
      };

      route.set('tail.path', '/messages');
      expect(route.route['path'], '/user/papyrus/messages');
      route.set('route.path', '/user/toriel');
      expect(asMap(route.tail), {
        'prefix': '/user/toriel',
        'path': '',
        '__queryParams': {}
      });
    });


    test('it creates data as described by pattern', () {
      route.route = {
        'prefix' : '',
        'path': '/user/sans'
      };

      expect(asMap(route.data), {'username': 'sans'});
      expect(route.active, true);

      route.pattern = '/user/:username/likes/:count';

      // At the moment, we don't reset data when we no longer match.
      expect(asMap(route.data), {'username': 'sans'});
      expect(route.active, false);

      route.set('route.path', "/does/not/match");

      expect(asMap(route.data), {'username': 'sans'});
      expect(route.active, false);

      route.set('route.path', '/user/undyne/likes/20');
      expect(asMap(route.data), {'username': 'undyne', 'count': '20'});
      expect(route.active, true);
    });


    test('changing data changes the path', () {
      route.route = {
        'prefix': '',
        'path': '/user/asgore'
      };

      expect(asMap(route.data), {'username': 'asgore'});
      route.data = {'username': 'toriel'};
      expect(route.route['path'], '/user/toriel');
    });


    group('propagating data', () {
      test('data is empty if no routes in the tree have matched', () {
        var routes = fixtureChainedRoutes({ 'path': ''});

        expect(asMap(routes.foo.data), {});
        expect(asMap(routes.bar.data), {});
        expect(asMap(routes.baz.data), {});
      });

      test('limits propagation to last matched route', () {
        var routes = fixtureChainedRoutes({ 'path': '/foo/123'});

        expect(asMap(routes.foo.data), { 'foo': '123'});
        expect(asMap(routes.bar.data), {});
        expect(asMap(routes.baz.data), {});
      });

      test('propagates data to matching chained routes', () {
        var routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc'});

        expect(asMap(routes.foo.data), { 'foo': '123'});
        expect(asMap(routes.bar.data), { 'bar': 'abc'});
        expect(asMap(routes.baz.data), {});
      });

      test('chained route state is untouched when deactivated', () {
        var routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc'});

        routes.foo.set('route.path', '/foo/321/baz/zyx');

        expect(asMap(routes.foo.data), { 'foo': '321'});
        expect(asMap(routes.bar.data), { 'bar': 'abc'});
        expect(asMap(routes.baz.data), { 'baz': 'zyx'});
      });

      group('updating the global path', () {
        test('happens when data changes if the route is active', () {
          ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc'});

          expect(routes.bar.active, true);
          routes.bar.set('data.bar', 'cba');
          expect(routes.foo.route['path'], '/foo/123/bar/cba');
        });

        test('ignores changes when the route is inactive', () {
          ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc'});

          expect(routes.baz.active, false);
          routes.baz.set('data.baz', 'cba');
          expect(routes.foo.route['path'], '/foo/123/bar/abc');
        });

        test('ignores changes after a route deactives', () {
          ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc'});

          routes.foo.set('route.path', '/foo/123/baz/zyx');

          expect(routes.bar.active, false);
          expect(routes.baz.active, true);
          routes.bar.set('data.bar', 'cba');
          expect(routes.foo.route['path'], '/foo/123/baz/zyx');
        });
      });
    });


    group('propagating query params', () {
      test('query params are empty if no routes match', () {
        ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '', '__queryParams': {
          'qux': 'zot'
        }});
        expect(asMap(routes.foo.queryParams), {});
        expect(asMap(routes.bar.queryParams), {});
        expect(asMap(routes.baz.queryParams), {}); //wrong
      },skip:'Is the original test ok?');

      test('updates query params for all matched routes', () {
        ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc', '__queryParams': {
          'qux': 'zot'
        }});
        expect(asMap(routes.foo.queryParams), { 'qux': 'zot'});
        expect(asMap(routes.bar.queryParams), { 'qux': 'zot'});
        expect(asMap(routes.baz.queryParams), {}); // wrong ?
      },skip:'Is the original test ok?');

      test('retains query params after routes deactivate', () {
        ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc', '__queryParams': {
          'qux': 'zot'
        }});
        routes.foo.set('route.path', '/foo/123/baz/xyz');
        routes.foo.set('queryParams', {
          'qux': 'quux'
        });
        expect(asMap(routes.foo.queryParams), { 'qux': 'quux'});
        expect(asMap(routes.bar.queryParams), { 'qux': 'zot'});
        expect(asMap(routes.baz.queryParams), { 'qux': 'quux'});
      });

      group('updating global query params', () {
        test('happens when query params change on active routes', () {
          ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc', '__queryParams': {
            'qux': 'zot'
          }});

          routes.bar.set('queryParams', { 'qux': 'quux'});

          expect(asMap(routes.foo.queryParams), { 'qux': 'quux'});
          expect(asMap(routes.bar.queryParams), { 'qux': 'quux'});
          expect(asMap(routes.baz.queryParams), {}); // wrong
        },skip:'Is the original test ok?');

        test('updates are ignored for routes that are inactive', () {
          ChangedRouteTest routes = fixtureChainedRoutes({ 'path': '/foo/123/bar/abc', '__queryParams': {
            'qux': 'zot'
          }});

          routes.baz.set('queryParams', { 'qux': 'quux'});

          expect(asMap(routes.foo.queryParams), { 'qux': 'zot'});
          expect(asMap(routes.bar.queryParams), { 'qux': 'zot'});
          expect(asMap(routes.baz.queryParams), { 'qux': 'quux'});
        });
      });
    });


    // End main test

  });
}
