@HtmlImport('test_menu_button.html')
library fixture.test_menu_button;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

import 'test_overlay.dart';
import 'dart:html';

@PolymerRegister("test-menu-button")
class TestMenuButton extends PolymerElement {
  TestMenuButton.created():super.created();

  ButtonElement get trigger => $['trigger'];

  TestOverlay get dropdown => $['dropdown'];

  @reflectable
  toggle([_,__]) {
    dropdown.toggle();
  }

}