/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_icons_demo.html')
library polymer_elements_demo.web.iron_icons.iron_icons_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/av_icons.dart';
import 'package:polymer_elements/communication_icons.dart';
import 'package:polymer_elements/device_icons.dart';
import 'package:polymer_elements/editor_icons.dart';
import 'package:polymer_elements/hardware_icons.dart';
import 'package:polymer_elements/image_icons.dart';
import 'package:polymer_elements/maps_icons.dart';
import 'package:polymer_elements/notification_icons.dart';
import 'package:polymer_elements/social_icons.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronFlexLayout], [IronIcons], [AvIcons], [CommunicationIcons], [DeviceIcons], [EditorIcons], [HardwareIcons], [ImageIcons], [MapsIcons], [NotificationIcons], [SocialIcons], [DemoElements],
@PolymerRegister('iron-icons-demo')
class IronIconsDemo extends PolymerElement {
  IronIconsDemo.created() : super.created();

  @property List iconsets;

  @eventHandler
  List<String> getIconNames(iconSet) => iconSet.getIconNames();
}
