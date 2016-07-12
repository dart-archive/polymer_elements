@HtmlImport('x_container.html')
library fixture.x_container;

import 'package:web_components/web_components.dart';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_scroll_target_behavior.dart';
import 'dart:js';
import 'dart:html';
import 'package:polymer_elements/app_layout/app_scroll_effects/app_scroll_effects_behavior.dart';



@CustomElementProxy('x-container')
class XContainer extends HtmlElement with CustomElementProxyMixin,PolymerBase,IronScrollTargetBehavior,AppScrollEffectsBehavior {
  XContainer.created() : super.created();

  DivElement get backgroundFrontLayer => $['backgroundFrontLayer'];

  DivElement get backgroundRearLayer => $['backgroundRearLayer'];

  HeadingElement get condensedTitle => $['condensedTitle'];

  HeadingElement get titleH => $['title'];

  void updateScrollState(num x) => jsElement.callMethod('_updateScrollState',[x]);

  bool get shadow => jsElement['shadow'];
  set shadow(v) => jsElement['shadow'] = v;


}