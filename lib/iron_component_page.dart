// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_component_page`.
@HtmlImport('iron_component_page_nodart.html')
library polymer_elements.lib.src.iron_component_page.iron_component_page;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'hydrolysis_analyzer.dart';
import 'iron_ajax.dart';
import 'iron_doc_viewer.dart';
import 'iron_flex_layout.dart';
import 'iron_icons.dart';
import 'iron_selector.dart';
import 'paper_header_panel.dart';
import 'color.dart';
import 'typography.dart';
import 'paper_toolbar.dart';

/// Loads Polymer element and behavior documentation using
/// [Hydrolysis](https://github.com/PolymerLabs/hydrolysis) and renders a complete
/// documentation page including demos (if available).
@CustomElementProxy('iron-component-page')
class IronComponentPage extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronComponentPage.created() : super.created();
  factory IronComponentPage() => new Element.tag('iron-component-page');

  /// The element or behavior that will be displayed on the page. Defaults
  /// to the element matching the name of the source file.
  String get active => jsElement[r'active'];
  set active(String value) { jsElement[r'active'] = value; }

  /// The relative root for determining paths to demos and default source
  /// detection.
  String get base => jsElement[r'base'];
  set base(String value) { jsElement[r'base'] = value; }

  /// Toggle flag to be used when this element is being displayed in the
  /// Polymer Elements catalog.
  bool get catalog => jsElement[r'catalog'];
  set catalog(bool value) { jsElement[r'catalog'] = value; }

  /// The Hydrolysis behavior descriptors that have been loaded.
  List get docBehaviors => jsElement[r'docBehaviors'];
  set docBehaviors(List value) { jsElement[r'docBehaviors'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// Demos for the currently selected element.
  List get docDemos => jsElement[r'docDemos'];
  set docDemos(List value) { jsElement[r'docDemos'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The Hydrolysis element descriptors that have been loaded.
  List get docElements => jsElement[r'docElements'];
  set docElements(List value) { jsElement[r'docElements'] = (value != null && value is! JsArray) ? new JsObject.jsify(value) : value;}

  /// The URL to a precompiled JSON descriptor. If you have precompiled
  /// and stored a documentation set using Hydrolysis, you can load the
  /// analyzer directly via AJAX by specifying this attribute.
  ///
  /// If a `doc-src` is not specified, it is ignored and the default
  /// rules according to the `src` attribute are used.
  String get docSrc => jsElement[r'docSrc'];
  set docSrc(String value) { jsElement[r'docSrc'] = value; }

  /// The scroll mode for the page. For details about the modes,
  /// see the mode property in paper-header-panel.
  String get scrollMode => jsElement[r'scrollMode'];
  set scrollMode(String value) { jsElement[r'scrollMode'] = value; }

  /// The URL to an import that declares (or transitively imports) the
  /// elements that you wish to see documented.
  ///
  /// If the URL is relative, it will be resolved relative to the master
  /// document.
  ///
  /// If a `src` URL is not specified, it will resolve the name of the
  /// directory containing this element, followed by `dirname.html`. For
  /// example:
  ///
  /// `awesome-sauce/index.html`:
  ///
  ///     <iron-doc-viewer></iron-doc-viewer>
  ///
  /// Would implicitly have `src="awesome-sauce.html"`.
  String get src => jsElement[r'src'];
  set src(String value) { jsElement[r'src'] = value; }

  /// Whether _all_ dependencies should be loaded and documented.
  ///
  /// Turning this on will probably slow down the load process dramatically.
  bool get transitive => jsElement[r'transitive'];
  set transitive(bool value) { jsElement[r'transitive'] = value; }

  /// An optional version string.
  String get version => jsElement[r'version'];
  set version(String value) { jsElement[r'version'] = value; }

  /// The current view. Can be `docs` or `demo`.
  String get view => jsElement[r'view'];
  set view(String value) { jsElement[r'view'] = value; }

  /// Renders this element into static HTML for offline use.
  ///
  /// This is mostly useful for debugging and one-off documentation generation.
  /// If you want to integrate doc generation into your build process, you
  /// probably want to be calling `hydrolysis.Analyzer.analyze()` directly.
  String marshal() =>
      jsElement.callMethod('marshal', []);
}
