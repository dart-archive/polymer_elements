// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_signals`.
@HtmlImport('iron_signals_nodart.html')
library polymer_elements.lib.src.iron_signals.iron_signals;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `iron-signals` provides basic publish-subscribe functionality.
///
/// Note: avoid using `iron-signals` whenever you can use
/// a controller (parent element) to mediate communication
/// instead.
///
/// To send a signal, fire a custom event of type `iron-signal`, with
/// a detail object containing `name` and `data` fields.
///
///     this.fire('iron-signal', {name: 'hello', data: null});
///
/// To receive a signal, listen for `iron-signal-<name>` event on a
/// `iron-signals` element.
///
///   <iron-signals on-iron-signal-hello="{{helloSignal}}">
///
/// You can fire a signal event from anywhere, and all
/// `iron-signals` elements will receive the event, regardless
/// of where they are in DOM.
@CustomElementProxy('iron-signals')
class IronSignals extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronSignals.created() : super.created();
  factory IronSignals() => new Element.tag('iron-signals');
}
