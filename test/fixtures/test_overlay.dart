@HtmlImport('test_overlay.html')
library polymer_elements.test.fixtures.test_overlay;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_fit_behavior.dart';
import 'package:polymer_elements/iron_overlay_behavior.dart';
import 'package:polymer_elements/iron_resizable_behavior.dart';
import 'package:web_components/web_components.dart';
import 'package:polymer_elements/iron_overlay_backdrop.dart';
import 'dart:html';
import 'dart:js';

@PolymerRegister('test-overlay')
class TestOverlay extends PolymerElement
    with IronFitBehavior, IronResizableBehavior, IronOverlayBehavior {

  JsFunction _origRenderOpenend;
  JsFunction _origRenderClosed;

  TestOverlay.created() : super.created() {

    _origRenderOpenend = jsElement['_renderOpened'];
    jsElement['_renderOpened'] = () {
      this.__renderOpened();
    };

    _origRenderClosed = jsElement['_renderClosed'];
    jsElement['_renderClosed'] = () {
      this.__renderClosed();
    };

  }

  @Property(reflectToAttribute: true) bool animated = false;

  __renderOpened() {
    if (this.animated) {
      if (true==this.withBackdrop) {
        (this.backdropElement as IronOverlayBackdrop).open();
      }
      this.classes.add('opened');
      this.fire('simple-overlay-open-animation-start');
    } else {

      _origRenderOpenend.apply([],thisArg:this.jsElement);
      //Polymer.IronOverlayBehaviorImpl._renderOpened.apply(this, arguments);
    }
  }

  __renderClosed() {
    if (this.animated) {
      if (true==this.withBackdrop) {
        (this.backdropElement as IronOverlayBackdrop).close();
      }
      this.classes.remove('opened');
      this.fire('simple-overlay-close-animation-start');
    } else {
      _origRenderClosed.apply([],thisArg:this.jsElement);
      //Polymer.IronOverlayBehaviorImpl._renderClosed.apply(this, arguments);
    }
  }

  @Listen('transitionend')
  myOnTransitionEnd(Event e) {
    if (e!=null && e.target == this) {
      if (this.opened) {
        this.jsElement.callMethod('_finishRenderOpened');
      } else {
        this.jsElement.callMethod('_finishRenderClosed');
      }
    }
  }



}
