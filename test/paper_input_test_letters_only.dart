@TestOn('browser')
library polyer_elements.test.paper_input_letters_only;

import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:polymer_elements/iron_validator_behavior.dart';

@PolymerRegister('letters-only')
class LettersOnly extends PolymerElement with IronValidatorBehavior {

  LettersOnly.created() : super.created();

  bool validate(String value){
    return value != null ? value.allMatches('^[a-zA-Z]*\$/').isNotEmpty : false;
  }

}