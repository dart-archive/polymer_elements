// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('x_translate_only_imperative.html')
library polymer_elements.test.fixtures.x_translate_only_imperative;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';
import 'package:polymer_elements/app_localize_behavior.dart';

@PolymerRegister('x-translate-only-imperative')
class XTranslateOnlyImperative extends PolymerElement with AppLocalizeBehavior {
  XTranslateOnlyImperative.created() : super.created();

  DivElement get output => $['output'];

  @property
  String language = "en";

  @property
  Map resources = {
    'en': {'greeting': 'hello'},
    'fr': {'greeting': 'bonjour'},
    'it': {'greeting': 'ciao'}
  };
}
