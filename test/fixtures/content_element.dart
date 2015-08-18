@HtmlImport('content_element.html')
library polymer_elements.test.fixtures.content_element;

import 'dart:html';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';

@CustomElementProxy('test-content-element')
class TestContentElement extends HtmlElement
    with CustomElementProxyMixin, PolymerBase {
  TestContentElement.created() : super.created();

  String get selected => jsElement['selected'];
  void set selected(String value) {
    jsElement['selected'] = value;
  }
}
