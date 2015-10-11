@HtmlImport('tooltip_button.html')
library polymer_elements.test.fixtures.tooltip_button;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/paper_tooltip.dart';

/// Uses [PaperTooltip]
@PolymerRegister('test-button')
class TestButton extends PolymerElement {
  TestButton.created() : super.created();
}
