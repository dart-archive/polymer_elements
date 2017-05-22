/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_apis_demo.html')
library polymer_elements_demo.web.google_apis.google_apis_demo;

import 'dart:html' as dom;
import 'dart:js' as js;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_apis.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleApis], [DemoElements],
@PolymerRegister('google-apis-demo')
class GoogleApisDemo extends PolymerElement {
  GoogleApisDemo.created() : super.created();

  @reflectable
  void loadedShortener(dom.Event event, [_]) {
    var request = (event.target as dynamic).api['url'].apply('get', [
      {'shortUrl': 'http://goo.gl/fbsS'}
    ]);
    request.execute((resp) {
      print(resp);
    });
  }

  @reflectable
  void loaded(dom.Event event, [_]) {
    var message = '${(event.target as dom.Element).localName} loaded';
    dom.document.querySelector('#messages').innerHtml += '${message}<br>';
    print(message);
    dom.window.console.debug((event.target as dynamic).api);
  }
}
