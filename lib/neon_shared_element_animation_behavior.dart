// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `neon_shared_element_animation_behavior`.
@HtmlImport('neon_shared_element_animation_behavior_nodart.html')
library polymer_elements.lib.src.neon_animation.neon_shared_element_animation_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'neon_animation_behavior.dart';

/// Use `Polymer.NeonSharedElementAnimationBehavior` to implement shared element animations.
@BehaviorProxy(const ['Polymer', 'NeonSharedElementAnimationBehavior'])
abstract class NeonSharedElementAnimationBehavior implements CustomElementProxyMixin, NeonAnimationBehavior {

  /// Cached copy of shared elements.
  get sharedElements => jsElement[r'sharedElements'];
  set sharedElements(value) { jsElement[r'sharedElements'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Finds shared elements based on `config`.
  findSharedElements(config) =>
      jsElement.callMethod('findSharedElements', [config]);
}
