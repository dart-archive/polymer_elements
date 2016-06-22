// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.firebase_auth_test;

import 'package:polymer_elements/firebase_auth.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  FirebaseAuth firebase;

  group('basic usage', () {
    setUp(() {
      firebase = fixture('TrivialAuth');
    });

    tearDown(() {
      firebase.logout();
    });

    test('allows anonymous authentication', () {
      var done = firebase.on['login'].first.then((_) {
        expect(firebase.ref.callMethod('getAuth'), isNotNull);
      });
      firebase.login(null, null);
      return done;
    });
  });
}
