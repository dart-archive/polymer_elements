/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_menu_button_demo.html')
library polymer_elements_demo.web.paper_menu_button.paper_menu_button_demo;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_image.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/paper_menu_button.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [IronIcons], [IronIcon], [IronImage], [PaperMenu], [PaperItem], [PaperButton], [PaperIconButton], [PaperMenuButton], [DemoElements],
@PolymerRegister('paper-menu-button-demo')
class PaperMenuButtonDemo extends PolymerElement {
  PaperMenuButtonDemo.created() : super.created();

  @property List letters = ['alpha', 'beta', 'gamma', 'delta', 'epsilon'];
  @property List dinosaurs = [
    'allosaurus',
    'brontosaurus',
    'carcharodontosaurus',
    'diplodocus',
    'ekrixinatosaurus',
    'fukuiraptor',
    'gallimimus',
    'hadrosaurus',
    'iguanodon',
    'jainosaurus',
    'kritosaurus',
    'liaoceratops',
    'megalosaurus',
    'nemegtosaurus',
    'ornithomimus',
    'protoceratops',
    'quetecsaurus',
    'rajasaurus',
    'stegosaurus',
    'triceratops',
    'utahraptor',
    'vulcanodon',
    'wannanosaurus',
    'xenoceratops',
    'yandusaurus',
    'zephyrosaurus'
  ];
}
