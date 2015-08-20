@HtmlImport('iron_behavior_elements.html')
library polymer_elements.test.fixture.iron_behavior_elements;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_button_state.dart';
import 'package:polymer_elements/iron_control_state.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';

@jsProxyReflectable
@PolymerRegister('test-control')
class TestControl extends PolymerElement with IronControlState {
  TestControl.created() : super.created();
}

@jsProxyReflectable
@PolymerRegister('test-button')
class TestButton extends PolymerElement with IronControlState, IronButtonState {
  TestButton.created() : super.created();

  void buttonStateChanged() {}
}

@jsProxyReflectable
@PolymerRegister('nested-focusable')
class NestedFocusable extends PolymerElement with IronControlState {
  NestedFocusable.created() : super.created();
}
