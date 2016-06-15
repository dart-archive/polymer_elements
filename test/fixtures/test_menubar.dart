@HtmlImport('test_menubar.html')
library polymer_elements.test.fixtures.test_menubar;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';
import 'package:polymer_elements/iron_menu_behavior.dart';
import 'package:polymer_elements/iron_menubar_behavior.dart';
import 'package:polymer_elements/iron_multi_selectable.dart';
import 'package:polymer_elements/iron_selectable.dart';
import 'package:web_components/web_components.dart';
import 'dart:html';

@PolymerRegister('test-menubar')
class TestMenuBar extends PolymerElement
    with
        IronSelectableBehavior,
        IronMultiSelectableBehavior,
        IronA11yKeysBehavior,
        IronMenuBehavior,
        IronMenubarBehavior {
  TestMenuBar.created() : super.created();

  DivElement get extraContent => this.$['extraContent'];

}
