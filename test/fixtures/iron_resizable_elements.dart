@HtmlImport('iron_resizable_elements.html')
library fixture.test_elements;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'dart:html';

@PolymerRegister('x-resizer-parent')
class XResizerParent extends PolymerElement with IronResizableBehavior {
  XResizerParent.created():super.created();

  @Listen('core-resize')
  void resizeHandler([_,__]) {

  }
}

@PolymerRegister('x-resizer-parent-filtered')
class XResizerParentFiltered extends PolymerElement with IronResizableBehavior {
  XResizerParentFiltered.created():super.created();

  Element active;

  @Listen('core-resize')
  void resizeHandler([_,__]) {

  }

  @reflectable
  resizerShouldNotify(Element e) {
    return e == this.active;
  }
}

@PolymerRegister('x-resizable')
class XResizable extends PolymerElement with IronResizableBehavior {
  XResizable.created():super.created();

  @Listen('core-resize')
  void resizeHandler([_,__]) {

  }
}

@PolymerRegister('x-resizable-in-shadow')
class XResizableInShadow extends PolymerElement {
  XResizableInShadow.created():super.created();
}

@PolymerRegister('test-element')
class TestElement extends PolymerElement {
  TestElement.created():super.created();
}

@behavior
abstract class ObserveIronResizeBehavior implements IronResizableBehavior, PolymerBase, PolymerMixin  {
  @property num ironResizeCount = 0;

  @Listen('iron-resize')
  void incrementIronResizeCount([_,__]) {
    ironResizeCount++;
  }
}

@PolymerRegister('x-shadow-resizable')
class XShadowResizable extends PolymerElement with IronResizableBehavior, ObserveIronResizeBehavior {
  XShadowResizable.created():super.created();
}


@PolymerRegister('x-light-resizable')
class XLightResizable extends PolymerElement with IronResizableBehavior, ObserveIronResizeBehavior {
  XLightResizable.created():super.created();
}