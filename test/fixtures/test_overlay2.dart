@HtmlImport('test_overlay2.html')
library fixture.test_overlay2;


import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_fit_behavior.dart';
import 'package:polymer_elements/iron_overlay_behavior.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_overlay_backdrop.dart';
import 'dart:html';


@CustomElementProxy('test-overlay2')
class TestOverlay2  extends HtmlElement with CustomElementProxyMixin,PolymerBase,IronOverlayBehavior  {
  TestOverlay2.created() : super.created();

  List<Element> get focusableNodes => jsElement['_focusableNodes'];
}