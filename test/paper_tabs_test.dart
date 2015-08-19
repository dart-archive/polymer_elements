@TestOn('browser')
library polymer_elements.test.paper_tabs_test;

import 'dart:html';
import 'dart:async';
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

    void checkSelectionBar(PaperTabs tabs, PaperTab tab) {
        Rectangle tabRect = tab.getBoundingClientRect();
        Rectangle rect = tabs.querySelector('#selectionBar').getBoundingClientRect();
        expect(tabRect.left.round(), equals(rect.left.round()));
    }
    
    group('defaults', () {
    
        PaperTabs tabs;
    
        setUp( () {
            tabs = fixture('basic');
        });
    
        test('to nothing selected', () {
            expect(tabs.selected, isNull);
        });
    
        test('no tabs have iron-selected class', () {
            tabs.querySelectorAll('paper-tab').forEach((PaperTab tab){
                expect(tab.classes.contains('iron-selected'), isFalse);
            });
        });
    
        test('to false as noink', () {
            expect(tabs.noink, isFalse);
        });
    
        test('to false as noBar', () {
            expect(tabs.noBar, isFalse);
        });
    
        test('to false as noSlide', () {
            expect(tabs.noSlide, isFalse);
        });
    
        test('to false as scrollable', () {
            expect(tabs.scrollable, isFalse);
        });
    
        test('to false as disableDrag', () {
            expect(tabs.disableDrag, isFalse);
        });
    
        test('to false as hideScrollButtons', () {
            expect(tabs.hideScrollButtons, isFalse);
        });
    
        test('to false as alignBottom', () {
            expect(tabs.alignBottom, isFalse);
        });
    
        test('has role tablist', () {
            expect(tabs.getAttribute('role'), equals('tablist'));
        });
    });

    group('hidden tabs', () {
        PaperTabs tabs;
    
        setUp(() {
            tabs = fixture('hiddenTabs');
        });
    
        test('choose the correct bar position once made visible', () {
            tabs.attributes.remove('hidden');
            tabs.selected = '0';
            expect(tabs.jsElement['_width'], greaterThan(0));
            expect(tabs.jsElement['_left'], equals(0));
        });
    });
    
    group('set the selected attribute', () {
    
        PaperTabs tabs;
        int index = 0;
    
        setUp( () {
            tabs = fixture('basic');
            tabs.selected = index.toString();
        });
    
        test('selected value', () {
            expect(tabs.selected, equals(index.toString()));
        });
    
        test('selected tab has iron-selected class', () {
            PaperTab tab = tabs.querySelectorAll('paper-tab')[index];
            expect(tab.classes.contains('iron-selected'), isTrue);
        });
    
        test('selected tab has selection bar position at the bottom of the tab', () {
            Completer done = new Completer();
            wait(1000).then((_){
                checkSelectionBar(tabs, tabs.querySelectorAll('paper-tab')[index]);
                done.complete();
            });
            return done.future;
        });
    });
    
    group('select tab via click', () {
    
        PaperTabs tabs;
        PaperTab tab;
        int index = 1;
    
        setUp( () {
            tabs = fixture('basic');
            tab = tabs.querySelectorAll('paper-tab')[index];
            tab.dispatchEvent(new CustomEvent('click', canBubble: true));
        });
    
        test('selected value', () {
            expect(tabs.selected, equals(index));
        });
    
        test('selected tab has iron-selected class', () {
            expect(tab.classes.contains('iron-selected'), isTrue);
        });
    
        test('selected tab has selection bar position at the bottom of the tab', () {
            Completer done = new Completer();
            wait(1000).then((_){
                checkSelectionBar(tabs, tabs.querySelectorAll('paper-tab')[index]);
                done.complete();
            });
            return done.future;
        });
    
        test('pressing enter on tab causes a click', () {
            Completer done = new Completer();
            int clickCount = 0;

            tab.on['click'].take(1).listen((_){
                clickCount++;

                expect(clickCount, equals(1));

                done.complete();
            });

            pressEnter(tab);

            return done.future;
        });
    });
}