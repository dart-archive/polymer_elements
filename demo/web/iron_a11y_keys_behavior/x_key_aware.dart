/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('x_key_aware.html')
library polymer_elements_demo.web.web.iron_a11y_keys_behavior.x_key_aware;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_a11y_keys_behavior.dart';

/// Silence analyzer
@PolymerRegister('x-key-aware')
class XKeyAware extends PolymerElement with IronA11yKeysBehavior {
  XKeyAware.created() : super.created();

  String __pressed;
  @property String pressed = '';
  set _pressed(String value) {
    __pressed = value;
    notifyPath('pressed', __pressed);
  }

  @property List boundKeys;

  @property dom.Element keyEventTarget = dom.document.body;

  ready() {
    var bindings = {
      '* pageup pagedown left right down up shift+a alt+a home end space enter':
          'updatePressed'
    };
    keyBindings = bindings;
    set('boundKeys', bindings.keys.join(' ').split(' '));
  }

  @eventHandler
  void updatePressed(dom.CustomEvent event, [_]) {
    print(event.detail);

    _pressed = '${pressed}${event.detail.combo} pressed!\n';
  }
}
