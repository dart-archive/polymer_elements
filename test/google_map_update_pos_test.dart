@TestOn('browser')
library polymer_elements.test.google_map_update_pos_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/google_map.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  GoogleMap map;

  group('markers', () {
    setUp(() {
      map = fixture('map');
    });

    test('update lat/lng', () {
      var done = new Completer();
      onReady(map, (e) {
        expect(map.latitude, 37.555);
        expect(map.longitude, -122.555);

        wait(1).then((_) {
          expect(
              map.latitude, map.map.callMethod('getCenter').callMethod('lat'),
              reason: 'map lat was not updated');
          expect(
              map.longitude, map.map.callMethod('getCenter').callMethod('lng'),
              reason: 'map lng was not updated');

          done.complete();
        });
      });
      return done.future;
    });
  });
}

onReady(GoogleMap map, Function fn) {
  if (map.map != null) {
    fn();
  } else {
    map.on['google-map-ready'].take(1).listen(fn);
  }
}
