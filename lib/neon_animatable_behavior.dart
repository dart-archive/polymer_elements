// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `neon_animatable_behavior`.
@HtmlImport('neon_animatable_behavior_nodart.html')
library polymer_elements.lib.src.neon_animation.neon_animatable_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `Polymer.NeonAnimatableBehavior` is implemented by elements containing animations for use with
/// elements implementing `Polymer.NeonAnimationRunnerBehavior`.
@BehaviorProxy(const ['Polymer', 'NeonAnimatableBehavior'])
abstract class NeonAnimatableBehavior implements CustomElementProxyMixin {

  /// Animation configuration. See README for more info.
  get animationConfig => jsElement[r'animationConfig'];
  set animationConfig(value) { jsElement[r'animationConfig'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Convenience property for setting an 'entry' animation. Do not set `animationConfig.entry`
  /// manually if using this. The animated node is set to `this` if using this property.
  String get entryAnimation => jsElement[r'entryAnimation'];
  set entryAnimation(String value) { jsElement[r'entryAnimation'] = value; }

  /// Convenience property for setting an 'exit' animation. Do not set `animationConfig.exit`
  /// manually if using this. The animated node is set to `this` if using this property.
  String get exitAnimation => jsElement[r'exitAnimation'];
  set exitAnimation(String value) { jsElement[r'exitAnimation'] = value; }

  /// An element implementing `Polymer.NeonAnimationRunnerBehavior` calls this method to configure
  /// an animation with an optional type. Elements implementing `Polymer.NeonAnimatableBehavior`
  /// should define the property `animationConfig`, which is either a configuration object
  /// or a map of animation type to array of configuration objects.
  getAnimationConfig(type) =>
      jsElement.callMethod('getAnimationConfig', [type]);
}
