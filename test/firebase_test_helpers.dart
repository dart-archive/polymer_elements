// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library iron_elements.test.firebase_test_helpers;

import 'dart:js';
import 'dart:math';
import 'common.dart';
import 'package:polymer_elements/firebase_collection.dart';

var _rand = new Random();

String firebaseTestProject = 'fb-element-demo';

randomKey() {
  return (0 | (_rand.nextDouble() * 999999999)).toString();
}

randomInt([min = 0, max = 10000]) {
  return _rand.nextInt(max - min) + min;
}

randomObject([min = 0, max = 10000]) {
  return {'value': randomInt(min, max)};
}

firebaseUrl(project, [path]) {
  return 'https://$project.firebaseio.com${path != null ? '/$path'  : ''}';
}

fixtureLocation([data = const {}]) {
  var firebase =
      new JsObject(context['Firebase'], [firebaseUrl(firebaseTestProject)]);
  return firebaseUrl(
      firebaseTestProject,
      firebase.callMethod('push', [new JsObject.jsify(data)])
          .callMethod('key'));
}

removeLocation(location) {
  new JsObject(context['Firebase'], [location]).callMethod('remove');
}

fixtureFirebase(fixtureName, [data = const {}]) {
  FirebaseCollection firebase = fixture(fixtureName);
  firebase.location = fixtureLocation(data);
  return firebase;
}

removeFirebase(firebase) {
  removeLocation(firebase.location);
  firebase.disconnect();
}

arrayOfPrimitives(length) {
  var array = [];

  for (var i = 0; i < length; ++i) {
    array.add(randomInt());
  }

  return array;
}

arrayOfObjects(length) {
  var array = [];

  for (var i = 0; i < length; ++i) {
    array.add(randomObject());
  }

  return array;
}
