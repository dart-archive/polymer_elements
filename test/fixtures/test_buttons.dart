@HtmlImport('test_buttons.html')
library fixture.test_buttons;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:html';

@PolymerRegister('test-buttons')
class TestButtons extends PolymerElement {
  TestButtons.created() : super.created();

  ButtonElement get button0 => $['button0'];
}