@HtmlImport('x_scrollable.html')
library fixture.x_scrollable;

import 'package:web_components/web_components.dart';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_scroll_target_behavior.dart';
import 'dart:js';
import 'dart:html';

@CustomElementProxy('x-scrollable')
class XScrollable extends HtmlElement with CustomElementProxyMixin,PolymerBase,IronScrollTargetBehavior {
  XScrollable.created() : super.created();

  num get itemCount => jsElement['itemCount'];

  set itemCount(num val) => jsElement['itemCount'] = val;


}