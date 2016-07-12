// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_icon`.
@HtmlImport('iron_icon_nodart.html')
library polymer_elements.lib.src.iron_icon.iron_icon;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_meta.dart';
import 'iron_flex_layout.dart';

/// The `iron-icon` element displays an icon. By default an icon renders as a 24px square.
///
/// Example using src:
///
///     <iron-icon src="star.png"></iron-icon>
///
/// Example setting size to 32px x 32px:
///
///     <iron-icon class="big" src="big_star.png"></iron-icon>
///
///     <style is="custom-style">
///       .big {
///         --iron-icon-height: 32px;
///         --iron-icon-width: 32px;
///       }
///     </style>
///
/// The iron elements include several sets of icons.
/// To use the default set of icons, import `iron-icons.html` and use the `icon` attribute to specify an icon:
///
///     <link rel="import" href="/components/iron-icons/iron-icons.html">
///
///     <iron-icon icon="menu"></iron-icon>
///
/// To use a different built-in set of icons, import the specific `iron-icons/<iconset>-icons.html`, and
/// specify the icon as `<iconset>:<icon>`. For example, to use a communication icon, you would
/// use:
///
///     <link rel="import" href="/components/iron-icons/communication-icons.html">
///
///     <iron-icon icon="communication:email"></iron-icon>
///
/// You can also create custom icon sets of bitmap or SVG icons.
///
/// Example of using an icon named `cherry` from a custom iconset with the ID `fruit`:
///
///     <iron-icon icon="fruit:cherry"></iron-icon>
///
/// See [iron-iconset](iron-iconset) and [iron-iconset-svg](iron-iconset-svg) for more information about
/// how to create a custom iconset.
///
/// See the [iron-icons demo](iron-icons?view=demo:demo/index.html) to see the icons available
/// in the various iconsets.
///
/// To load a subset of icons from one of the default `iron-icons` sets, you can
/// use the [poly-icon](https://poly-icon.appspot.com/) tool. It allows you
/// to select individual icons, and creates an iconset from them that you can
/// use directly in your elements.
///
/// ### Styling
///
/// The following custom properties are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--iron-icon-width` | Width of the icon | `24px`
/// `--iron-icon-height` | Height of the icon | `24px`
/// `--iron-icon-fill-color` | Fill color of the svg icon | `currentcolor`
/// `--iron-icon-stroke-color` | Stroke color of the svg icon | none
@CustomElementProxy('iron-icon')
class IronIcon extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronIcon.created() : super.created();
  factory IronIcon() => new Element.tag('iron-icon');

  /// The name of the icon to use. The name should be of the form:
  /// `iconset_name:icon_name`.
  String get icon => jsElement[r'icon'];
  set icon(String value) { jsElement[r'icon'] = value; }

  /// If using iron-icon without an iconset, you can set the src to be
  /// the URL of an individual icon image file. Note that this will take
  /// precedence over a given icon attribute.
  String get src => jsElement[r'src'];
  set src(String value) { jsElement[r'src'] = value; }

  /// The name of the theme to used, if one is specified by the
  /// iconset.
  String get theme => jsElement[r'theme'];
  set theme(String value) { jsElement[r'theme'] = value; }
}
