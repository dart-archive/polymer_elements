@TestOn('browser')
library polymer_elements.test.google_map_markers_add_remove_test;

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
      map = fixture('map1');
    });

    test('markers are defined, added, removed', () {
      var done = new Completer();
      onReady(map, (e) {
        // Check if marker children were setup and can be added/removed.
        // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/20
        expect(map.jsElement['markers'].length, 2);

        // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/20
        var marker = map.jsElement['markers'][0];
        Polymer.dom((Polymer.dom(marker).parentNode)).removeChild(marker);
        PolymerDom.flush();
        wait(1).then((_) {
          // needed because map.updateMarkers has mutationObserver
          // TODO(jakemac): https://github.com/dart-lang/polymer_elements/issues/20
          expect(map.jsElement['markers'].length, 1);
          expect(marker.marker['map'], isNull,
              reason: 'removed marker is still visible on map');
          Polymer.dom(map).append(marker);
          PolymerDom.flush();
          wait(1).then((_) {
            expect(marker.marker['map'], isNotNull,
                reason: 're-added marker is not visible.');
            done.complete();
          });
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
