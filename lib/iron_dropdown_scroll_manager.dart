@HtmlImport('iron_dropdown_scroll_manager.html')
library polymer_elements.lib.src.iron_dropdown.iron_dropdown_scroll_manager;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:js';
import 'dart:html';

class IronDropdownScrollManager {
  static final _jsElement = context['Polymer']['IronDropdownScrollManager'];

  static JsObject get jsProxy => _jsElement;

  static Element get  currentLockingElement => _jsElement['currentLockingElement'];

  static bool elementIsScrollLocked(Element e) => _jsElement.callMethod('elementIsScrollLocked',[e]);

  static void pushScrollLock(Element e) => _jsElement.callMethod('pushScrollLock',[e]);

  static void removeScrollLock(Element e) => _jsElement.callMethod('removeScrollLock',[e]);

}