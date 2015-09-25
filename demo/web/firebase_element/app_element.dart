@HtmlImport('app_element.html')
library app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_styles.dart';
import 'package:polymer_elements/demo_pages.dart';
import 'package:polymer_elements/firebase_collection.dart';
import 'package:polymer_elements/firebase_document.dart';
import 'x_pretty_json.dart';
import 'x_login.dart';

/// Silence analyzer [FirebaseCollection], [FirebaseDocument], [XPrettyJson], [XLogin],
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();
}
