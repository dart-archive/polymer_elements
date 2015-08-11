@TestOn('browser')
library polymer_elements.test.google_map_markers_basic_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/google_map.dart';
import 'package:polymer_elements/google_map_marker.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  GoogleMap map;

  group('markers', () {
    setUp(() {
      map = fixture('map1');
    });

    test('defaults', () {
      var markerEl = Polymer.dom(map).querySelector('google-map-marker');
      expect(markerEl.marker, isNull);
      expect(markerEl.map, isNull);
      expect(markerEl.icon, isNull);
      expect(markerEl.info, isNull);
      expect(markerEl.zIndex, 0);
      expect(markerEl.latitude, 37.779);
      expect(markerEl.longitude, -122.3892);
      expect(markerEl.offsetParent, isNull,
          reason: 'google-map-marker should be display: none');
    });

    test('update properties', () {
      var done = new Completer();
      map.on['google-map-ready'].take(1).listen((_) {
        var markerEl = Polymer.dom(map).querySelector('google-map-marker');
        markerEl.latitude = 37.77493;
        markerEl.longitude = -122.41942;
        markerEl.zIndex = 1;
        expect(markerEl.map, map.map,
            reason: "marker's map is not the google-map's");

        wait(1).then((_) {
          expect(markerEl.marker.callMethod('getPosition').callMethod('lat'),
              markerEl.latitude);
          expect(markerEl.marker.callMethod('getPosition').callMethod('lng'),
              markerEl.longitude);
          expect(markerEl.marker.callMethod('getZIndex'), markerEl.zIndex);

          markerEl.icon = 'https://www.google.com/images/srpr/logo11w.png';
          wait(0).then((_) {
            expect(markerEl.marker.callMethod('getIcon'), markerEl.icon);

            done.complete();
          });
        });
      });
      if (map.map != null) {
        map.dispatchEvent(new Event('google-map-ready'));
      }

      return done.future;
    });
  });
}
