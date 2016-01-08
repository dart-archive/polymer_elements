// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_a11y_announcer`.
@HtmlImport('iron_a11y_announcer_nodart.html')
library polymer_elements.lib.src.iron_a11y_announcer.iron_a11y_announcer;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `iron-a11y-announcer` is a singleton element that is intended to add a11y
/// to features that require on-demand announcement from screen readers. In
/// order to make use of the announcer, it is best to request its availability
/// in the announcing element.
///
/// Example:
///
///     Polymer({
///
///       is: 'x-chatty',
///
///       attached: function() {
///         // This will create the singleton element if it has not
///         // been created yet:
///         Polymer.IronA11yAnnouncer.requestAvailability();
///       }
///     });
///
/// After the `iron-a11y-announcer` has been made available, elements can
/// make announces by firing bubbling `iron-announce` events.
///
/// Example:
///
///     this.fire('iron-announce', {
///       text: 'This is an announcement!'
///     }, { bubbles: true });
///
/// Note: announcements are only audible if you have a screen reader enabled.
@CustomElementProxy('iron-a11y-announcer')
class IronA11yAnnouncer extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronA11yAnnouncer.created() : super.created();
  factory IronA11yAnnouncer() => new Element.tag('iron-a11y-announcer');

  /// The value of mode is used to set the `aria-live` attribute
  /// for the element that will be announced. Valid values are: `off`,
  /// `polite` and `assertive`.
  String get mode => jsElement[r'mode'];
  set mode(String value) { jsElement[r'mode'] = value; }

  /// Cause a text string to be announced by screen readers.
  /// [text]: The text that should be announced.
  announce(String text) =>
      jsElement.callMethod('announce', [text]);
}
