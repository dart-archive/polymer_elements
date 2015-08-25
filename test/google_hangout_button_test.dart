// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.google_hangout_button_test;

import 'dart:async';
import 'package:polymer_elements/google_hangout_button.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'sinon/sinon.dart' as sinon;

main() async {
  await initWebComponents();

  group('<google-hangout-button>', () {
    GoogleHangoutButton hg;
    var apiSpy;

    setUp(() {
      hg = fixture('basic');
    });

    test('basic', () {
      var done = new Completer();
      // Set up Api spies.
      hg.on['google-hangout-button-pregame'].take(1).listen((_) {
        var yt = hg.querySelector('google-plusone-api');
        apiSpy = sinon.spy(yt.api['hangout'], 'render');
      });

      hg.on['google-hangout-button-ready'].take(1).listen((_) {
        // Check if element's arguments are applied.
        testHangoutArgumentsAreApplied(hg, apiSpy);
        // Check if the hangout button iframe is created.
        testIframeCreated(hg);
        // Reset spies.
        apiSpy.reset();
        done.complete();
      });

      return done.future;
    });
  });
}

testIframeCreated(hangoutButton) {
  expect(hangoutButton.querySelector('iframe'), isNotNull);
}

testHangoutArgumentsAreApplied(hangoutButton, apiSpy) {
  expect(apiSpy.calledOnce, isTrue);
  expect(apiSpy.calledWith([sinon.matchAny, sinon.match({
    'hangout_type': 'party'
  })]), isTrue, reason: 'Loaded hangout type different than requested type');

  expect(apiSpy.calledWith([sinon.matchAny, sinon.match({
    'initial_apps': [{'app_id': '184219133185', 'start_data': 'dQw4w9WgXcQ', 'app_type': 'ROOM_APP' }]
  })]), isTrue, reason: 'Loaded apps different than requested apps');

  expect(apiSpy.calledWith([sinon.matchAny, sinon.match({
    'topic': "test topic"
  })]), isTrue, reason: 'Loaded topic different than requested topic');

  expect(apiSpy.calledWith([sinon.matchAny, sinon.match({
    'invites': [{ 'id': 'foo@example.com', 'invite_type': 'EMAIL' }]
  })]), isTrue, reason: 'Loaded invites different than requested invites');

  expect(apiSpy.calledWith([sinon.matchAny, sinon.match({
    'widget_size': 72
  })]), isTrue, reason: 'Loaded width different than requested width');
}
