@TestOn('browser')
library polymer_elements.test.neon_animated_pages_test;

import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer_elements/neon_animated_pages.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'dart:html';

main() async {

  await initWebComponents();

  group('<neon-animated-pages>', () {

    group('notify-resize',(){

      test('only a destination page receives a resize event',() async {
        NeonAnimatedPages animatedPages = fixture('notify-resize');
        List<Element> resizables = Polymer.dom(animatedPages).children;
        Map receives = {};
        resizables.forEach((Element page){
          page.on['iron-resize'].listen((Event e){
            var pageName = event.currentTarget.tagName;
            receives[pageName] = receives.containsKey(pageName) ? receives[pageName]+1 : 1;
          });
        });

        animatedPages.selected = 2;

        await wait(50);

        expect(receives,equals({'C-RESIZABLE-PAGE':1}));

      }, skip:'https://github.com/dart-lang/polymer-dart/issues/551');



    });

  });
}
