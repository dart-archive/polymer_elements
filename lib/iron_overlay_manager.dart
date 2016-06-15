@HtmlImport("iron_overlay_manager.html")
library polymer_elements.lib.src.iron_overlay_behavior.iron_overlay_manager;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:js' as js;
import 'dart:html';


class IronOverlayManager {
  static js.JsObject _js = js.context['Polymer']['IronOverlayManager'];

  static js.JsObject get jsObject => _js;

  static Element get deepActiveElement =>  convertToDart(_js['deepActiveElement']);
  static Element get backdropElement => convertToDart(_js['backdropElement']);
  static Element get currentOverlay => convertToDart(_js.callMethod('currentOverlay'));

  static num get currentOverlayZ =>convertToDart(_js.callMethod('currentOverlayZ'));

  static addOrRemoveOverlay(overlay) => _js.callMethod("addOrRemoveOverlay", [convertToJs(overlay)]);

  static addOverlay(overlay) => _js.callMethod("addOverlay", [convertToJs(overlay)]);

  static removeOverlay(overlay) => _js.callMethod("removeOverlay", [convertToJs(overlay)]);

  static ensureMinimumZ(minimumZ) => _js.callMethod("ensureMinimumZ", [minimumZ]);

  static focusOverlay() => _js.callMethod("focusOverlay");

  static trackBackdrop() => _js.callMethod("trackBackdrop");

  static List<Element> get backdrops => convertToDart(_js.callMethod("getBackdrops"));

  static num get backdropZ => _js.callMethod("backdropZ");

}