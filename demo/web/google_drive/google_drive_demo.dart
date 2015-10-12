/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('google_drive_demo.html')
library polymer_elements_demo.web.google_drive.google_drive_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/google_signin.dart';
import 'package:polymer_elements/google_drive.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [GoogleSignin], [GoogleDrive], [DemoElements],
@PolymerRegister('google-drive-demo')
class GoogleDriveDemo extends PolymerElement {
  GoogleDriveDemo.created() : super.created();

  @property String statusMessage;
  @property List queueUploadList;
  @property List uploadedList;

  @reflectable
  void uploadStarted(dom.CustomEvent event, [_]) {
    set('queueUploadList', (event.detail.files as List).toList());
  }

  @reflectable
  void filesSelected(dom.CustomEvent event, [_]) {
    set('queueUploadList', (event.detail.files as List).toList());
  }

  @reflectable
  void uploadCompleted(dom.CustomEvent event, [_]) {
    set('uploadedList', (event.detail.files as List).toList());
  }

  @reflectable
  void uploadStatus(dom.CustomEvent event, [_]) {
    set('statusMessage', event.detail.status);
  }

}
