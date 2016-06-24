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
import 'package:polymer/polymer.dart';
import 'dart:html';

var rand = new Random();

main() async {
  await initWebComponents();

  randomImageUrl() {
    return 'fixtures/polymer.svg?' + rand.nextDouble().toString();
  }

  group('<iron-image>', () {
    randomImageUrl() {
      return 'fixtures/polymer.svg?' + rand.nextDouble().toString();
    }

    IronImage image;

    group('basic behavior', () {
      setUp(() {
        image = fixture('TrivialImage');
      });

      test('loading, loaded, error are false before any src is set', () {
        expect(image.loading, isFalse);
        expect(image.loaded, isFalse);
        expect(image.error, isFalse);
      });

      test('loading, loaded, error are false when src is set to empty string', () {
        Completer done = new Completer();
        int i = 0;
        image.on['loaded-changed'].takeWhile((_) => i == 0).listen((_) {
          if (image.loaded) {
            i++;
            //image.removeEventListener('loaded-changed', onLoadedChanged);
            image.on['loaded-changed'].take(1).listen((_) {
              expect(image.loading, isFalse);
              expect(image.loaded, isFalse);
              expect(image.error, isFalse);
              done.complete();
            });

            expect(image.loading, isFalse);
            expect(image.loaded, isTrue);
            expect(image.error, isFalse);
            image.src = '';
          }
        });
        image.src = randomImageUrl();
        return done.future;
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

    test('error property is set when the image fails to load', () {
      StreamSubscription l;
      Completer done = new Completer();
      l = image.on['error-changed'].listen((_) {
        expect(image.error, isNotNull, reason: 'image has error property set');
        l.cancel();
        done.complete();
      });

      image.src = '/this_image_should_not_exist.jpg';
      return done.future;
    });

    // Test for PolymerElements/iron-image#16.
    test('placeholder is hidden after loading when src is changed from invalid to valid', () {
      image.preload = true;
      Completer done = new Completer();

      StreamSubscription onErrorChanged;
      onErrorChanged = image.on['error-changed'].listen((_) {
        onErrorChanged.cancel();

        expect(image.loading, isFalse, reason: 'errored image loading = false');
        expect(image.loaded, isFalse, reason: 'errored image loaded = false');
        expect(image.error, isFalse, reason: 'errored image error = true');

        StreamSubscription onLoadedChanged;
        onLoadedChanged = image.on['loaded-changed'].listen((_) {
          if (!image.loaded) return;

          onLoadedChanged.cancel();

          expect(image.loading, isFalse, reason: 'ok image loading = false');
          expect(image.loaded, isTrue, reason: 'ok image loaded = true');
          expect(image.error, isFalse, reason: 'ok image error = false');
          expect(image.$['placeholder'].getComputedStyle().display, 'none', reason: 'placeholder has style.display = none');

          done.complete();
        });

        wait(1).then((_) {
          image.src = randomImageUrl();
        });
        return done.future;
      });

      image.src = '/this_image_should_not_exist.jpg';
    });

    // Test for PolymerElements/iron-image#23.
    // NOTE : This sometimes fails when run with the whole test suite.
    test('image is not shown below placeholder if previous image was loaded with' + ' sizing on and current image fails to load', () {
      Completer done = new Completer();
      image.preload = true;
      image.sizing = 'cover';

      StreamSubscription onLoadedChanged;
      onLoadedChanged = image.on['loaded-changed'].listen((_) {
        if (!image.loaded) return;
        onLoadedChanged.cancel();

        expect(image.$["sizedImgDiv"].getComputedStyle().backgroundImage, isNot('none'), reason: 'image visible after successful load');
        expect(image.$["placeholder"].getComputedStyle().display, 'none', reason: 'placeholder hidden after successful load');

        StreamSubscription onErrorChanged;
        onErrorChanged = image.on['error-changed'].listen((_) {
          if (!image.error) return;
          onErrorChanged.cancel();

          expect(image.$["sizedImgDiv"].getComputedStyle().backgroundImage, 'none', reason: 'image hidden after failed load');
          expect(image.$["placeholder"].getComputedStyle().display, isNot('none'), reason: 'placeholder visible after failed load');

          done.complete();
        });

        image.src = '/this_image_should_not_exist.jpg';
      });

      image.src = randomImageUrl();
      return done.future;
    });
  });

  group('--iron-image-width', () {
    var fixedWidthContainer;
    var fixedWidthIronImage;

    setUp(() {
      fixedWidthContainer = fixture('FixedWidthContainer');
      fixedWidthIronImage = fixedWidthContainer.querySelector('iron-image');
    });

    test('100% width image fills container', () {
      Completer done = new Completer();
      fixedWidthIronImage.$['img'].on['load'].take(1).listen((Event e) {
        //fixedWidthIronImage.$.img.removeEventListener('load', onLoadedChanged);
        Polymer.updateStyles();

        var containerRect = fixedWidthContainer.getBoundingClientRect();
        var ironImageRect = fixedWidthIronImage.getBoundingClientRect();
        var wrappedImageRect = fixedWidthIronImage.$['img'].getBoundingClientRect();

        expect(containerRect.width, closeTo(500, 0.5));
        expect(ironImageRect.width, closeTo(500, 0.5));
        expect(wrappedImageRect.width, closeTo(500, 0.5));

        done.complete();
      });

      fixedWidthIronImage.src = randomImageUrl();
      return done.future;
    });
  });

  group('--iron-image-height', () {
    var fixedHeightContainer;
    var fixedHeightIronImage;

    setUp(() {
      fixedHeightContainer = fixture('FixedHeightContainer');
      fixedHeightIronImage = fixedHeightContainer.querySelector('iron-image');
    });

    test('100% height image fills container', () {
      Completer done = new Completer();
      fixedHeightIronImage.$['img'].on['load'].take(1).listen((Event e) {
        Polymer.updateStyles();

        var containerRect = fixedHeightContainer.getBoundingClientRect();
        var ironImageRect = fixedHeightIronImage.getBoundingClientRect();
        var wrappedImageRect = fixedHeightIronImage.$['img'].getBoundingClientRect();

        expect(containerRect.height, closeTo(500, 0.5));
        expect(ironImageRect.height, closeTo(500, 0.5));
        expect(wrappedImageRect.height, closeTo(500, 0.5));

        done.complete();
      });

      fixedHeightIronImage.src = randomImageUrl();
      return done.future;
    });
  });

  group('accessibility', () {
    group('sizing inactive', () {
      IronImage image;

      setUp(() {
        image = fixture('TrivialImage');
      });

      test('#sizedImgDiv is hidden', () {
        var sizedImgDivStyle = image.$['sizedImgDiv'].getComputedStyle();
        expect(sizedImgDivStyle.display, 'none');
      });

      test('img has no alt text by default', () {
        expect(image.$['img'].attributes.containsKey('alt'), isFalse);
      });

      test('img alt text is empty string when iron-image alt text is empty string', () {
        image.alt = '';

        expect(image.$['img'].attributes.containsKey('alt'), isTrue);
        expect(image.$['img'].attributes['alt'], '');
      });

      test('img alt text matches iron-image alt text when defined', () {
        image.alt = 'alt text value';

        expect(image.$['img'].attributes.containsKey('alt'), isTrue);
        expect(image.$['img'].attributes['alt'], 'alt text value');
      });
    });

    group('sizing active', () {
      IronImage image;

      setUp(() {
        image = fixture('TrivialImage');
        image.sizing = 'cover';
      });

      test('inner img is hidden', () {
        var imgStyle = image.$['img'].getComputedStyle();
        expect(imgStyle.display, 'none');
      });

      test('#sizedImgDiv has empty aria-label text by default', () {
        expect(image.$['sizedImgDiv'].attributes.containsKey('aria-label'), isTrue);
        expect(image.$['sizedImgDiv'].attributes['aria-label'], '');
      });

      test('#sizedImgDiv has aria-hidden when iron-image alt text is empty string', () {
        image.alt = '';

        expect(image.$['sizedImgDiv'].attributes.containsKey('aria-hidden'), isTrue);
        var hiddenValue = image.$['sizedImgDiv'].attributes['aria-hidden'];
        expect(hiddenValue == '' || hiddenValue == 'true', isTrue);
      });

      test('#sizedImgDiv aria-label matches iron-image alt text when defined', () {
        image.alt = 'alt text value';

        expect(image.$['sizedImgDiv'].attributes.containsKey('aria-label'), isTrue);
        expect(image.$['sizedImgDiv'].attributes['aria-label'], 'alt text value');
      });

      test('#sizedImgDiv aria-label text is last path component of src when iron-image alt text is undefined', () {
        image.src = '/some/path.components/file.jpg?a=b&c=d#anchor';

        expect(image.$['sizedImgDiv'].attributes.containsKey('aria-label'), isTrue);
        expect(image.$['sizedImgDiv'].attributes['aria-label'], 'file.jpg');
      });
    });
  });
}
