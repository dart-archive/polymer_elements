@TestOn('browser')
library polymer_elements.test.paper_icon_button_basic_test;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

Map centerOf(Element element) {
  var rect = element.getBoundingClientRect();
  return {
    'left': rect.left + rect.width / 2,
    'top': rect.top + rect.height / 2
  };
}

bool approxEqual(p1, p2) {
  return p1['left'].round() == p2['left'].round() &&
  p1['top'].round() == p2['top'].round();
}

main() async {
  await initWebComponents();

  group('<paper-icon-button>', () {
    PaperIconButton b1;
    PaperIconButton b2;

    setUp(() {
      b1 = fixture('TrivialIconButton').querySelector('#fab1');
      b2 = fixture('SrcIconButton');
    });

    test('applies an icon specified by the `icon` attribute', () {
      expect(b1.src, isNull);
      expect(Polymer.dom(b1.$['icon'].jsElement['root']).querySelector('svg'),
          isNotNull);
    });

    test('applies an icon specified by the `src` attribute', () {
      expect(b2.src, isNotNull);
    });

    test('renders correctly independent of line height', () {
      expect(approxEqual(centerOf(b1.$['icon']), centerOf(b1)), isTrue);
    });
  });
}
