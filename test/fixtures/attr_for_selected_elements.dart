@HtmlImport('attr_for_selected_elements.html')
library fixture.x_nested_scrollable;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

@PolymerRegister('attr-reflector')
class AttrReflector extends PolymerElement {
  AttrReflector.created() : super.created();

  @Property(reflectToAttribute: true) String someAttr = "";
}