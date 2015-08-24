@HtmlImport('sample_content.html')
library polymer_elements.test.fixtures.sample_content;

import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

@jsProxyReflectable
@PolymerRegister('sample-content')
class SampleContent extends PolymerElement {
  SampleContent.created() : super.created();

  @Property(observer: 'sizeChanged')
  int size = 0;

  @eventHandler
  sizeChanged(newVal, oldVal) {
    var html = new StringBuffer();
    for (var i = 0; i < size; i++) {
      html.write('''
<div style="border: 1px solid #bebebe; padding: 16px; margin: 16px; border-radius: 5px; background-color: #fff; color: #555;">
<div style="display: inline-block; height: 64px; width: 64px; border-radius: 50%; background: #ddd; line-height: 64px; font-size: 30px; color: #666; text-align: center;">${randomLetter()}</div>
<div style="font-size: 22px; padding: 8px 0 16px; color: #888;">${randomString()}</div>
<div style="font-size: 16px; padding-bottom: 8px;">${randomString()}</div>
<div style="font-size: 12px;">${randomString()}</div>
<div style="font-size: 12px;">${randomString()}</div>
</div>''');
      ($['content'] as Element)
          .setInnerHtml('$html', treeSanitizer: const NullTreeSanitizer());
    }
  }
}

const List<String> strings = const [
  'Lorem ipsum dolor sit amet, per in nusquam nominavi periculis, sit elit oportere ea.',
  'Ut labores minimum atomorum pro. Laudem tibique ut has.',
  'Fugit adolescens vis et, ei graeci forensibus sed.',
  'Convenire definiebas scriptorem eu cum. Sit dolor dicunt consectetuer no.',
  'Ea duis bonorum nec, falli paulo aliquid ei eum.',
  'Usu eu novum principes, vel quodsi aliquip ea.',
  'Has at minim mucius aliquam, est id tempor laoreet.',
  'Pro saepe pertinax ei, ad pri animal labores suscipiantur.',
  'Detracto suavitate repudiandae no eum. Id adhuc minim soluta nam.',
  'Iisque perfecto dissentiet cum et, sit ut quot mandamus, ut vim tibique splendide instructior.',
  'Id nam odio natum malorum, tibique copiosae expetenda mel ea.',
  'Cu mei vide viris gloriatur, at populo eripuit sit.',
  'Modus commodo minimum eum te, vero utinam assueverit per eu.',
  'No nam ipsum lorem aliquip, accumsan quaerendum ei usu.'
];

var rand = new Random();

String randomString() {
  return strings[rand.nextInt(strings.length)];
}

String randomLetter() {
  return new String.fromCharCode(65 + rand.nextInt(26));
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  const NullTreeSanitizer();
  void sanitizeTree(Node node) {}
}
