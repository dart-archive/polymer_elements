/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_feeds_demo.html')
library polymer_elements_demo.web.google_feeds.google_feeds_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_feeds.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleFeeds], [DemoElements],
@PolymerRegister('google-feeds-demo')
class GoogleFeedsDemo extends PolymerElement {
  GoogleFeedsDemo.created() : super.created();

  @property String message = '';

  void ready() {
    on['google-feeds-response'].listen((e) {
      set('message', '$message${e.target.localName} loaded\n');
      print(e.detail.feed);
    });

    on['google-feeds-queryresponse'].listen((e) {
      print('findFeeds response: ${e.detail.entries}');
    });

    $['feeder'].feeds = [
      'https://news.ycombinator.com/rss',
      'http://feeds.bbci.co.uk/news/rss.xml'
    ];
  }
}
