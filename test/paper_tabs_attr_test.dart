@TestOn('browser')
library polymer_elements.test.paper_tabs_attr_test;

import 'dart:html';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_tab.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-tabs/tree/master/test
 */

main() async {
    await initWebComponents();

    group('set the selected attribute', () {

        PaperTabs tabs;
    
        setUp( () {
            tabs = fixture('basic');
        });
    
        test('selected value', () {
            expect(tabs.selected, equals('bar'));
        });
    
        test('selected tab has iron-selected class', () {
            expect(tabs.querySelector('[name=bar]').classes.contains('iron-selected'), isTrue);
        });
    });

    group('select tab via click', () {

        PaperTabs tabs;
        PaperTab tab;
    
        setUp( () {
            tabs = fixture('basic');
            tab = tabs.querySelector('[name=zot]');
            tab.dispatchEvent(new CustomEvent('click', canBubble: true));
        });
    
        test('selected value', () {
            expect(tabs.selected, equals('zot'));
        });
    
        test('selected tab has iron-selected class', () {
            expect(tab.classes.contains('iron-selected'), isTrue);
        });
    });
}
