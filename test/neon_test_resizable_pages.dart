@HtmlImport('neon_test_resizable_pages.html')
import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('a-resizable-page')
class AResizablePage extends PolymerElement {



  factory AResizablePage() => new Element.tag('a-resizable-page');
  AResizablePage.created() : super.created();

}

@PolymerRegister('b-resizable-page')
class BResizablePage extends PolymerElement {



  factory BResizablePage() => new Element.tag('b-resizable-page');
  BResizablePage.created() : super.created();

}

@PolymerRegister('c-resizable-page')
class CResizablePage extends PolymerElement {



  factory CResizablePage() => new Element.tag('c-resizable-page');
  CResizablePage.created() : super.created();

}