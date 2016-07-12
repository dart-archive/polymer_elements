// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_box`.
@HtmlImport('app_box_nodart.html')
library polymer_elements.lib.src.app_layout.app_box.app_box;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import '../../app_layout/app_scroll_effects/app_scroll_effects_behavior.dart';
import '../../iron_scroll_target_behavior.dart';
import '../../iron_resizable_behavior.dart';
import '../../iron_flex_layout.dart';

/// app-box is a container element that can have scroll effects - visual effects based on
/// scroll position. For example, the parallax effect can be used to move an image at a slower
/// rate than the foreground.
///
/// ```html
/// <app-box style="height: 100px;" effects="parallax-background">
///   <img background src="picture.png" style="width: 100%; height: 600px;">
/// </app-box>
/// ```
///
/// Notice the `background` attribute in the `img` element; this attribute specifies that that image is used as the background.
/// By adding the background to the light dom, you can compose backgrounds that can change dynamically.
/// Alternatively, the mixin `--app-box-background-front-layer` allows to style the background. For example:
///
/// ```css
///   .parallaxAppBox {
///     --app-box-background-front-layer: {
///       background-image: url(picture.png);
///     };
///   }
/// ```
///
/// Finally, app-box can have content inside. For example:
///
/// ```html
/// <app-box effects="parallax-background">
///   <h2>Sub title</h2>
/// </app-box>
/// ```
///
/// ## Scroll effects
///
/// Effect name | Description
/// ----------------|-------------
/// `parallax-background` | A parallax effect
///
/// ## Styling
///
/// Mixin | Description | Default
/// ----------------|-------------|----------
/// `--app-box-background-front-layer` | Applies to the front layer of the background | {}
@CustomElementProxy('app-box')
class AppBox extends HtmlElement with CustomElementProxyMixin, PolymerBase, IronScrollTargetBehavior, AppScrollEffectsBehavior, IronResizableBehavior {
  AppBox.created() : super.created();
  factory AppBox() => new Element.tag('app-box');

  /// Returns an object containing the progress value of the scroll effects.
  getScrollState() =>
      jsElement.callMethod('getScrollState', []);

  /// Returns true if this app-box is on the screen.
  /// That is, visible in the current viewport.
  bool isOnScreen() =>
      jsElement.callMethod('isOnScreen', []);

  /// Resets the layout. This method is automatically called when the element is attached to the DOM.
  resetLayout() =>
      jsElement.callMethod('resetLayout', []);
}
