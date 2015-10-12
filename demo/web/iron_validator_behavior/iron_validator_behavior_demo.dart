/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('iron_validator_behavior_demo.html')
library polymer_elements_demo.web.iron_validator_behavior.iron_validator_behavior_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_meta.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'cats_only_validator.dart';
import 'package:polymer_elements/iron_validator_behavior.dart';
import 'package:polymer_elements/iron_form.dart';

/// Silence analyzer [IronMeta], [DemoElements], [CatsOnlyValidator], [IronForm]
@PolymerRegister('iron-validator-behavior-demo')
class IronValidatorBehaviorDemo extends PolymerElement {
  IronValidatorBehaviorDemo.created() : super.created();

  IronValidatorBehavior _validator;

  @property bool valid = true;
  @property bool validMulti = true;
  @property bool validForm = true;

  ready() {
    _validator = (new IronMetaQuery()..type = 'validator').byKey('cats-only');
  }

  @reflectable
  void inputHandler(dom.Event event, [_]) {
    set('valid', _validator.validate((event.target as dom.InputElement).value));
  }

  @reflectable
  void inputMultiHandler(dom.Event event, [_]) {
    var values = <String>[];
    var nodes = (Polymer.dom(event.currentTarget) as PolymerDom)
        .querySelectorAll('input') as List<dom.InputElement>;
    for (dom.InputElement node in nodes) {
      values.add(node.value);
    }
    set('validMulti', _validator.validate(values));
  }

  @reflectable
  submitHandler(dom.MouseEvent event, [_]) {
    var data = {};
    // TODO(zoechi) replace commented-out line when dart-lang/sdk#24008 is fixed
    //for (dom.InputElement el in (event.target as dom.ButtonElement).form.elements) {
    for (dom.InputElement el in (event.target as dom.ButtonElement)
        .form
        .querySelectorAll('input') as List<dom.InputElement>) {
      if (el.attributes.containsKey('name') != null &&
          el.attributes['name'].isNotEmpty) {
        data[el.name] = el.value;
      }
    }
    set('validForm', _validator.validate(data));
  }
}
