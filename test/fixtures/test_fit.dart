@HtmlImport('test_fit.html')
library polymer_elements.test.fixtures.test_fit;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_fit_behavior.dart';
import 'package:web_components/web_components.dart';

@jsProxyReflectable
@PolymerRegister('test-fit')
class TestFit extends PolymerElement with IronFitBehavior {
  TestFit.created() : super.created();
}
