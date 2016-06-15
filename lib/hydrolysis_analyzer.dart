// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `hydrolysis_analyzer`.
@HtmlImport('hydrolysis_analyzer_nodart.html')
library polymer_elements.lib.src.hydrolysis.hydrolysis_analyzer;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';


@CustomElementProxy('hydrolysis-analyzer')
class HydrolysisAnalyzer extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  HydrolysisAnalyzer.created() : super.created();
  factory HydrolysisAnalyzer() => new Element.tag('hydrolysis-analyzer');

  /// The resultant `Analyzer` object from Hydrolysis.
  get analyzer => jsElement[r'analyzer'];
  set analyzer(value) { jsElement[r'analyzer'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Whether the hydrolysis descriptors should be cleaned of redundant
  /// properties.
  bool get clean => jsElement[r'clean'];
  set clean(bool value) { jsElement[r'clean'] = value; }

  /// Whether the analyzer is loading/analyzing resources.
  bool get loading => jsElement[r'loading'];
  set loading(bool value) { jsElement[r'loading'] = value; }

  String get resolver => jsElement[r'resolver'];
  set resolver(String value) { jsElement[r'resolver'] = value; }

  /// The URL to an import that declares (or transitively imports) the
  /// elements that you wish to see analyzed.
  ///
  /// If the URL is relative, it will be resolved relative to the master
  /// document.
  ///
  /// If you change this value after the `<hydrolysis-analyzer>` has been
  /// instantiated, you must call `analyze()`.
  String get src => jsElement[r'src'];
  set src(String value) { jsElement[r'src'] = value; }

  /// Whether _all_ dependencies should be loaded and analyzed.
  ///
  /// Turning this on will probably slow down the load process dramatically.
  bool get transitive => jsElement[r'transitive'];
  set transitive(bool value) { jsElement[r'transitive'] = value; }

  /// Begins loading the imports referenced by `src`.
  ///
  /// If you make changes to this element's configuration, you must call this
  /// function to kick off another analysis pass.
  analyze() =>
      jsElement.callMethod('analyze', []);
}
