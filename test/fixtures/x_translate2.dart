// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('x_translate2.html')
library polymer_elements.test.fixtures.x_translate2;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';
import 'package:polymer_elements/app_localize_behavior.dart';

@PolymerRegister('x-translate2')
class XTranslate2 extends PolymerElement with AppLocalizeBehavior {
  XTranslate2.created() : super.created();

  DivElement get output => $['output'];

  @property
  String language = "en";

  @property
  Map resources = {
    'en': {'intro': 'my name is {name}. i have {numCats, number} cats.'},
    'fr': {'intro': 'je m\'apelle {name}. j\'ai {numCats, number} chats.'},
    'it': {'intro': 'Io mi chiamo {name}. Ho {numCats, number} gatti.'}
  };
}
