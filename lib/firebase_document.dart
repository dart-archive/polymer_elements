// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `firebase_document`.
@HtmlImport('firebase_document_nodart.html')
library polymer_elements.lib.src.polymerfire.firebase_document;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'firebase_database_behavior.dart';
import 'app_storage_behavior.dart';
import 'firebase_common_behavior.dart';
import 'app_network_status_behavior.dart';

/// The firebase-document element is an easy way to interact with a firebase
/// location as an object and expose it to the Polymer databinding system.
///
/// For example:
///
///     <firebase-document
///       path="/users/{{userId}}/notes/{{noteId}}"
///       data="{{noteData}}">
///     </firebase-document>
///
/// This fetches the `noteData` object from the firebase location at
/// `/users/${userId}/notes/${noteId}` and exposes it to the Polymer
/// databinding system. Changes to `noteData` will likewise be, sent back up
/// and stored.
///
/// `<firebase-document>` needs some information about how to talk to Firebase.
/// Set this configuration by adding a `<firebase-app>` element anywhere in your
/// app.
@CustomElementProxy('firebase-document')
class FirebaseDocument extends HtmlElement with CustomElementProxyMixin, PolymerBase, AppStorageBehavior, AppNetworkStatusBehavior, FirebaseCommonBehaviorImpl, FirebaseCommonBehavior, FirebaseDatabaseBehaviorImpl, FirebaseDatabaseBehavior {
  FirebaseDocument.created() : super.created();
  factory FirebaseDocument() => new Element.tag('firebase-document');

  get isNew => jsElement[r'isNew'];

  get zeroValue => jsElement[r'zeroValue'];

  destroy() =>
      jsElement.callMethod('destroy', []);

  getStoredValue(path) =>
      jsElement.callMethod('getStoredValue', [path]);

  memoryPathToStoragePath(path) =>
      jsElement.callMethod('memoryPathToStoragePath', [path]);

  reset() =>
      jsElement.callMethod('reset', []);

  /// Update the path and write this.data to that new location.
  ///
  /// Important note: `this.path` is updated asynchronously.
  /// [parentPath]: The new firebase location to write to.
  /// [key]: The key within the parentPath to write `data` to. If
  ///         not given, a random key will be generated and used.
  save([String parentPath, key]) => //(String parentPath, key) =>
      jsElement.callMethod('save', [parentPath, key]);

  setStoredValue(path, value) =>
      jsElement.callMethod('setStoredValue', [path, value]);

  storagePathToMemoryPath(storagePath) =>
      jsElement.callMethod('storagePathToMemoryPath', [storagePath]);
}
