@HtmlImport('test_menu.html')
library polymer_elements.test.fixtures.test_menu;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_menu_behavior.dart';
import 'package:polymer_elements/iron_multi_selectable.dart';
import 'package:polymer_elements/iron_selectable.dart';
import 'package:web_components/web_components.dart';
import "dart:html";

@PolymerRegister('test-menu')
class TestMenu extends PolymerElement
    with
        IronSelectableBehavior,
        IronMultiSelectableBehavior,
        IronA11yKeysBehavior,
        IronMenuBehavior {
  TestMenu.created() : super.created();

  DivElement get extraContent => $['extraContent'];
}
