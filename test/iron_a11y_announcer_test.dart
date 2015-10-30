// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_a11y_announcer_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_a11y_announcer.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';

main() async {
  await initWebComponents();

  group('<iron-a11y-announcer', () {
    IronA11yAnnouncer announcer;

    setUp(() {
      announcer = new IronA11yAnnouncer();
    });

    test('announces when there is an iron-announce event', () async {
      announcer.fire('iron-announce',
          detail: {'text': 'foo'}, node: document.body);
      // Text isn't set for 100ms
      await new Future.delayed(new Duration(milliseconds: 200), () {});
      expect(announcer.jsElement['_text'], 'foo');
    });
  });
}
