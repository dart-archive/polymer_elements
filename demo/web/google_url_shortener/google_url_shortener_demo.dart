/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_url_shortener_demo.html')
library polymer_elements_demo.web.google_url_shortener.google_url_shortener_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_url_shortener.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleUrlShortener], [DemoElements]
@PolymerRegister('google-url-shortener-demo')
class GoogleUrlShortenerDemo extends PolymerElement {
  GoogleUrlShortenerDemo.created() : super.created();

  @property String longUrl;
  @property String shortUrl;
  @property String urlError;

  @reflectable
  bool shorten([_, __]) {
    set('longUrl', ($['longUrl'] as dom.UrlInputElement).value);
    return false;
  }
}
