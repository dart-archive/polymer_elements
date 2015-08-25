// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library polymer_elements.test.iron_list_test_helpers;

import 'dart:html';
import 'dart:js';
import 'common.dart';

JsFunction _matchesSelector = context['Polymer']['DomApi']['matchesSelector'];

Element findElementInList(container, selector) {
  var i = 0;
  var children = container._children;
  for (; i < children.length; i++) {
    if (children[i].nodeType == Node.ELEMENT_NODE &&
        _matchesSelector.apply([children[i], selector])) {
      return children[i];
    }
  }
  return null;
}

JsObject buildItem(index) {
  return new JsObject.jsify({'index': index});
}

JsArray buildDataSet(size) {
  var data = [];
  while (data.length < size) {
    data.add(buildItem(data.length));
  }
  return new JsObject.jsify(data);
}

void simulateScroll(config, fn) {
  var list = config['list'];
  var target = config['target'];
  var delay = config['delay'] != null ? config['delay'] : 1;
  var contribution =
      config['contribution'] != null ? config['contribution'] : 10;
  scroll(dir, prevVal) {
    if ((dir > 0 && list.scrollTop >= target) ||
        (dir < 0 && list.scrollTop <= target) ||
        list.scrollTop == prevVal) {
      list.scrollTop = target;
      wait(100).then((_) {
        fn(list.scrollTop);
      });
      return;
    }
    prevVal = list.scrollTop;
    list.scrollTop = list.scrollTop + dir;
    wait(delay).then((_) {
      scroll(dir, prevVal);
    });
  }
  if (list.scrollTop < target) {
    scroll((contribution as int).abs(), -1);
  } else if (list.scrollTop > target) {
    scroll(-(contribution as int).abs(), -1);
  }
}

Element getFirstItemFromList(list) {
  var listRect = list.getBoundingClientRect();
  return document.elementFromPoint(
      (listRect.left + 1).floor(), (listRect.top + 1).floor());
}

Element getLastItemFromList(list) {
  var listRect = list.getBoundingClientRect();
  return document.elementFromPoint(
      (listRect.left + 1).floor(),
      (listRect.top + listRect.height - 1).floor());
}
