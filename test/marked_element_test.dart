// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.marked_element_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/marked_element.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';
import 'package:polymer/polymer.dart';

// Thanks IE10.
bool isHidden(Element element) {
  var rect = element.getBoundingClientRect();
  return (rect.width == 0 && rect.height == 0);
}

String escapeHTML(string) {
  SpanElement span = document.createElement('span');
  span.text = string;
  return span.innerHtml;
}

class NoValidation implements NodeValidator {
  const NoValidation();

  bool allowsElement(Element element) {
    return true;
  }

  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }
}

const noValidation = const NoValidation();

main() async {
  await initWebComponents();

  suite('<marked-element> has some options of marked available', ( ) {
    MarkedElement markedElement;
    var outputElement;
    setup(() {
      markedElement = fixture('SmartyPants');
      outputElement = new PolymerDom(markedElement).querySelector('#output');
    });
    test('has sanitize', () {
      $expect(markedElement.sanitize).to.equal(false);
    });
    test('has pedantic', () {
      $expect(markedElement.sanitize).to.equal(false);
    });
    test('has smartypants', () {
      $expect(markedElement.sanitize).to.equal(false);
      // console.log(outputElement.innerHTML)
    });
  });


  group('<marked-element> with .markdown-html child', () {
    group('respects camelCased HTML', () {
      MarkedElement markedElement;
      DivElement proofElement;
      DivElement outputElement;

      setUp(() async {
        markedElement = fixture('CamelCaseHTML');
        proofElement = document.createElement('div');
        outputElement = document.getElementById('output');
        await new Future(() {});
      });

      test('in code blocks', () {
        proofElement.setInnerHtml('<div camelCase></div>',
                                      validator: noValidation);

        expect(outputElement, markedElement.outputElement);
        expect(isHidden(markedElement.$['content']), isTrue);

        // If Markdown content were put into a `<template>` or directly into the DOM, it would be
        // rendered as DOM and be converted from camelCase to lowercase per HTML parsing rules. By
        // using `<script>` descendants, content is interpreted as plain text.
        expect(proofElement.innerHtml, equals('<div camelcase=""></div>'));
        expect(
            markedElement.innerHtml, contains(escapeHTML('<div camelCase>')));
      });
    });

    group('respects bad HTML', () {
      MarkedElement markedElement;
      DivElement proofElement;
      DivElement outputElement;

      setUp(() async {
        markedElement = fixture('BadHTML');
        proofElement = document.createElement('div');
        outputElement = document.getElementById('output');
        await new Future(() {});
      });

      test('in code blocks', () {
        proofElement.setInnerHtml('<p><div></p></div>');
        expect(outputElement, markedElement.outputElement);
        expect(isHidden(markedElement.$['content']), isTrue);

        // If Markdown content were put into a `<template>` or directly into the DOM, it would be
        // rendered as DOM and close unbalanced tags. Because they are in code blocks they should
        // remain as typed.
        // Turns out, however IE and everybody else have slightly different opinions
        // about how the incorrect HTML should be fixed. It seems that:
        // IE says:       <p><div></p></div> -> <p><div><p></p></div>
        // Chrome/FF say: <p><div></p></div> -> <p></p><div><p></p></div>.
        // So that's cool.
        var isEqualToOneOfThem = proofElement.innerHtml ==
            '<p><div><p></p></div>' ||
            proofElement.innerHtml == '<p></p><div><p></p></div>';
        expect(isEqualToOneOfThem, isTrue);
        expect(outputElement.innerHtml,
                   contains(escapeHTML('<p><div></p></div>')));
      });
    });

    group('<marked-element> without .markdown-html child', () {
      group('respects camelCased HTML', () {
        var markedElement;
        var proofElement;

        setUp(() async {
          markedElement = fixture('CamelCaseHTMLWithoutChild');
          proofElement = document.createElement('div');
          await new Future(() {});
        });

        test('in code blocks', () {
          proofElement.setInnerHtml('<div camelCase></div>',
                                        validator: noValidation);
          expect(markedElement.$['content'], markedElement.outputElement);
          expect(isHidden(markedElement.$['content']), isFalse);

          // If Markdown content were put into a `<template>` or directly into the DOM, it would be
          // rendered as DOM and be converted from camelCase to lowercase per HTML parsing rules. By
          // using `<script>` descendants, content is interpreted as plain text.
          expect(proofElement.innerHtml, '<div camelcase=""></div>');
          expect(markedElement.$['content'].innerHtml,
                     contains(escapeHTML('<div camelCase>')));
        });
      });

      group('respects bad HTML', () {
        var markedElement;
        var proofElement;

        setUp(() async {
          markedElement = fixture('BadHTMLWithoutChild');
          proofElement = document.createElement('div');
          await new Future(() {});
        });

        test('in code blocks', () {
          proofElement.innerHtml = '<p><div></p></div>';
          expect(markedElement.$['content'], markedElement.outputElement);
          expect(isHidden(markedElement.$['content']), isFalse);
          // If Markdown content were put into a `<template>` or directly into the DOM, it would be
          // rendered as DOM and close unbalanced tags. Because they are in code blocks they should
          // remain as typed.
          // Turns out, however IE and everybody else have slightly different opinions
          // about how the incorrect HTML should be fixed. It seems that:
          // IE says:       <p><div></p></div> -> <p><div><p></p></div>
          // Chrome/FF say: <p><div></p></div> -> <p></p><div><p></p></div>.
          // So that's cool.
          var isEqualToOneOfThem = proofElement.innerHtml ==
              '<p><div><p></p></div>' ||
              proofElement.innerHtml == '<p></p><div><p></p></div>';
          expect(isEqualToOneOfThem, isTrue);
          expect(markedElement.$['content'].innerHtml,
                     contains(escapeHTML('<p><div></p></div>')));
        });
      });


      suite('events', () {
        MarkedElement markedElement;
        DivElement outputElement;

        setup(() {
          markedElement = fixture('CamelCaseHTML');
          outputElement = document.getElementById('output');
        });

        test('render() fires marked-render-complete', when((done) {
          markedElement.on['marked-render-complete'].take(1).listen((_) {
            $expect(outputElement.innerHtml).to.not.equal('');
            done();
          });
          markedElement.render();
        }));
      });
    });
  });
}
