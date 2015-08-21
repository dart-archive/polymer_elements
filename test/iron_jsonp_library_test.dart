@TestOn('browser')
library polymer_elements.test.iron_jsonp_library_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_jsonp_library.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<iron-jsonp-library>', () {
    test('good library loads', () {
      var done = new Completer();
      IronJsonpLibrary jsonp = fixture('jsonp-fixture');

      jsonp.on['api-load'].take(1).listen((_) {
        // Ensure that we can load the same library twice.
        // TODO: assert that only one network request is made.
        var second = new IronJsonpLibrary();
        second.notifyEvent = 'api-load';

        second.on['api-load'].take(1).listen((_) {
          done.complete();
        });

        second.on['library-error-message-changed'].take(1).listen((_) {
          done.completeError('second attempt fails');
        });

        second.libraryUrl =
            "https://apis.google.com/js/plusone.js?onload=%%callback%%";
      });

      jsonp.on['library-error-message-changed'].take(1).listen((_) {
        done.completeError('library did not load');
      });

      jsonp.libraryUrl =
          "https://apis.google.com/js/plusone.js?onload=%%callback%%";
      return done.future;
    });

    test('bad library dns fails to load', () {
      var done = new Completer();
      IronJsonpLibrary jsonp = fixture('jsonp-fixture');

      jsonp.on['api-load'].take(1).listen((_) {
        done.completeError('bad dns somehow loaded?');
      });

      jsonp.on['library-error-message-changed'].take(1).listen((_) {
        expect(jsonp.libraryErrorMessage, isNotNull);
        done.complete();
      });

      jsonp.libraryUrl =
          "https://badapis.google.com/js/plusone.js?onload=%%callback%%";
      return done.future;
    });

    test('libraryurl mising %%callback%%', () {
      var done = new Completer();
      IronJsonpLibrary jsonp = fixture('jsonp-fixture');

      jsonp.on['api-load'].take(1).listen((_) {
        done.completeError('no callback somehow loaded?');
      });

      jsonp.on['library-error-message-changed'].take(1).listen((_) {
        expect(jsonp.libraryErrorMessage, isNotNull);
        done.complete();
      });

      jsonp.libraryUrl = "https://apis.google.com/js/plusone.js?onload";
      return done.future;
    });
  });
}
