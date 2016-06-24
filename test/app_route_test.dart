// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_route_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'package:polymer_elements/app_route.dart';
// ignore: UNUSED_IMPORT
import 'fixtures/redirect_app_route.dart';


import 'fixtures/app_route_chained_routes.dart';


/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  AppChainedRoutes fixtureChainedRoutes(Map route) {
    AppChainedRoutes routes = fixture('ChainedRoutes');
    routes.set('numberOneTopRoute', {
      'path': route['path'] != null ? route['path'] : '',
      'prefix': route['prefix'] != null ? route['prefix'] : '',
      '__queryParams': route['__queryParams'] != null ? route['__queryParams'] : {}
    });

    return routes;
  }

  suite('<app-route>', () {
    AppRoute route;

    setup(() {
      route = fixture('BasicRoute');
    });

    test('it parses a path', () {
      route.route = {'prefix': '', 'path': '/user/papyrus/details', '__queryParams': {}};
      $expect(route.tail['prefix']).to.be.equal('/user/papyrus');
      $expect(route.tail['path']).to.be.equal('/details');
      $expect(route.data['username']).to.be.equal('papyrus');
    });

    test('it bidirectionally maps changes between tail and route', () {
      route.route = {'prefix': '', 'path': '/user/papyrus/details', '__queryParams': {}};

      route.set('tail.path', '/messages');
      $expect(route.route['path']).to.be.deep.equal('/user/papyrus/messages');
      route.set('route.path', '/user/toriel');
      $expect(route.tail).to.be.deep.equal({'prefix': '/user/toriel', 'path': '', '__queryParams': {}});
    });

    test('it creates data as described by pattern', () {
      route.route = {'prefix': '', 'path': '/user/sans'};

      $expect(route.data).to.be.deep.equal({'username': 'sans'});
      $expect(route.active).to.be.equal(true);

      route.pattern = '/user/:username/likes/:count';

      // At the moment, we don't reset data when we no longer match.
      $expect(route.data).to.be.deep.equal({'username': 'sans'});
      $expect(route.active).to.be.equal(false);

      route.set('route.path', "/does/not/match");

      $expect(route.data).to.be.deep.equal({'username': 'sans'});
      $expect(route.active).to.be.equal(false);

      route.set('route.path', '/user/undyne/likes/20');
      $expect(route.data).to.be.deep.equal({'username': 'undyne', 'count': '20'});
      $expect(route.active).to.be.equal(true);
    });

    test('changing data changes the path', () {
      route.route = {'prefix': '', 'path': '/user/asgore'};

      $expect(route.data).to.be.deep.equal({'username': 'asgore'});
      route.data = {'username': 'toriel'};
      $expect(route.route['path']).to.be.equal('/user/toriel');
    });

    suite('propagating data', () {
      test('data is empty if no routes in the tree have matched', () {
        var routes = fixtureChainedRoutes({'path': ''});

        $expect(routes.foo.data).to.be.eql(null);
        $expect(routes.bar.data).to.be.eql(null);
        $expect(routes.baz.data).to.be.eql(null);
      });

      test('limits propagation to last matched route', () {
        var routes = fixtureChainedRoutes({'path': '/foo/123'});

        $expect(routes.foo.data).to.be.deep.eql({'foo': '123'});
        $expect(routes.bar.data).to.be.eql(null);
        $expect(routes.baz.data).to.be.eql(null);
      });

      test('propagates data to matching chained routes', () {
        var routes = fixtureChainedRoutes({'path': '/foo/123/bar/abc'});

        $expect(routes.foo.data).to.be.deep.eql({'foo': '123'});
        $expect(routes.bar.data).to.be.deep.eql({'bar': 'abc'});
        $expect(routes.baz.data).to.be.eql(null);
      });

      test('chained route state is untouched when deactivated', () {
        var routes = fixtureChainedRoutes({'path': '/foo/123/bar/abc'});

        routes.foo.set('route.path', '/foo/321/baz/zyx');

        $expect(routes.foo.data).to.be.deep.eql({'foo': '321'});
        $expect(routes.bar.data).to.be.deep.eql({'bar': 'abc'});
        $expect(routes.baz.data).to.be.deep.eql({'baz': 'zyx'});
      });

      suite('updating the global path', () {
        test('happens when data changes if the route is active', () {
          var routes = fixtureChainedRoutes({'path': '/foo/123/bar/abc'});

          $expect(routes.bar.active).to.be.eql(true);
          routes.bar.set('data.bar', 'cba');
          $expect(routes.foo.route['path']).to.be.eql('/foo/123/bar/cba');
        });

        test('ignores changes when the route is inactive', () {
          var routes = fixtureChainedRoutes({'path': '/foo/123/bar/abc'});

          $expect(routes.baz.active).to.be.eql(false);
          routes.baz.set('data.baz', 'cba');
          $expect(routes.foo.route['path']).to.be.eql('/foo/123/bar/abc');
        });

        test('ignores changes after a route deactives', () {
          var routes = fixtureChainedRoutes({'path': '/foo/123/bar/abc'});

          routes.foo.set('route.path', '/foo/123/baz/zyx');

          $expect(routes.bar.active).to.be.eql(false);
          $expect(routes.baz.active).to.be.eql(true);
          routes.bar.set('data.bar', 'cba');
          $expect(routes.foo.route['path']).to.be.eql('/foo/123/baz/zyx');
        });
      });
    });

    suite('propagating query params', () {
      test('query params are empty if no routes match', () {
        var routes = fixtureChainedRoutes({
          'path': '',
          '__queryParams': {'qux': 'zot'}
        });
        $expect(routes.foo.queryParams).to.be.deep.eql({});
        $expect(routes.bar.queryParams).to.be.deep.eql({});
        $expect(routes.baz.queryParams).to.be.deep.eql({});
      });

      test('updates query params for all matched routes', () {
        var routes = fixtureChainedRoutes({
          'path': '/foo/123/bar/abc',
          '__queryParams': {'qux': 'zot'}
        });
        $expect(routes.foo.queryParams).to.be.deep.eql({'qux': 'zot'});
        $expect(routes.bar.queryParams).to.be.deep.eql({'qux': 'zot'});
        $expect(routes.baz.queryParams).to.be.deep.eql({});
      });

      test('retains query params after routes deactivate', () {
        var routes = fixtureChainedRoutes({
          'path': '/foo/123/bar/abc',
          '__queryParams': {'qux': 'zot'}
        });
        routes.foo.set('route.path', '/foo/123/baz/xyz');
        routes.foo.set('queryParams', {'qux': 'quux'});
        $expect(routes.foo.queryParams).to.be.deep.eql({'qux': 'quux'});
        $expect(routes.bar.queryParams).to.be.deep.eql({'qux': 'zot'});
        $expect(routes.baz.queryParams).to.be.deep.eql({'qux': 'quux'});
      });

      suite('updating global query params', () {
        test('happens when query params change on active routes', () {
          var routes = fixtureChainedRoutes({
            'path': '/foo/123/bar/abc',
            '__queryParams': {'qux': 'zot'}
          });

          routes.bar.set('queryParams', {'qux': 'quux'});

          $expect(routes.foo.queryParams).to.be.deep.eql({'qux': 'quux'});
          $expect(routes.bar.queryParams).to.be.deep.eql({'qux': 'quux'});
          $expect(routes.baz.queryParams).to.be.deep.eql({});
        });

        test('updates are ignored for routes that are inactive', () {
          var routes = fixtureChainedRoutes({
            'path': '/foo/123/bar/abc',
            '__queryParams': {'qux': 'zot'}
          });

          routes.baz.set('queryParams', {'qux': 'quux'});

          $expect(routes.foo.queryParams).to.be.deep.eql({'qux': 'zot'});
          $expect(routes.bar.queryParams).to.be.deep.eql({'qux': 'zot'});
          $expect(routes.baz.queryParams).to.be.deep.eql({'qux': 'quux'});
        });

        test('doesn\'t generate excess query-params-changed events', () {
          var routes = fixtureChainedRoutes({});
          List<AppRoute> appRoutes = [routes.foo, routes.bar, routes.baz];
          var numChanges = 0;
          for (var i = 0; i < appRoutes.length; i++) {
            appRoutes[i].on['query-params-changed'].listen((_) {
              numChanges++;
            });
          }

          // Messing with paths but not query params shouldn't generate any
          // change events.
          $expect(numChanges).to.be.equal(0);
          routes.foo.set('route.path', '/foo/123/bar/456');
          $expect(numChanges).to.be.equal(0);
          routes.foo.set('route.path', '/foo/456/baz/789');
          $expect(numChanges).to.be.equal(0);

          // Changing queryParams here should update foo and baz
          routes.foo.set('route.__queryParams', {'key': 'value'});
          $expect(numChanges).to.be.equal(2);
          // Then this should update bar
          routes.foo.set('route.path', '/foo/123/bar/456');
          $expect(numChanges).to.be.equal(3);

          // Changing back to baz shouldn't generate a change event.
          routes.foo.set('route.path', '/foo/456/baz/789');
          $expect(numChanges).to.be.equal(3);

          routes.foo.set('route.__queryParams', {});
          $expect(numChanges).to.be.equal(5);
          routes.foo.set('route.path', '/foo/123/bar/456');
          $expect(numChanges).to.be.equal(6);
        });
      });
    });

    suite('handles reentrent changes to its properties', () {
      var initialUrl;
      setup(() {
        initialUrl = window.location.href;
      });

      teardown(() {
        window.history.replaceState({}, '', initialUrl);
      });

      test('changing path in response to path changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.on['route-changed'].listen((_) {
          r.set('route.path', '/bar/baz');
        });
        r.set('route.path', '/foo');
        $expect(window.location.pathname).to.be.equal('/bar/baz');
        $expect(r.data).to.be.deep.equal({'page': 'bar'});
        $expect(r.route['path']).to.be.equal('/bar/baz');
        $expect(r.tail['path']).to.be.equal('/baz');
      });

      test('changing data wholesale in response to path changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.set('data.page', 'bar');
        r.on['route-changed'].listen((e) {
          if (e.detail['path'] == 'route.path' && r.route['path'] == '/foo/baz') {
            r.data = {'page': 'bar'};
          }
        });
        r.set('route.path', '/foo/baz');
        $expect(window.location.pathname).to.be.equal('/bar');
        $expect(r.data).to.be.deep.equal({'page': 'bar'});
        $expect(r.route['path']).to.be.equal('/bar');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing a data piece in response to path changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.set('data.page', 'bar');
        r.on['route-changed'].listen((e) {
          r.set('data.page', 'bar');
        });
        r.set('route.path', '/foo/baz');
        $expect(window.location.pathname).to.be.equal('/bar');
        $expect(r.data).to.be.deep.equal({'page': 'bar'});
        $expect(r.route['path']).to.be.equal('/bar');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing the tail in response to path changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.on['route-changed'].listen((e) {
          r.set('tail.path', '/bar');
        });
        r.set('route.path', '/foo');
        $expect(window.location.pathname).to.be.equal('/foo/bar');
        $expect(r.data).to.be.deep.equal({'page': 'foo'});
        $expect(r.route['path']).to.be.equal('/foo/bar');
        $expect(r.tail['path']).to.be.equal('/bar');

        r.set('route.path', '/foo/baz');
        $expect(window.location.pathname).to.be.equal('/foo/bar');
        $expect(r.data).to.be.deep.equal({'page': 'foo'});
        $expect(r.route['path']).to.be.equal('/foo/bar');
        $expect(r.tail['path']).to.be.equal('/bar');
      });

      test('changing the path in response to data changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.on['data-changed'].listen((e) {
          r.set('route.path', '/bar');
        });
        r.set('data', {'page': 'foo'});
        $expect(window.location.pathname).to.be.equal('/bar');
        $expect(r.data).to.be.deep.equal({'page': 'bar'});
        $expect(r.route['path']).to.be.equal('/bar');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing data in response to data changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.on['data-changed'].listen((e)  {
          r.set('data.page', 'bar');
        });
        r.set('data', {'page': 'foo'});
        $expect(window.location.pathname).to.be.equal('/bar');
        $expect(r.data).to.be.deep.equal({'page': 'bar'});
        $expect(r.route['path']).to.be.equal('/bar');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing the data object wholesale in response to data changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.on['data-changed'].listen((e)  {
          if (r.data['page'] == 'foo') {
            r.set('data', {'page': 'bar'});
          }
        });
        r.set('data', {'page': 'foo'});
        $expect(window.location.pathname).to.be.equal('/bar');
        $expect(r.data).to.be.deep.equal({'page': 'bar'});
        $expect(r.route['path']).to.be.equal('/bar');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing the tail in response to data changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.on['data-changed'].listen((e)  {
          r.set('tail.path', '/bar');
        });
        r.set('data', {'page': 'foo'});
        $expect(window.location.pathname).to.be.equal('/foo/bar');
        $expect(r.data).to.be.deep.equal({'page': 'foo'});
        $expect(r.route['path']).to.be.equal('/foo/bar');
        $expect(r.tail['path']).to.be.equal('/bar');
      });

      test('changing the path in response to tail changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.set('route.path', '/foo/');
        r.on['tail-changed'].listen((e)  {
          r.set('route.path', '/baz' + r.tail['path']);
        });
        r.set('tail.path', '/bar');
        $expect(window.location.pathname).to.be.equal('/baz/bar');
        $expect(r.data).to.be.deep.equal({'page': 'baz'});
        $expect(r.route['path']).to.be.equal('/baz/bar');
        $expect(r.tail['path']).to.be.equal('/bar');
      });

      test('changing the data in response to tail changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.set('route.path', '/foo/');
        r.on['tail-changed'].listen((e)  {
          r.set('data.page', 'baz');
        });
        r.set('tail.path', '/bar');
        $expect(window.location.pathname).to.be.equal('/baz');
        $expect(r.data).to.be.deep.equal({'page': 'baz'});
        $expect(r.route['path']).to.be.equal('/baz');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing the data object wholesale in response to tail changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.set('route.path', '/foo/');
        r.on['tail-changed'].listen((e)  {
          r.set('data', {'page': 'baz'});
        });
        r.set('tail.path', '/bar');
        $expect(window.location.pathname).to.be.equal('/baz');
        $expect(r.data).to.be.deep.equal({'page': 'baz'});
        $expect(r.route['path']).to.be.equal('/baz');
        $expect(r.tail['path']).to.be.equal('');
      });

      test('changing the tail in response to tail changing', () {
        RedirectAppRoute r = fixture('Redirection');
        r.set('route.path', '/foo/');
        r.on['tail-changed'].listen((e)  {
          r.set('tail.path', '/baz');
        });
        r.set('tail.path', '/bar');
        $expect(window.location.pathname).to.be.equal('/foo/baz');
        $expect(r.data).to.be.deep.equal({'page': 'foo'});
        $expect(r.route['path']).to.be.equal('/foo/baz');
        $expect(r.tail['path']).to.be.equal('/baz');
      });
    });
  });
}
