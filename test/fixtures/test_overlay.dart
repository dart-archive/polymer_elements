@HtmlImport('test_overlay.html')
library polymer_elements.test.fixtures.test_overlay;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_fit_behavior.dart';
import 'package:polymer_elements/iron_overlay_behavior.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:web_components/web_components.dart';

@jsProxyReflectable
@PolymerRegister('test-overlay')
class TestOverlay extends PolymerElement
    with IronOverlayBehavior, IronFitBehavior, IronResizableBehavior {
  TestOverlay.created() : super.created();
}
