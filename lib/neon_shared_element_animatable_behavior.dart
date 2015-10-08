// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `neon_shared_element_animatable_behavior`.
@HtmlImport('neon_shared_element_animatable_behavior_nodart.html')
library polymer_elements.lib.src.neon_animation.neon_shared_element_animatable_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'neon_animatable_behavior.dart';

/// Use `Polymer.NeonSharedElementAnimatableBehavior` to implement elements containing shared element
/// animations.
@BehaviorProxy(const ['Polymer', 'NeonSharedElementAnimatableBehavior'])
abstract class NeonSharedElementAnimatableBehavior implements CustomElementProxyMixin, NeonAnimatableBehavior {

  /// A map of shared element id to node.
  get sharedElements => jsElement[r'sharedElements'];
  set sharedElements(value) { jsElement[r'sharedElements'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}
}
