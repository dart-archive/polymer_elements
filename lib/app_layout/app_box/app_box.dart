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
/// Notice the `background` attribute in the `img` element; this attribute specifies that that
/// image is used as the background. By adding the background to the light dom, you can compose
/// backgrounds that can change dynamically. Alternatively, the mixin `--app-box-background-front-layer`
/// allows to style the background. For example:
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
/// #### Importing the effects
///
/// To use the scroll effects, you must explicitly import them in addition to `app-box`:
///
/// ```html
/// <link rel="import" href="/bower_components/app-layout/app-scroll-effects/app-scroll-effects.html">
/// ```
///
/// #### List of effects
///
/// **parallax-background**
/// A simple parallax effect that vertically translates the backgrounds based on a fraction
/// of the scroll position. For example:
///
/// ```css
/// app-header {
///   --app-header-background-front-layer: {
///     background-image: url(...);
///   };
/// }
/// ```
/// ```html
/// <app-header style="height: 300px;" effects="parallax-background">
///   <app-toolbar>App name</app-toolbar>
/// </app-header>
/// ```
///
/// The fraction determines how far the background moves relative to the scroll position.
/// This value can be assigned via the `scalar` config value and it is typically a value
/// between 0 and 1 inclusive. If `scalar=0`, the background doesn't move away from the header.
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
