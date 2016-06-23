// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.app_drawer_layout_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/app_layout/app_drawer_layout/app_drawer_layout.dart';
import 'package:polymer_elements/app_layout/app_drawer/app_drawer.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'sinon/sinon.dart' as sinon;
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'package:polymer_elements/app_location.dart';

/// Used tests: [IronIcon], [iron_icons]
main() async {
  await initPolymer();

  setLocation(url) {
    window.history.pushState({}, '', url);
    context['Polymer']['Base'].callMethod('fire', [
      'location-changed',
      {},
      {'node': window}
    ]);
  }

  assign(Map a, Map b) {
    if (b!=null) {
      a.addAll(b);
    }
    return a;
  }

  suite('<app-location>', () {
    var initialUrl;

    setup(() {
      initialUrl = window.location.href;
    });

    teardown(() {
      window.history.replaceState({}, '', initialUrl);
    });

    suite('in the default configuration', () {
      AppLocation appLocation;

      setup(() {
        appLocation = fixture('BasicLocation');
      });

      test('it automatically exposes the current route', () {
        $expect(appLocation.route).to.be.ok;
        $expect(appLocation.route['path']).to.be.equal(window.location.pathname);
      });

      suite('manipulating the route', () {
        var originalPath;
        var originalQueryParams;

        setup(() {
          originalPath = appLocation.route['path'];
          originalQueryParams = assign({}, appLocation.route['queryParams']);
        });

        teardown(() {
          appLocation.set('route.prefix', '');
          appLocation.set('route.path', originalPath);
          appLocation.set('route.__queryParams', originalQueryParams);
        });

        test('it reflects path to location.pathname', () {
          appLocation.set('route.path', '/foo/bar');
          $expect(window.location.pathname).to.be.equal('/foo/bar');
        });

        test('it reflects queryParams values to location.search', () {
          appLocation.set('route.__queryParams.foo', 1);
          $expect(window.location.search).to.match("foo=1");
        });

        test('it reflects completely replaced queryParams', () {
          appLocation.set('route.__queryParams', {'bar': 1});
          $expect(window.location.search).to.be.equal('?bar=1');
        });

        test('it reflects the prefix to location.pathname', () {
          appLocation.set('route.prefix', '/fiz');
          $expect(window.location.pathname).to.be.equal('/fiz' + originalPath);
        });
      });

      /**
   * NOTE: For a more thorough spec describing this behavior, please refer
   * to the `iron-location` component.
   */
      suite('manipulating the history state', () {
        var originalLocation;

        setup(() {
          originalLocation = window.location.toString();
        });

        teardown(() {
          setLocation(originalLocation);
        });

        test('it reflects location.pathname to route.path', () {
          setLocation('/fiz/buz');
          $expect(appLocation.route['path']).to.be.equal('/fiz/buz');
        });

        test('it reflects location.search to route.__queryParams', () {
          setLocation('?fiz=buz');
          $expect(appLocation.route['queryParams']).to.be.eql({'fiz': 'buz'});
        });
      });
    });

    suite('using the hash as the route path', () {
      AppLocation appLocation;

      setup(() {
        appLocation = fixture('LocationViaHash');
      });

      test('it reflects location.hash to route.path', () {
        setLocation('#/fiz/buz');
        $expect(appLocation.route['path']).to.be.equal('/fiz/buz');
      });

      test('it reflects route.path to location.hash', () {
        appLocation.set('route.path', '/foo/bar');
        $expect(window.location.hash).to.be.equal('#/foo/bar');
      });
    });
  });
}
