// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_page_url_basic_test;

import 'dart:html';

import 'package:polymer_elements/iron_page_url.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

import 'common.dart';

main() async {
  await initWebComponents();

  group('<iron-page-url>',  () {
    var initialUrl;

    setUp(() {
      initialUrl = window.location.href;
    });

    tearDown((){
      window.history.replaceState({}, '', initialUrl);
    });

    group('when used solo', () {
      var urlElem;

      setUp(() {
        urlElem = document.createElement('iron-page-url');
        document.body.append(urlElem);
      });

      tearDown(() {
        urlElem.remove();
      });

      test('basic functionality with #hash urls', () async {
        // Initialized to the window location's hash.
        // Use `endsWith` to get around an issue with the test runner.
        expect(window.location.hash, endsWith(urlElem.hash));

        // Changing the urlElem's hash changes the URL
        urlElem.hash = '/lol/ok';
        expect(window.location.hash, '#/lol/ok');

        // Changing the hash via normal means changes the urlElem.
        var anchor = document.createElement('a');
        anchor.href = '#/wat';
        document.body.append(anchor);
        anchor.click();
        // In IE10 it appears that the hashchange event is asynchronous.
        await wait(10);
        expect(urlElem.hash, '/wat');
      });

      test('basic ality with paths', () {
        // Initialized to the window location's path.
        expect(window.location.pathname, urlElem.path);

        // Changing the urlElem's path changes the URL
        urlElem.path = '/foo/bar';
        expect(window.location.pathname, '/foo/bar');

        // Changing the path and sending a custom event on the window changes
        // the urlElem.
        window.history.replaceState({}, '', '/baz');
        window.dispatchEvent(new CustomEvent('location-changed'));
        expect(urlElem.path, '/baz');
      });

      test('basic ality with ?key=value params', () {
        // Initialized to the window location's params.
        expect(urlElem.queryString, '');

        // Changing location.search and sending a custom event on the window
        // changes the urlElem.
        window.history.replaceState({}, '', '/?greeting=hello&target=world');
        window.dispatchEvent(new CustomEvent('location-changed'));
        expect(urlElem.queryString, 'greeting=hello&target=world');

        // Changing the urlElem's query changes the URL.
        urlElem.queryString = 'greeting=hello&target=world&another=key';
        expect(window.location.search,
            '?greeting=hello&target=world&another=key');
      });
    });
  });
}
