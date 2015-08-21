@HtmlImport('iron_resizable_elements.html')
library polymer_elements.test.fixtures.iron_resizable_elements;

import 'dart:html';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@jsProxyReflectable
@PolymerRegister('x-resizer-parent')
class XResizerParent extends PolymerElement with IronResizableBehavior {
  XResizerParent.created() : super.created();

  @Listen('core-resize')
  resizeHandler(_, __) {}
}

@jsProxyReflectable
@PolymerRegister('x-resizer-parent-filtered')
class XResizerParentFiltered extends PolymerElement with IronResizableBehavior {
  XResizerParentFiltered.created() : super.created();

  Element active;

  @Listen('core-resize')
  resizeHandler(_, __) {}

  @eventHandler
  bool resizerShouldNotify(el) {
    return (el == active);
  }
}

@jsProxyReflectable
@PolymerRegister('x-resizable')
class XResizable extends PolymerElement with IronResizableBehavior {
  XResizable.created() : super.created();

  @Listen('core-resize')
  resizeHandler(_) {}
}

@jsProxyReflectable
@PolymerRegister('x-resizable-in-shadow')
class XResizableInShadow extends PolymerElement {
  XResizableInShadow.created() : super.created();
}

@jsProxyReflectable
@PolymerRegister('test-element')
class TestElement extends PolymerElement {
  TestElement.created() : super.created();
}

@behavior
abstract class ObserveIronResizeBehavior
    implements IronResizableBehavior, PolymerMixin {
  @property
  int ironResizeCount = 0;

  @Listen('iron-resize')
  incrementIronResizeCount(_, __) {
    set('ironResizeCount', ironResizeCount + 1);
  }
}

@jsProxyReflectable
@PolymerRegister('x-shadow-resizable')
class XShadowResizable extends PolymerElement
    with IronResizableBehavior, ObserveIronResizeBehavior {
  XShadowResizable.created() : super.created();
}

@jsProxyReflectable
@PolymerRegister('x-light-resizable')
class XLightResizable extends PolymerElement
    with IronResizableBehavior, ObserveIronResizeBehavior {
  XLightResizable.created() : super.created();
}
