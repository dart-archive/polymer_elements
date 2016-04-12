@HtmlImport('chained_routes.html')
library fixture.chained_routes;


import 'package:polymer/polymer.dart';
import 'package:polymer_elements/carbon_route.dart';
import 'dart:html';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('chained-route-test')
class ChangedRouteTest extends PolymerElement {
  ChangedRouteTest.created() : super.created();

  factory ChangedRouteTest() => new Element.tag('chained-route-test');

  @Property(notify: true) Map numberOneTopRoute;

  @Property(notify: true) Map fooRoute;

  @Property(notify: true) Map fooData;

  @Property(notify: true) Map barData;

  @Property(notify: true) Map bazData;

  CarbonRoute get foo => $['foo'];

  CarbonRoute get baz => $['baz'];

  CarbonRoute get bar => $['bar'];

}
