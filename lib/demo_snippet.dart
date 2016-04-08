// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `demo_snippet`.
@HtmlImport('demo_snippet_nodart.html')
library polymer_elements.lib.src.iron_demo_helpers.demo_snippet;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_icons.dart';
import 'marked_element.dart';
import 'paper_icon_button.dart';
import 'color.dart';
import 'shadow.dart';
import 'prism_highlighter.dart';

/// `demo-snippet` is a helper element that displays the source of a code snippet and
/// its rendered demo. It can be used for both native elements and
/// Polymer elements.
///
///     Example of a native element demo
///
///         <demo-snippet>
///           <template>
///             <input type="date">
///           </template>
///         </demo-snippet>
///
///     Example of a Polymer <paper-checkbox> demo
///
///         <demo-snippet>
///           <template>
///             <paper-checkbox>Checkbox</paper-checkbox>
///             <paper-checkbox checked>Checkbox</paper-checkbox>
///           </template>
///         </demo-snippet>
///
/// ### Styling
///
/// The following custom properties and mixins are available for styling:
///
/// Custom property | Description | Default
/// ----------------|-------------|----------
/// `--demo-snippet` | Mixin applied to the entire element | `{}`
/// `--demo-snippet-demo` | Mixin applied to just the demo section | `{}`
/// `--demo-snippet-code` | Mixin applied to just the code section | `{}`
@CustomElementProxy('demo-snippet')
class DemoSnippet extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  DemoSnippet.created() : super.created();
  factory DemoSnippet() => new Element.tag('demo-snippet');
}
