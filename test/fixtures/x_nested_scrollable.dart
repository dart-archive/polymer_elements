@HtmlImport('x_nested_scrollable.html')
library fixture.x_nested_scrollable;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

import 'x_scrollable.dart';

@PolymerRegister('x-nested-scrollable')
class XNestedScrollable extends PolymerElement {
  XNestedScrollable.created() : super.created();
}