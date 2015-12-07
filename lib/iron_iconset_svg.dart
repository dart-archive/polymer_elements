// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_iconset_svg`.
@HtmlImport('iron_iconset_svg_nodart.html')
library polymer_elements.lib.src.iron_iconset_svg.iron_iconset_svg;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_meta.dart';

/// The `iron-iconset-svg` element allows users to define their own icon sets
/// that contain svg icons. The svg icon elements should be children of the
/// `iron-iconset-svg` element. Multiple icons should be given distinct id's.
///
/// Using svg elements to create icons has a few advantages over traditional
/// bitmap graphics like jpg or png. Icons that use svg are vector based so
/// they are resolution independent and should look good on any device. They
/// are stylable via css. Icons can be themed, colorized, and even animated.
///
/// Example:
///
///     <iron-iconset-svg name="my-svg-icons" size="24">
///       <svg>
///         <defs>
///           <g id="shape">
///             <rect x="12" y="0" width="12" height="24" />
///             <circle cx="12" cy="12" r="12" />
///           </g>
///         </defs>
///       </svg>
///     </iron-iconset-svg>
///
/// This will automatically register the icon set "my-svg-icons" to the iconset
/// database.  To use these icons from within another element, make a
/// `iron-iconset` element and call the `byId` method
/// to retrieve a given iconset. To apply a particular icon inside an
/// element use the `applyIcon` method. For example:
///
///     iconset.applyIcon(iconNode, 'car');
@CustomElementProxy('iron-iconset-svg')
class IronIconsetSvg extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronIconsetSvg.created() : super.created();
  factory IronIconsetSvg() => new Element.tag('iron-iconset-svg');

  /// The name of the iconset.
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }

  /// The size of an individual icon. Note that icons must be square.
  num get size => jsElement[r'size'];
  set size(num value) { jsElement[r'size'] = value; }

  /// Applies an icon to the given element.
  ///
  /// An svg icon is prepended to the element's shadowRoot if it exists,
  /// otherwise to the element itself.
  /// [element]: Element to which the icon is applied.
  /// [iconName]: Name of the icon to apply.
  applyIcon(Element element, String iconName) =>
      jsElement.callMethod('applyIcon', [element, iconName]);

  /// Construct an array of all icon names in this iconset.
  getIconNames() =>
      jsElement.callMethod('getIconNames', []);

  /// Remove an icon from the given element by undoing the changes effected
  /// by `applyIcon`.
  /// [element]: The element from which the icon is removed.
  removeIcon(Element element) =>
      jsElement.callMethod('removeIcon', [element]);
}
