@TestOn('browser')
library polymer_elements.test.paper_tooltip_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_tooltip.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'sinon/sinon.dart' as sinon;

/**
 * Original tests:
 * https://github.com/PolymerElements/paper-tooltip/tree/master/test
 */

main() async {
    await initWebComponents();

    bool isHidden(element) {
        var rect = element.getBoundingClientRect();
        return (rect.width == 0 && rect.height == 0);
    }

    group('basic', () {
        test('tooltip is shown when target is focused', () {
            HtmlElement f = fixture('basic');
            DivElement target = f.querySelector('#target');
            PaperTooltip tooltip = f.querySelector('paper-tooltip');

            HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
            expect(isHidden(actualTooltip), isTrue);

            focus(target);
            expect(isHidden(actualTooltip), isFalse);
        });
    
        test('tooltip is positioned correctly', () {
            HtmlElement f = fixture('basic');
            DivElement target = f.querySelector('#target');
            PaperTooltip tooltip = f.querySelector('paper-tooltip');

            HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
            expect(isHidden(actualTooltip), isTrue);

            focus(target);
            expect(isHidden(actualTooltip), isFalse);

            Rectangle divRect = target.getBoundingClientRect();
            expect(divRect.width, equals(100));
            expect(divRect.height, equals(20));

            Rectangle contentRect = tooltip.getBoundingClientRect();
            expect(contentRect.width, equals(70));
            expect(contentRect.height, equals(29));

            // The target div width is 100, and the tooltip width is 70, and
            // it's centered. The height of the target div is 20, and the
            // tooltip is 14px below.

            expect(contentRect.left, equals((100 - 70)/2));
            expect(contentRect.top, equals(20 + 14));

            // Also check the math, just in case.
            expect(contentRect.left, equals((divRect.width - contentRect.width)/2));
            expect(contentRect.top, equals(divRect.height + tooltip.marginTop));
        });
    
        test('tooltip is positioned correctly after being dynamically set', () {
            HtmlElement f = fixture('dynamic');
            DivElement target = f.querySelector('#target');
            PaperTooltip tooltip = f.querySelector('paper-tooltip');

            HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
            expect(isHidden(actualTooltip), isTrue);

            // Skip animations in this test, which means we'll show and hide
            // the tooltip manually, instead of calling focus and blur.

            // The tooltip is shown because it's a sibling of the target,
            // but it's positioned incorrectly
            tooltip.toggleClass('hidden', false, actualTooltip);
            expect(isHidden(actualTooltip), isFalse);

            Rectangle contentRect = tooltip.getBoundingClientRect();
            expect(contentRect.left, isNot((100 - 70)/2));

            tooltip.forId = 'target';

            // The tooltip needs to hide before it gets repositioned.
            tooltip.toggleClass('hidden', true, actualTooltip);
            tooltip.jsElement.callMethod('_setPosition');
            tooltip.toggleClass('hidden', false, actualTooltip);
            expect(isHidden(actualTooltip), isFalse);

            // The target div width is 100, and the tooltip width is 70, and
            // it's centered. The height of the target div is 20, and the
            // tooltip is 14px below.
            contentRect = tooltip.getBoundingClientRect();
            expect(contentRect.left, equals((100 - 70)/2));
            expect(contentRect.top, equals(20 + 14));
        });
    
        test('tooltip is hidden after target is blurred', () {
            Completer done = new Completer();

            HtmlElement f = fixture('basic');
            DivElement target = f.querySelector('#target');
            PaperTooltip tooltip = f.querySelector('paper-tooltip');

            HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
            expect(isHidden(actualTooltip), isTrue);
            focus(target);
            expect(isHidden(actualTooltip), isFalse);

            tooltip.on['neon-animation-finish'].listen((_){
                expect(isHidden(actualTooltip), isTrue);
                done.complete();
            });
            blur(target);

            return done.future;
        });

        test('tooltip unlistens to target on detach', () {
            Completer done = new Completer();

            HtmlElement f = fixture('basic');
            DivElement target = f.querySelector('#target');
            PaperTooltip tooltip = f.querySelector('paper-tooltip');

            sinon.spy(tooltip.jsElement, 'show');

            focus(target);
            expect(tooltip.jsElement['show']['callCount'], equals(1));

            focus(target);
            expect(tooltip.jsElement['show']['callCount'], equals(2));

            tooltip.remove();

            wait(200).then((_){
                // No more listener means no more calling show.
                focus(target);
                expect(tooltip.jsElement['show']['callCount'], equals(2));
                done.complete();
            });

            return done.future;
        });
    });
    group('tooltip is inside a custom element', () {
        TemplateElement f;
        PaperTooltip  tooltip;
        HtmlElement target;
    
        setUp(() {
            f = fixture('custom');
            target = f.querySelector('#button');
            tooltip = f.querySelector('paper-tooltip');
        });
    
        test('tooltip is shown when target is focused', () {
            HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
            expect(isHidden(actualTooltip), isTrue);

            focus(target);
            expect(isHidden(actualTooltip), isFalse);
        });
    
        test('tooltip is positioned correctly', () {
            HtmlElement actualTooltip = tooltip.querySelector('#tooltip');
            expect(isHidden(actualTooltip), isTrue);

            focus(target);
            expect(isHidden(actualTooltip), isFalse);

            Rectangle divRect = target.getBoundingClientRect();
            expect(divRect.width, equals(100));
            expect(divRect.height, equals(20));

            Rectangle contentRect = tooltip.getBoundingClientRect();
            expect(contentRect.width, equals(70));
            expect(contentRect.height, equals(29));

            // The target div width is 100, and the tooltip width is 70, and
            // it's centered. The height of the target div is 20, and the
            // tooltip is 14px below.
            expect(contentRect.left, equals((100 - 70)/2));
            expect(contentRect.top, equals(20 + 14));

            // Also check the math, just in case.
            expect(contentRect.left, equals((divRect.width - contentRect.width)/2));
            expect(contentRect.top, equals(divRect.height + tooltip.marginTop));
        });
    });

    group('a11y', () {
        test('has aria role "tooltip"', () {
            HtmlElement f = fixture('basic');
            PaperTooltip tooltip = f.querySelector('paper-tooltip');
        
            expect(tooltip.getAttribute('role'), equals('tooltip'));
        });
    });
}