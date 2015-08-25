// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_image;

import 'dart:async';
import 'dart:math';
import 'package:polymer_elements/iron_image.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

var rand = new Random();

main() async {
  await initWebComponents();
  
  group('<iron-image>', () {
    randomImageUrl () {
      return 'fixtures/polymer.svg?' + rand.nextDouble().toString();
    }

    IronImage image;
    
    group('basic behavior', () {
      setUp(() {
        image = fixture('TrivialImage');
      });

      test('can load images given a src', () {
        var done = new Completer();
        image.on['loaded-changed'].take(1).listen((_) {
          expect(image.loaded, isTrue);
          done.complete();
        });
        image.src = randomImageUrl();
        return done.future;
      });

      test('will reload images when src changes', () {
        var loadCount = 0;
        var done = new Completer();
        StreamSubscription listener;
        listener = image.on['loaded-changed'].listen((_) {
          if (image.loaded) {
            loadCount++;
            if (loadCount == 2) {
              listener.cancel();
              done.complete();
            } else {
              wait(1).then((_) {
                image.src = randomImageUrl();
              });
            }
          }
        });
        image.src = randomImageUrl();
        return done.future;
      });
    });
  });
}
