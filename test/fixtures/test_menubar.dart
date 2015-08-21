@HtmlImport('test_menubar.html')
library polymer_elements.test.fixtures.test_menubar;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_menubar_behavior.dart';
import 'package:web_components/web_components.dart';

@jsProxyReflectable
@PolymerRegister('test-menubar')
class TestMenu extends PolymerElement with IronMenubarBehavior {
  TestMenu.created() : super.created();
}
