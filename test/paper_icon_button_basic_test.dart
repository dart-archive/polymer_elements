@TestOn('browser')
library polymer_elements.test.paper_icon_button_basic_test;

import 'package:polymer_elements/paper_icon_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

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
      expect(Polymer.dom(b1.$['icon'].root).querySelector('svg'), isNotNull);
    });

    test('applies an icon specified by the `src` attribute', () {
      expect(b2.src, isNotNull);
    });

    test('renders correctly independent of line height', () {
      expect(middleOfNode(b1.$['icon']).isApproximatelyEqualTo(middleOfNode(b1)), isTrue);
    });
  });
}
