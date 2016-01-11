// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_localstorage`.
@HtmlImport('iron_localstorage_nodart.html')
library polymer_elements.lib.src.iron_localstorage.iron_localstorage;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// Element access to Web Storage API (window.localStorage).
///
/// Keeps `value` property in sync with localStorage.
///
/// Value is saved as json by default.
///
/// ### Usage:
///
/// `ls-sample` will automatically save changes to its value.
///
///     <dom-module id="ls-sample">
///       <iron-localstorage name="my-app-storage"
///         value="{{cartoon}}"
///         on-iron-localstorage-load-empty="initializeDefaultCartoon"
///       ></iron-localstorage>
///     </dom-module>
///
///     <script>
///       Polymer({
///         is: 'ls-sample',
///         properties: {
///           cartoon: {
///             type: Object
///           }
///         },
///         // initializes default if nothing has been stored
///         initializeDefaultCartoon: function() {
///           this.cartoon = {
///             name: "Mickey",
///             hasEars: true
///           }
///         },
///         // use path set api to propagate changes to localstorage
///         makeModifications: function() {
///           this.set('cartoon.name', "Minions");
///           this.set('cartoon.hasEars', false);
///         }
///       });
///     </script>
///
/// ### Tech notes:
///
/// * `value.*` is observed, and saved on modifications. You must use
///     path change notifification methods such as `set()` to modify value
///     for changes to be observed.
///
/// * Set `auto-save-disabled` to prevent automatic saving.
///
/// * Value is saved as JSON by default.
///
/// * To delete a key, set value to null
///
/// Element listens to StorageAPI `storage` event, and will reload upon receiving it.
///
/// **Warning**: do not bind value to sub-properties until Polymer
/// [bug 1550](https://github.com/Polymer/polymer/issues/1550)
/// is resolved. Local storage will be blown away.
/// `<iron-localstorage value="{{foo.bar}}"` will cause **data loss**.
@CustomElementProxy('iron-localstorage')
class IronLocalstorage extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  IronLocalstorage.created() : super.created();
  factory IronLocalstorage() => new Element.tag('iron-localstorage');

  /// Value will not be saved automatically if true. You'll have to do it manually with `save()`
  bool get autoSaveDisabled => jsElement[r'autoSaveDisabled'];
  set autoSaveDisabled(bool value) { jsElement[r'autoSaveDisabled'] = value; }

  /// Last error encountered while saving/loading items
  String get errorMessage => jsElement[r'errorMessage'];
  set errorMessage(String value) { jsElement[r'errorMessage'] = value; }

  /// localStorage item key
  String get name => jsElement[r'name'];
  set name(String value) { jsElement[r'name'] = value; }

  /// If true: do not convert value to JSON on save/load
  bool get useRaw => jsElement[r'useRaw'];
  set useRaw(bool value) { jsElement[r'useRaw'] = value; }

  /// The data associated with this storage.
  /// If set to null item will be deleted.
  get value => jsElement[r'value'];
  set value(value) { jsElement[r'value'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Loads the value again. Use if you modify
  /// localStorage using DOM calls, and want to
  /// keep this element in sync.
  reload() =>
      jsElement.callMethod('reload', []);

  /// Saves the value to localStorage. Call to save if autoSaveDisabled is set.
  /// If `value` is null or undefined, deletes localStorage.
  save() =>
      jsElement.callMethod('save', []);
}
