@HtmlImport('app_layout_helpers.html')
library polymer_elements.app_layout_helpers;
import 'package:web_components/web_components.dart';
import 'dart:js';

class AppLayout {
  static final JsObject jsObject = context['Polymer']['AppLayout'];

  static registerEffect(String effectName,effectDef) => jsObject.callMethod('registerEffect',[effectName,effectDef]);

  static scroll(options) => jsObject.callMethod('scroll',[options]);

  static get scrollTimingFunction => jsObject['scrollTimingFunction'];

  static set scrollTimingFunction(v) => jsObject['scrollTimingFunction']=v;

}
