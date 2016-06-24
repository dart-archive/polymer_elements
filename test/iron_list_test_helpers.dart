// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library polymer_elements.test.iron_list_test_helpers;

import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_list.dart';
import 'common.dart';
import 'dart:async';
import 'dart:math' as Math;
import 'package:polymer/polymer.dart';

JsFunction _matchesSelector = context['Polymer']['DomApi']['matchesSelector'];

Element findElementInList(container, selector) {
  var i = 0;
  var children = container._children;
  for (; i < children.length; i++) {
    if (children[i].nodeType == Node.ELEMENT_NODE && _matchesSelector.apply([children[i], selector])) {
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

void simulateScroll(config) {
  IronList list = config['list'];
  num target = config['target'];
  num delay = config['delay'] != null ? config['delay'] : 1;
  num contribution = config['contribution'] != null ? (config['contribution'] as num).abs() : 10;
  // scroll back up
  if (target < list.scrollTop) {
    contribution = -contribution;
  }
  StreamSubscription l;
  scrollHandler() {
    new Future.delayed(new Duration(milliseconds: delay)).then((_) {
      num minScrollTop = 0;
      num maxScrollTop = list.scrollHeight - list.offsetHeight;

      if (config['onScroll'] != null) config['onScroll']();

      if (list.scrollTop < target && contribution > 0 && list.scrollTop < maxScrollTop) {
        num x = Math.min(maxScrollTop, list.scrollTop + contribution);
        list.scrollTop = x;
      } else if (list.scrollTop > target && contribution < 0 && list.scrollTop > minScrollTop) {
        list.scrollTop = Math.max(minScrollTop, list.scrollTop + contribution);
      } else {
        l.cancel();
        list.scrollTop = target;
        new Future.delayed(new Duration(milliseconds: 10)).then((_) {
          if (config['onScrollEnd'] != null) config['onScrollEnd']();
        });
      }

      //print("T : ${list.scrollTop}");
    });
  }
  l = list.onScroll.listen((_) => scrollHandler());
  scrollHandler();
}

getGridRowFromIndex(IronList grid, index) {
  return (index / grid.jsElement['_itemsPerRow']).floor();
}

Element getNthItemFromGrid(IronList grid, n, [itemSize]) {
  itemSize = itemSize != null ? itemSize : 100;
  var gridRect = grid.getBoundingClientRect();
  var x = gridRect.left + ((n % grid.jsElement['_itemsPerRow']) * itemSize) + (itemSize / 2);
  var y = gridRect.top + ((n / grid.jsElement['_itemsPerRow']).floor() * itemSize) + (itemSize / 2);
  return document.elementFromPoint(x.floor(), y.floor());
}

Element getFirstItemFromList(list) {
  var listRect = list.getBoundingClientRect();
  Element e = document.elementFromPoint((listRect.left + 100).floor(), (listRect.top + 1).floor());
  //print("RECT:${listRect} -> ${e} at ${listRect.top+1}");
  return e;
}

Element getLastItemFromList(list) {
  Rectangle listRect = list.getBoundingClientRect();
  Element e = document.elementFromPoint((listRect.left + 100).floor(), (listRect.bottom - 1).floor());
  //print("RECT:${listRect} -> ${e} at ${listRect.bottom-1}");
  return e;
}

isFullOfItems(IronList list) {
  var listRect = list.getBoundingClientRect();
  var listHeight = listRect.height - 1;
  var item, y = listRect.top + 1;
  // IE 10 & 11 doesn't render propertly :(
  var badPixels = 0;
  while (y < listHeight) {
    item = document.elementFromPoint((listRect.left + 100).floor(), y.floor()) as HtmlElement;
    if (item == null || (item.parentNode != null && new JsObject.fromBrowserObject(item.parentNode)['_templateInstance'] == null)) {
      badPixels++;
    }
    y++;
    if (badPixels > 2) {
      return false;
    }
  }
  return true;
}

checkRepeatedItems(list) {
  var listRect = list.getBoundingClientRect();
  var listHeight = list.offsetHeight;
  var listItems = {};

  return () {
    var itemKey;
    var y = listRect.top;
    while (y < listHeight) {
      var item = document.elementFromPoint((listRect.left + 100).floor(), (y + 2).floor());
      itemKey = item.text != null ? item.text : item.innerHtml;

      if (item.parentNode != null && new JsObject.fromBrowserObject(item.parentNode)["_templateInstance"] != null) {
        if (listItems["itemKey"] != null && listItems["itemKey"] != item) {
          return true;
        }
        listItems["itemKey"] = item;
      }
      y += item.offsetHeight;
    }
    return false;
  };
}

getNthItemRowStart(IronList grid, n) {
  return n - (n % grid.jsElement['_itemsPerRow']);
}
