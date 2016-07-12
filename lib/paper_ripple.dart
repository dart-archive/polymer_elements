// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `paper_ripple`.
@HtmlImport('paper_ripple_nodart.html')
library polymer_elements.lib.src.paper_ripple.paper_ripple;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_a11y_keys_behavior.dart';

/// Material design: [Surface reaction](https://www.google.com/design/spec/animation/responsive-interaction.html#responsive-interaction-surface-reaction)
///
/// `paper-ripple` provides a visual effect that other paper elements can
/// use to simulate a rippling effect emanating from the point of contact.  The
/// effect can be visualized as a concentric circle with motion.
///
/// Example:
///
///     <div style="position:relative">
///       <paper-ripple></paper-ripple>
///     </div>
///
/// Note, it's important that the parent container of the ripple be relative position, otherwise
/// the ripple will emanate outside of the desired container.
///
/// `paper-ripple` listens to "mousedown" and "mouseup" events so it would display ripple
/// effect when touches on it.  You can also defeat the default behavior and
/// manually route the down and up actions to the ripple element.  Note that it is
/// important if you call `downAction()` you will have to make sure to call
/// `upAction()` so that `paper-ripple` would end the animation loop.
///
/// Example:
///
///     <paper-ripple id="ripple" style="pointer-events: none;"></paper-ripple>
///     ...
///     downAction: function(e) {
///       this.$.ripple.downAction({detail: {x: e.x, y: e.y}});
///     },
///     upAction: function(e) {
///       this.$.ripple.upAction();
///     }
///
/// Styling ripple effect:
///
///   Use CSS color property to style the ripple:
///
///     paper-ripple {
///       color: #4285f4;
///     }
///
///   Note that CSS color property is inherited so it is not required to set it on
///   the `paper-ripple` element directly.
///
/// By default, the ripple is centered on the point of contact.  Apply the `recenters`
/// attribute to have the ripple grow toward the center of its container.
///
///     <paper-ripple recenters></paper-ripple>
///
/// You can also  center the ripple inside its container from the start.
///
///     <paper-ripple center></paper-ripple>
///
/// Apply `circle` class to make the rippling effect within a circle.
///
///     <paper-ripple class="circle"></paper-ripple>
@CustomElementProxy('paper-ripple')
class PaperRipple extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronA11yKeysBehavior {
  PaperRipple.created() : super.created();
  factory PaperRipple() => new Element.tag('paper-ripple');

  /// True when there are visible ripples animating within the
  /// element.
  bool get animating => jsElement[r'animating'];
  set animating(bool value) { jsElement[r'animating'] = value; }

  /// If true, ripples will center inside its container
  bool get center => jsElement[r'center'];
  set center(bool value) { jsElement[r'center'] = value; }

  /// If true, the ripple will remain in the "down" state until `holdDown`
  /// is set to false again.
  bool get holdDown => jsElement[r'holdDown'];
  set holdDown(bool value) { jsElement[r'holdDown'] = value; }

  /// The initial opacity set on the wave.
  num get initialOpacity => jsElement[r'initialOpacity'];
  set initialOpacity(num value) { jsElement[r'initialOpacity'] = value; }

  get keyBindings => jsElement[r'keyBindings'];
  set keyBindings(value) { jsElement[r'keyBindings'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// If true, the ripple will not generate a ripple effect
  /// via pointer interaction.
  /// Calling ripple's imperative api like `simulatedRipple` will
  /// still generate the ripple effect.
  bool get noink => jsElement[r'noink'];
  set noink(bool value) { jsElement[r'noink'] = value; }

  /// How fast (opacity per second) the wave fades out.
  num get opacityDecayVelocity => jsElement[r'opacityDecayVelocity'];
  set opacityDecayVelocity(num value) { jsElement[r'opacityDecayVelocity'] = value; }

  /// If true, ripples will exhibit a gravitational pull towards
  /// the center of their container as they fade away.
  bool get recenters => jsElement[r'recenters'];
  set recenters(bool value) { jsElement[r'recenters'] = value; }

  /// A list of the visual ripples.
  List get ripples => jsElement[r'ripples'];
  set ripples(List value) { jsElement[r'ripples'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  get shouldKeepAnimating => jsElement[r'shouldKeepAnimating'];

  get target => jsElement[r'target'];

  addRipple() =>
      jsElement.callMethod('addRipple', []);

  validate([_,__]) => //() =>
      jsElement.callMethod('animate', []);

  /// Provokes a ripple down effect via a UI event,
  /// *not* respecting the `noink` property.
  downAction(event) =>
      jsElement.callMethod('downAction', [event]);

  onAnimationComplete() =>
      jsElement.callMethod('onAnimationComplete', []);

  removeRipple(ripple) =>
      jsElement.callMethod('removeRipple', [ripple]);

  simulatedRipple() =>
      jsElement.callMethod('simulatedRipple', []);

  /// Provokes a ripple down effect via a UI event,
  /// respecting the `noink` property.
  uiDownAction(event) =>
      jsElement.callMethod('uiDownAction', [event]);

  /// Provokes a ripple up effect via a UI event,
  /// respecting the `noink` property.
  uiUpAction(event) =>
      jsElement.callMethod('uiUpAction', [event]);

  /// Provokes a ripple up effect via a UI event,
  /// *not* respecting the `noink` property.
  upAction(event) =>
      jsElement.callMethod('upAction', [event]);
}
