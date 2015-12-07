// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_meta`.
@HtmlImport('iron_meta_nodart.html')
library polymer_elements.lib.src.iron_meta.iron_meta;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `iron-meta` is a generic element you can use for sharing information across the DOM tree.
/// It uses [monostate pattern](http://c2.com/cgi/wiki?MonostatePattern) such that any
/// instance of iron-meta has access to the shared
/// information. You can use `iron-meta` to share whatever you want (or create an extension
/// [like x-meta] for enhancements).
///
/// The `iron-meta` instances containing your actual data can be loaded in an import,
/// or constructed in any way you see fit. The only requirement is that you create them
/// before you try to access them.
///
/// Examples:
///
/// If I create an instance like this:
///
///     <iron-meta key="info" value="foo/bar"></iron-meta>
///
/// Note that value="foo/bar" is the metadata I've defined. I could define more
/// attributes or use child nodes to define additional metadata.
///
/// Now I can access that element (and it's metadata) from any iron-meta instance
/// via the byKey method, e.g.
///
///     meta.byKey('info').getAttribute('value');
///
/// Pure imperative form would be like:
///
///     document.createElement('iron-meta').byKey('info').getAttribute('value');
///
/// Or, in a Polymer element, you can include a meta in your template:
///
///     <iron-meta id="meta"></iron-meta>
///     ...
///     this.$.meta.byKey('info').getAttribute('value');
@CustomElementProxy('iron-meta')
class IronMeta extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronMeta.created() : super.created();
  factory IronMeta() => new Element.tag('iron-meta');

  /// The key used to store `value` under the `type` namespace.
  String get key => jsElement[r'key'];
  set key(String value) { jsElement[r'key'] = value; }

  /// Array of all meta-data values for the given type.
  List get list => jsElement[r'list'];
  set list(List value) { jsElement[r'list'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// If true, `value` is set to the iron-meta instance itself.
  bool get self => jsElement[r'self'];
  set self(bool value) { jsElement[r'self'] = value; }

  /// The type of meta-data.  All meta-data of the same type is stored
  /// together.
  String get type => jsElement[r'type'];
  set type(String value) { jsElement[r'type'] = value; }

  /// The meta-data to store or retrieve.
  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Retrieves meta data value by key.
  /// [key]: The key of the meta-data to be returned.
  byKey(String key) =>
      jsElement.callMethod('byKey', [key]);

  /// Only runs if someone invokes the factory/constructor directly
  /// e.g. `new Polymer.IronMeta()`
  factoryImpl(config) =>
      jsElement.callMethod('factoryImpl', [config]);
}



/// `iron-meta` is a generic element you can use for sharing information across the DOM tree.
/// It uses [monostate pattern](http://c2.com/cgi/wiki?MonostatePattern) such that any
/// instance of iron-meta has access to the shared
/// information. You can use `iron-meta` to share whatever you want (or create an extension
/// [like x-meta] for enhancements).
///
/// The `iron-meta` instances containing your actual data can be loaded in an import,
/// or constructed in any way you see fit. The only requirement is that you create them
/// before you try to access them.
///
/// Examples:
///
/// If I create an instance like this:
///
///     <iron-meta key="info" value="foo/bar"></iron-meta>
///
/// Note that value="foo/bar" is the metadata I've defined. I could define more
/// attributes or use child nodes to define additional metadata.
///
/// Now I can access that element (and it's metadata) from any iron-meta instance
/// via the byKey method, e.g.
///
///     meta.byKey('info').getAttribute('value');
///
/// Pure imperative form would be like:
///
///     document.createElement('iron-meta').byKey('info').getAttribute('value');
///
/// Or, in a Polymer element, you can include a meta in your template:
///
///     <iron-meta id="meta"></iron-meta>
///     ...
///     this.$.meta.byKey('info').getAttribute('value');
@CustomElementProxy('iron-meta-query')
class IronMetaQuery extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronMetaQuery.created() : super.created();
  factory IronMetaQuery() => new Element.tag('iron-meta-query');

  /// Specifies a key to use for retrieving `value` from the `type`
  /// namespace.
  String get key => jsElement[r'key'];
  set key(String value) { jsElement[r'key'] = value; }

  /// Array of all meta-data values for the given type.
  List get list => jsElement[r'list'];
  set list(List value) { jsElement[r'list'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The type of meta-data.  All meta-data of the same type is stored
  /// together.
  String get type => jsElement[r'type'];
  set type(String value) { jsElement[r'type'] = value; }

  /// The meta-data to store or retrieve.
  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Retrieves meta data value by key.
  /// [key]: The key of the meta-data to be returned.
  byKey(String key) =>
      jsElement.callMethod('byKey', [key]);

  /// Actually a factory method, not a true constructor. Only runs if
  /// someone invokes it directly (via `new Polymer.IronMeta()`);
  factoryImpl(config) =>
      jsElement.callMethod('factoryImpl', [config]);
}
