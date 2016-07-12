@HtmlImport("disabled_input.html")
library fixture.disabled_input;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;


@PolymerRegister("disabled-input")
class DisabledInput extends PolymerElement {

  @property String myValue = 'foo';

  @property bool myInvalid = false;

  DisabledInput.created() : super.created();



}