/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('paper_progress_demo.html')
library polymer_elements_demo.web.paper_progress.paper_progress_demo;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/color.dart';
import 'package:polymer_elements/paper_progress.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';

/// Silence analyzer [Color], [PaperProgress], [PaperButton], [DemoElements],
@PolymerRegister('paper-progress-demo')
class PaperProgressDemo extends PolymerElement {
  PaperProgressDemo.created() : super.created();

//  var progress = document.querySelector('paper-progress');
//  var button = document.querySelector('paper-button');

  @property bool buttonDisabled = false;
  @property int progressValue = 0;

  int _repeat, _maxRepeat = 5;
  bool _animating = false;

  ready() => startProgress();

  void _nextProgress([_]) {
    _animating = true;
    if (progressValue < progress.max) {
      set('progressValue', progressValue + (progress.step ?? 1));
    } else {
      if (++_repeat >= _maxRepeat) {
        _animating = false;
        set('buttonDisabled', false);
        return;
      }
      set('progressValue', progress.min);
    }

    dom.window.requestAnimationFrame(_nextProgress);
  }

  PaperProgress get progress => $['progress'];
  PaperButton get button => $['progress'];

  @reflectable
  void startProgress([_, __]) {
    _repeat = 0;
    set('progressValue', progress.min);
    set('buttonDisabled', true);
    if (!_animating) {
      _nextProgress();
    }
  }
}
