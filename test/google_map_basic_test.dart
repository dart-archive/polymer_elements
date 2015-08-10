@TestOn('browser')
library polymer_elements.test.google_map_basic_test;

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

  group('google-map', () {

    GoogleMap map = document.querySelector('#map1');
    GoogleMap map2 = document.querySelector('#map2');
    GoogleMap map3 = document.querySelector('#map3');
  
    test('noAutoTilt', () async {
      var done1 = new Completer();
      var done2 = new Completer();
      map.on['google-map-ready'].take(1).listen((e) {
        // When noAutoTilt is set, tilt is left at default (45).
        expect(map.map.callMethod('getTilt'), 45);
        done1.complete();
      });
      map3.on['google-map-ready'].take(1).listen((e) {
        // When noAutoTilt is set, tilt is set to 0.
        expect(map3.map.callMethod('getTilt'), 0);
        done2.complete();
      });
      await done1.future;
      await done2.future;
    });
  
    test('defaults', () {
      // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/20
      expect(map.jsElement['markers'].length, 0);
      expect(map.fitToMarkers, isFalse);
      expect(map.disableDefaultUi, isFalse);
      expect(map.zoom, 10);
      expect(map.noAutoTilt, false);
      expect(map.maxZoom, isNull);
      expect(map.minZoom, isNull);
      expect(map.disableZoom, isFalse);
      expect(map.latitude, 37.77493);
      expect(map.longitude, -122.41942);
      expect(map.mapType, 'roadmap');
    });
  
    test('change properties', () {
      var done = new Completer();
      expect(map3.fitToMarkers, isTrue);
      // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/20
      expect(map3.jsElement['markers'].length, 0);
      expect(map3.zoom, map3.map.callMethod('getZoom'));
      expect(map3.maxZoom, map3.map['maxZoom']);
      expect(map3.minZoom, map3.map['minZoom']);
      expect(map3.disableZoom, isTrue);
    });
  
    test('declarative map creation', () {
      var map = document.createElement('google-map');
      document.querySelector('#newmap').append(map);
    });
  });
}
