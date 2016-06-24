@HtmlImport('app_storage_test_helpers.html')
library polymer_elements.test.helpers;

import 'package:web_components/web_components.dart';
import 'dart:js';

JsObject _appStorageTestHelpers = context['appStorageTestHelpers'];

getIdbObjectStoreValue(k1, v1, k2, v2) => _appStorageTestHelpers.callMethod('getIdbObjectStoreValue', [k1, v1, k2, v2]);

setIdbObjectStoreValue(k1, v1, k2, v2, v3) => _appStorageTestHelpers.callMethod('setIdbObjectStoreValue', [k1, v1, k2, v2, v3]);

restoreNavigatorOnLine() => _appStorageTestHelpers.callMethod('restoreNavigatorOnLine');

deleteIdbDatabase(id) => _appStorageTestHelpers.callMethod('deleteIdbDatabase', [id]);

goOffline() => _appStorageTestHelpers.callMethod('goOffline');
