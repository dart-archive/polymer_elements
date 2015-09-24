// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@HtmlImport('neon_test_resizable_pages.html')
library polymer_elements.test.fixtures.neon_test_resizable_pages;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer_elements/neon_animatable_behavior.dart';
import 'package:polymer_elements/neon_shared_element_animatable_behavior.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:polymer_elements/paper_styles.dart' as paper_styles;

/// Used imports: [paper_styles]
@PolymerRegister('a-resizable-page')
class AResizablePage extends PolymerElement
    with
        NeonAnimatableBehavior,
        NeonSharedElementAnimatableBehavior,
        IronResizableBehavior {
  factory AResizablePage() => new Element.tag('a-resizable-page');
  AResizablePage.created() : super.created();
}

@PolymerRegister('b-resizable-page')
class BResizablePage extends PolymerElement
    with
        NeonAnimatableBehavior,
        NeonSharedElementAnimatableBehavior,
        IronResizableBehavior {
  factory BResizablePage() => new Element.tag('b-resizable-page');
  BResizablePage.created() : super.created();
}

@PolymerRegister('c-resizable-page')
class CResizablePage extends PolymerElement
    with
        NeonAnimatableBehavior,
        NeonSharedElementAnimatableBehavior,
        IronResizableBehavior {
  factory CResizablePage() => new Element.tag('c-resizable-page');
  CResizablePage.created() : super.created();
}
