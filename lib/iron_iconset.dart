// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_iconset`.
@HtmlImport('iron_iconset_nodart.html')
library polymer_elements.lib.src.iron_iconset.iron_iconset;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_meta.dart';

/// The `iron-iconset` element allows users to define their own icon sets.
/// The `src` property specifies the url of the icon image. Multiple icons may
/// be included in this image and they may be organized into rows.
/// The `icons` property is a space separated list of names corresponding to the
/// icons. The names must be ordered as the icons are ordered in the icon image.
/// Icons are expected to be square and are the size specified by the `size`
/// property. The `width` property corresponds to the width of the icon image
/// and must be specified if icons are arranged into multiple rows in the image.
///
/// All `iron-iconset` elements are available for use by other `iron-iconset`
/// elements via a database keyed by id. Typically, an element author that wants
/// to support a set of custom icons uses a `iron-iconset` to retrieve
/// and use another, user-defined iconset.
///
/// Example:
///
///     <iron-iconset id="my-icons" src="my-icons.png" width="96" size="24"
///         icons="location place starta stopb bus car train walk">
///     </iron-iconset>
///
/// This will automatically register the icon set "my-icons" to the iconset
/// database.  To use these icons from within another element, make a
/// `iron-iconset` element and call the `byId` method to retrieve a
/// given iconset. To apply a particular icon to an element, use the
/// `applyIcon` method. For example:
///
///     iconset.applyIcon(iconNode, 'car');
///
/// Themed icon sets are also supported. The `iron-iconset` can contain child
/// `property` elements that specify a theme with an offsetX and offsetY of the
/// theme within the icon resource. For example.
///
///     <iron-iconset id="my-icons" src="my-icons.png" width="96" size="24"
///         icons="location place starta stopb bus car train walk">
///       <property theme="special" offsetX="256" offsetY="24"></property>
///     </iron-iconset>
///
/// Then a themed icon can be applied like this:
///
///     iconset.applyIcon(iconNode, 'car', 'special');
@CustomElementProxy('iron-iconset')
class IronIconset extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronIconset.created() : super.created();
  factory IronIconset() => new Element.tag('iron-iconset');

  /// Array of fully-qualified names of icons in this set.
  List get iconNames => jsElement[r'iconNames'];
  set iconNames(List value) { jsElement[r'iconNames'] = (value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// A space separated list of names corresponding to icons in the iconset
  /// image file. This list must be ordered the same as the icon images
  /// in the image file.
  String get icons => jsElement[r'icons'];
  set icons(String value) { jsElement[r'icons'] = value; }

  /// The name of the iconset.
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }

  /// The size of an individual icon. Note that icons must be square.
  num get size => jsElement[r'size'];
  set size(num value) { jsElement[r'size'] = value; }

  /// The URL of the iconset image.
  String get src => jsElement[r'src'];
  set src(String value) { jsElement[r'src'] = value; }

  /// The width of the iconset image. This must only be specified if the
  /// icons are arranged into separate rows inside the image.
  num get width => jsElement[r'width'];
  set width(num value) { jsElement[r'width'] = value; }

  /// Applies an icon to the given element as a css background image. This
  /// method does not size the element, and it's usually necessary to set
  /// the element's height and width so that the background image is visible.
  /// [element]: The element to which the icon is applied.
  /// [icon]: The name or index of the icon to apply.
  /// [theme]: (optional) The name or index of the icon to apply.
  /// [scale]: (optional, defaults to 1) Icon scaling factor.
  void applyIcon(Element element, icon, String theme, num scale) =>
      jsElement.callMethod('applyIcon', [element, icon, theme, scale]);

  /// Remove an icon from the given element by undoing the changes effected
  /// by `applyIcon`.
  /// [element]: The element from which the icon is removed.
  void removeIcon(Element element) =>
      jsElement.callMethod('removeIcon', [element]);
}
