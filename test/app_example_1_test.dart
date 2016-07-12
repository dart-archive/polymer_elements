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

import 'fixtures/app_example_1.dart';


main() async {
  await initPolymer();


  setLocation(url) {
    window.history.pushState({}, '', url);
    window.dispatchEvent(new CustomEvent('location-changed'));
    /*
    context['Polymer']['Base'].callMethod('fire', [
      'location-changed',
      {},
      {'node': window}
    ]);*/
  }

  suite('<test-app-example-1>', () {
    var originalLocation;
    AppExample1 exampleApp;

    setup(() {
      originalLocation = window.location.href;
      exampleApp = fixture('ExampleApp');
    });

    teardown(() {
      window.history.replaceState({}, '', originalLocation);
    });


    test('skipped',() {

    },skip: "some test get skipped as soon as the location is changed ....");
    test('runs through basic usage', () {
      // Navigate to /lol
      setLocation('/lol');

      $expect(exampleApp.data).to.be.deep.eq({'page': 'lol'});
      $expect(exampleApp.userData).to.be.deep.eq({});
      $expect(exampleApp.route).to.be.deep.eq({'prefix': '', 'path': '/lol', '__queryParams': {}});
      $expect(exampleApp.userRoute).to.be.deep.eq({'prefix': null, 'path': null, '__queryParams': {}});
      $expect(window.location.pathname).to.be.equal('/lol');

      // Navigate to /user
      setLocation('/user');
      $expect(exampleApp.data).to.be.deep.eq({'page': 'user'});

      // We should have redirected to /user/view because of a redirect in
      // the example app code.
      $expect(exampleApp.route).to.be.deep.eq({'prefix': '', 'path': '/user/view', '__queryParams': {}});
      $expect(exampleApp.userRoute).to.be.deep.eq({'prefix': '/user', 'path': '/view', '__queryParams': {}});
      $expect(window.location.pathname).to.be.equal('/user/view');

      // Navigate to /user/details
      setLocation('/user/details');
      $expect(exampleApp.data).to.be.deep.eq({'page': 'user'});
      $expect(exampleApp.userData).to.be.deep.eq({'page': 'details'});
      $expect(exampleApp.route).to.be.deep.eq({'prefix': '', 'path': '/user/details', '__queryParams': {}});
      $expect(exampleApp.userRoute).to.be.deep.eq({'prefix': '/user', 'path': '/details', '__queryParams': {}});
      $expect(window.location.pathname).to.be.equal('/user/details');

      exampleApp.set('data.page', 'redirectToUser');
      $expect(window.location.pathname).to.be.equal('/user/view');

      // This triggers two redirects in a row!
      setLocation('/redirectToUser');
      $expect(window.location.pathname).to.be.equal('/user/view');

      // Data binding changes to a different user subpage.
      exampleApp.set('userData.page', 'profile');
      $expect(window.location.pathname).to.be.eq('/user/profile');

      // Data binding changes to the aunt of the current page.
      exampleApp.set('data.page', 'feed');
      $expect(window.location.pathname).to.be.eq('/feed');

      setLocation('/user/etc');
      exampleApp.set('userData.page', 'details');
      $expect(window.location.pathname).to.be.eq('/user/details');

      $expect(window.location.search).to.be.eq('');
      exampleApp.set('userQueryParams.foo', 'bar');
      $expect(window.location.search).to.be.eq('?foo=bar');

      exampleApp.userQueryParams = {'bar': 'baz'};
      $expect(window.location.search).to.be.eq('?bar=baz');
    }); // NOTE : THIS GET SKIPPED AS SOON AS WE SET THE WINDOW LOCATION ....

  });
}
