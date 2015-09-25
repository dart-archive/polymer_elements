@HtmlImport('app_element.html')
library app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/gold_cc_cvc_input.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/demo_pages.dart';

/// Silence analyzer [GoldCcCvcInput]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();
}
