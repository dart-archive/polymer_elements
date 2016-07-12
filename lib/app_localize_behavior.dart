// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_localize_behavior`.
@HtmlImport('app_localize_behavior_nodart.html')
library polymer_elements.lib.src.app_localize_behavior.app_localize_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'iron_ajax.dart';

/// `Polymer.AppLocalizeBehavior` wraps the [format.js](http://formatjs.io/) library to
/// help you internationalize your application. Note that if you're on a browser that
/// does not natively support the [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl)
/// object, you must load the polyfill yourself. An example polyfill can
/// be found [here](https://github.com/andyearnshaw/Intl.js/).
///
/// `Polymer.AppLocalizeBehavior` supports the same [message-syntax](http://formatjs.io/guides/message-syntax/)
/// of format.js, in its entirety; use the library docs as reference for the
/// available message formats and options.
///
/// Sample application loading resources from an external file:
///
///     <dom-module id="x-app">
///        <template>
///         <div>{{localize('hello', 'Batman')}}</div>
///        </template>
///        <script>
///           Polymer({
///             is: "x-app",
///
///             behaviors: [
///               Polymer.AppLocalizeBehavior
///             ],
///
///             properties: {
///               language: {
///                 value: 'en'
///               },
///             }
///
///             attached: function() {
///               this.loadResources(this.resolveUrl('locales.json'));
///             },
///           });
///        &lt;/script>
///     </dom-module>
///
/// Alternatively, you can also inline your resources inside the app itself:
///
///     <dom-module id="x-app">
///        <template>
///         <div>{{localize('hello', 'Batman')}}</div>
///        </template>
///        <script>
///           Polymer({
///             is: "x-app",
///
///             behaviors: [
///               Polymer.AppLocalizeBehavior
///             ],
///
///             properties: {
///               language: {
///                 value: 'en'
///               },
///               resources: {
///                 value: function() {
///                   return {
///                     'en': { 'hello': 'My name is {name}.' },
///                     'fr': { 'hello': 'Je m\'apelle {name}.' }
///                   }
///               }
///             }
///           });
///        &lt;/script>
///     </dom-module>
@BehaviorProxy(const ['Polymer', 'AppLocalizeBehavior'])
abstract class AppLocalizeBehavior implements CustomElementProxyMixin {

  /// Optional dictionary of user defined formats, as explained here:
  /// http://formatjs.io/guides/message-syntax/#custom-formats
  ///
  /// For example, a valid dictionary of formats would be:
  /// this.formats = {
  ///    number: { USD: { style: 'currency', currency: 'USD' } }
  /// }
  get formats => jsElement[r'formats'];
  set formats(value) { jsElement[r'formats'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The language used for translation.
  String get language => jsElement[r'language'];
  set language(String value) { jsElement[r'language'] = value; }

  /// Translates a string to the current `language`. Any parameters to the
  /// string should be passed in order, as follows:
  /// `localize(stringKey, param1Name, param1Value, param2Name, param2Value)`
  get localize => jsElement[r'localize'];
  set localize(value) { jsElement[r'localize'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// The path to the dictionary of localized messages. The format is the
  /// same as the `resources` array, only saved as an external json file.
  /// Note that using a path will populate the `resources` property, and override
  /// the previous data.
  String get pathToResources => jsElement[r'pathToResources'];
  set pathToResources(String value) { jsElement[r'pathToResources'] = value; }

  /// The dictionary of localized messages, for each of the languages that
  /// are going to be used. See http://formatjs.io/guides/message-syntax/ for
  /// more information on the message syntax.
  ///
  /// For example, a valid dictionary would be:
  /// this.resources = {
  ///  'en': { 'greeting': 'Hello!' }, 'fr' : { 'greeting': 'Bonjour!' }
  /// }
  get resources => jsElement[r'resources'];
  set resources(value) { jsElement[r'resources'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  loadResources(path) =>
      jsElement.callMethod('loadResources', [path]);
}
