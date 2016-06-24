// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `app_storage_behavior`.
@HtmlImport('app_storage_behavior_nodart.html')
library polymer_elements.lib.src.app_storage.app_storage_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// AppStorageBehavior is an abstract behavior that makes it easy to
/// synchronize in-memory data and a persistant storage system, such as
/// the browser's IndexedDB, or a remote database like Firebase.
///
/// For examples of how to use this behavior to write your own app storage
/// elements see `<app-localstorage-document>` here, or check out
/// [polymerfire](https://github.com/Firebase/polymerfire) and
/// [app-pouchdb](https://github.com/PolymerElements/app-pouchdb).
@BehaviorProxy(const ['Polymer', 'AppStorageBehavior'])
abstract class AppStorageBehavior implements CustomElementProxyMixin {

  /// The data to synchronize.
  get data => jsElement[r'data'];
  set data(value) { jsElement[r'data'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Override this getter to return true if the value has never been
  /// persisted to storage.
  bool get isNew => jsElement[r'isNew'];
  set isNew(bool value) { jsElement[r'isNew'] = value; }

  /// When true, will perform detailed logging.
  bool get log => jsElement[r'log'];
  set log(bool value) { jsElement[r'log'] = value; }

  /// If this is true transactions will happen one after the other,
  /// never in parallel.
  ///
  /// Specifically, no transaction will begin until every previously
  /// enqueued transaction by this element has completed.
  ///
  /// If it is false, new transactions will be executed as they are
  /// received.
  bool get sequentialTransactions => jsElement[r'sequentialTransactions'];
  set sequentialTransactions(bool value) { jsElement[r'sequentialTransactions'] = value; }

  /// A promise that will resolve once all queued transactions
  /// have completed.
  ///
  /// This field is updated as new transactions are enqueued, so it will
  /// only wait for transactions which were enqueued when the field
  /// was accessed.
  ///
  /// This promise never rejects.
  get transactionsComplete => jsElement[r'transactionsComplete'];
  set transactionsComplete(value) { jsElement[r'transactionsComplete'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Override this getter to define the default value to use when
  /// there's no data stored.
  get zeroValue => jsElement[r'zeroValue'];
  set zeroValue(value) { jsElement[r'zeroValue'] = (value is Map || (value is Iterable && value is! JsArray)) ? new JsObject.jsify(value) : value;}

  /// Remove the data from storage.
  destroy() =>
      jsElement.callMethod('destroy', []);

  /// Override this method to implement reading a value from storage.
  /// [storagePath]: The path (through storage) of the value to
  ///       create, relative to the root of storage associated with this instance.
  getStoredValue(String storagePath) =>
      jsElement.callMethod('getStoredValue', [storagePath]);

  /// Perform the initial sync between storage and memory. This method
  /// is called automatically while the element is being initialized.
  /// Implementations may override it.
  ///
  /// If an implementation intends to call this method, it should instead
  /// call _initializeStoredValue, which provides reentrancy protection.
  initializeStoredValue() =>
      jsElement.callMethod('initializeStoredValue', []);

  /// Maps a Polymer databinding path to the corresponding path in the
  /// storage system. Override to define a custom mapping.
  ///
  /// The inverse of storagePathToMemoryPath.
  /// [path]: An in-memory path through a storage object.
  String memoryPathToStoragePath(String path) =>
      jsElement.callMethod('memoryPathToStoragePath', [path]);

  /// Optional. Override this method to clear out the mapping of this
  /// storage object and a logical location within storage.
  ///
  /// If this method is supported, after it's called, isNew() should be
  /// true.
  reset() =>
      jsElement.callMethod('reset', []);

  /// Override this method.
  ///
  /// If the data value represented by this storage instance is new, this
  /// method generates an attempt to write the value to storage.
  save() =>
      jsElement.callMethod('save', []);

  /// Override this method to implement creating and updating
  /// stored values.
  /// [storagePath]: The path of the value to update, relative
  ///       to the root storage path configured for this instance.
  /// [value]: The updated in-memory value to apply to the stored value
  ///       at the provided path.
  setStoredValue(String storagePath, value) =>
      jsElement.callMethod('setStoredValue', [storagePath, value]);

  /// Maps a storage path to the corresponding Polymer databinding path.
  /// Override to define a custom mapping.
  ///
  /// The inverse of memoryPathToStoragePath.
  /// [path]: The storage path through a storage object.
  String storagePathToMemoryPath(String path) =>
      jsElement.callMethod('storagePathToMemoryPath', [path]);

  /// Enables performing transformations on the in-memory representation of
  /// storage without activating observers that will cause those
  /// transformations to be re-applied to the storage backend. This is useful
  /// for preventing redundant (or cyclical) application of transformations.
  /// [operation]: A function that will perform the desired
  ///       transformation. It will be called synchronously, when it is safe to
  ///       apply the transformation.
  syncToMemory(operation) =>
      jsElement.callMethod('syncToMemory', [operation]);

  /// A convenience method. Returns true iff value is null, undefined,
  /// an empty array, or an object with no keys.
  valueIsEmpty(value) =>
      jsElement.callMethod('valueIsEmpty', [value]);
}
