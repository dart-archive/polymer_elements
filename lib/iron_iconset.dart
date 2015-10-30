// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_iconset`.
@HtmlImport('iron_iconset_nodart.html')
library polymer_elements.lib.src.iron_iconset.iron_iconset;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_meta.dart';


@CustomElementProxy('iron-iconset')
class IronIconset extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronIconset.created() : super.created();
  factory IronIconset() => new Element.tag('iron-iconset');

  /// Array of fully-qualified names of icons in this set.
  List get iconNames => jsElement[r'iconNames'];
  set iconNames(List value) { jsElement[r'iconNames'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

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
  applyIcon(Element element, icon, theme, scale) =>
      jsElement.callMethod('applyIcon', [element, icon, theme, scale]);

  /// Remove an icon from the given element by undoing the changes effected
  /// by `applyIcon`.
  /// [element]: The element from which the icon is removed.
  removeIcon(Element element) =>
      jsElement.callMethod('removeIcon', [element]);
}
