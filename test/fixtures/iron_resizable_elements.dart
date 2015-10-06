@HtmlImport('iron_resizable_elements.html')
library polymer_elements.test.fixtures.iron_resizable_elements;

import 'dart:html';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@PolymerRegister('x-resizer-parent')
class XResizerParent extends PolymerElement with IronResizableBehavior {
  XResizerParent.created() : super.created();

  @Listen('core-resize')
  resizeHandler(_, __) {}
}

@PolymerRegister('x-resizer-parent-filtered')
class XResizerParentFiltered extends PolymerElement with IronResizableBehavior {
  XResizerParentFiltered.created() : super.created();

  Element active;

  @Listen('core-resize')
  resizeHandler(_, __) {}

  @reflectable
  bool resizerShouldNotify(el) {
    return (el == active);
  }
}

@PolymerRegister('x-resizable')
class XResizable extends PolymerElement with IronResizableBehavior {
  XResizable.created() : super.created();

  @Listen('core-resize')
  resizeHandler(_) {}
}

@PolymerRegister('x-resizable-in-shadow')
class XResizableInShadow extends PolymerElement with IronResizableBehavior {
  XResizableInShadow.created() : super.created();
}

@PolymerRegister('test-element')
class TestElement extends PolymerElement {
  TestElement.created() : super.created();
}

@behavior
abstract class ObserveIronResizeBehavior
    implements IronResizableBehavior, PolymerBase, PolymerMixin {
  @property
  int ironResizeCount = 0;

  @Listen('iron-resize')
  incrementIronResizeCount(_, __) {
    set('ironResizeCount', ironResizeCount + 1);
  }
}

@PolymerRegister('x-shadow-resizable')
class XShadowResizable extends PolymerElement
    with IronResizableBehavior, ObserveIronResizeBehavior {
  XShadowResizable.created() : super.created();
}

@PolymerRegister('x-light-resizable')
class XLightResizable extends PolymerElement
    with IronResizableBehavior, ObserveIronResizeBehavior {
  XLightResizable.created() : super.created();
}
