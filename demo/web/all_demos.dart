/*
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
*/
@HtmlImport('all_demos.html')
library polymer_elements_demo.web.all_demos;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements/paper_toolbar.dart';

//  import 'chartjs_element/index.dart';
import 'firebase_element/index.dart';
import 'gold_cc_cvc_input/index.dart';
import 'gold_cc_expiration_input/index.dart';
import 'gold_cc_input/index.dart';
import 'gold_email_input/index.dart';
import 'gold_phone_input/index.dart';
import 'gold_zip_input/index.dart';
import 'google_analytics/index.dart';
import 'google_apis/index.dart';
import 'google_calendar/index.dart';
import 'google_castable_video/index.dart';
import 'google_chart/index.dart';
//  import 'google_domain_user_picker/index.dart';
//  import 'google_drive/index.dart';
import 'google_feeds/index.dart';
import 'google_hangout_button/index.dart';
import 'google_map/index.dart';
//  import 'google_recaptcha/index.dart';
import 'google_sheets/index.dart';
import 'google_signin/index.dart';
import 'google_streetview_pano/index.dart';
import 'google_url_shortener/index.dart';
import 'google_youtube/index.dart';
import 'google_youtube_upload/index.dart';
import 'iron_a11y_announcer/index.dart';
import 'iron_a11y_keys/index.dart';
import 'iron_a11y_keys_behavior/index.dart';
import 'iron_ajax/index.dart';
import 'iron_autogrow_textarea/index.dart';
import 'iron_behaviors/index.dart';
//import 'iron_checked_element_behavior/index.dart';
import 'iron_collapse/index.dart';
import 'iron_component_page/index.dart';
import 'iron_doc_viewer/index.dart';
import 'iron_dropdown/index.dart';
import 'iron_fit_behavior/index.dart';
import 'iron_flex_layout/index.dart';
import 'iron_flex_layout/index.dart';
import 'iron_form/index.dart';
import 'iron_form_element_behavior/index.dart';
import 'iron_icon/index.dart';
import 'iron_icons/index.dart';
import 'iron_iconset/index.dart';
import 'iron_iconset_svg/index.dart';
import 'iron_image/index.dart';
import 'iron_input/index.dart';
import 'iron_jsonp_library/index.dart';
// import 'iron_label/index.dart';
import 'iron_list/index.dart';
import 'iron_list/external_content.dart';
import 'iron_list/selection.dart';
import 'iron_localstorage/index.dart';
import 'iron_media_query/index.dart';
import 'iron_menu_behavior/index.dart';
import 'iron_meta/index.dart';
import 'iron_overlay_behavior/index.dart';
import 'iron_pages/index.dart';
import 'iron_range_behavior/index.dart';
import 'iron_resizable_behavior/index.dart';
import 'iron_selector/index.dart';
import 'iron_signals/index.dart';
import 'iron_validatable_behavior/index.dart';
import 'iron_validator_behavior/index.dart';
import 'marked_element/index.dart';
//  import 'neon_animation/card/index.dart';
//  import 'neon_animation/declarative/index.dart';
//  import 'neon_animation/doc/index.dart';
//  import 'neon_animation/dropdown/index.dart';
//  import 'neon_animation/grid/index.dart';
//  import 'neon_animation/list/index.dart';
//  import 'neon_animation/load/index.dart';
//  import 'neon_animation/reprojection/index.dart';
//  import 'neon_animation/tiles/index.dart';
import 'paper_badge/index.dart';
import 'paper_behaviors/index.dart';
import 'paper_card/index.dart';
import 'paper_checkbox/index.dart';
import 'paper_dialog/index.dart';
import 'paper_dialog_behavior/index.dart';
import 'paper_dialog_scrollable/index.dart';
import 'paper_drawer_panel/index.dart';
import 'paper_dropdown_menu/index.dart';
import 'paper_fab/index.dart';
import 'paper_header_panel/index.dart';
import 'paper_icon_button/index.dart';
import 'paper_input/index.dart';
import 'paper_item/index.dart';
import 'paper_material/index.dart';
import 'paper_menu/index.dart';
import 'paper_menu_button/index.dart';
import 'paper_progress/index.dart';
import 'paper_radio_button/index.dart';
import 'paper_radio_group/index.dart';
import 'paper_ripple/index.dart';
import 'paper_scroll_header_panel/index.dart';
import 'paper_slider/index.dart';
import 'paper_spinner/index.dart';
import 'paper_styles/index.dart';
import 'paper_tabs/index.dart';
import 'paper_toast/index.dart';
import 'paper_toggle_button/index.dart';
import 'paper_toolbar/index.dart';
import 'paper_tooltip/index.dart';

/// Silence analyzer [DemoElements],
@PolymerRegister('all-demos')
class AllDemos extends PolymerElement {
  AllDemos.created() : super.created();
  List<DemoElementItem> __demos;
  @property List<DemoElementItem> get demos => __demos;
  set demos(value){}

  void ready() {
    __demos = demoElements.map((name) => new DemoElementItem(name)).toList();
    notifyPath('demos', __demos);
    print('all-demos ready');
  }

  @eventHandler
  void loadDemo(dom.Event event, [_]) {
    final demo = new dom.Element.tag((event.target as dom.Element).dataset['id']);
    final placeholder = Polymer.dom($['placeholder']) as PolymerDom;
    placeholder.childNodes.clear();
    placeholder.append(demo);
  }
}

class DemoElementItem extends JsProxy {
  final String name;
  DemoElementItem(this.name);
}

const List demoElements = const [
//   'chartjs-elemen-demo',
  'firebase-element-demo',
  'gold-cc-cvc-input-demo',
  'gold-cc-expiration-input-demo',
  'gold-cc-input-demo',
  'gold-email-input-demo',
  'gold-phone-input-demo',
  'gold-zip-input-demo',
  'google-analytics-demo',
  'google-apis-demo',
  'google-calendar-demo',
  'google-castable-video-demo',
  'google-chart-demo',
//   'google-domain-user-picke-demo',
//   'google-driv-demo',
  'google-feeds-demo',
  'google-hangout-button-demo',
  'google-map-demo',
//   'google-recaptch-demo',
  'google-sheets-demo',
  'google-signin-demo',
  'google-streetview-pano-demo',
  'google-url-shortener-demo',
  'google-youtube-demo',
  'google-youtube-upload-demo',
  'iron-a11y-announcer-demo',
  'iron-a11y-keys-demo',
  'iron-a11y-keys-behavior-demo',
  'iron-ajax-demo',
  'iron-autogrow-textarea-demo',
  'iron-behaviors-demo',
//  'iron-checked-element-behavior-demo',
  'iron-collapse-demo',
  'iron-component-page-demo',
  'iron-doc-viewer-demo',
  'iron-dropdown-demo',
  'iron-fit-behavior-demo',
  'iron-flex-layout-demo',
  'iron-flex-layout-demo',
  'iron-form-demo',
  'iron-form-element-behavior-demo',
  'iron-icon-demo',
  'iron-icons-demo',
  'iron-iconset-demo',
  'iron-iconset-svg-demo',
  'iron-image-demo',
  'iron-input-demo',
  'iron-jsonp-library-demo',
//  'iron-labe-demo',
  'iron-list-demo',
  'iron-list/external-demo',
  'iron-list-demo',
  'iron-localstorage-demo',
  'iron-media-query-demo',
  'iron-menu-behavior-demo',
  'iron-meta-demo',
  'iron-overlay-behavior-demo',
  'iron-pages-demo',
  'iron-range-behavior-demo',
  'iron-resizable-behavior-demo',
  'iron-selector-demo',
  'iron-signals-demo',
  'iron-validatable-behavior-demo',
  'iron-validator-behavior-demo',
  'marked-element-demo',
//   'neon-animation/car-demo',
//   'neon-animation/declarativ-demo',
//   'neon-animation/do-demo',
//   'neon-animation/dropdow-demo',
//   'neon-animation/gri-demo',
//   'neon-animation/lis-demo',
//   'neon-animation/loa-demo',
//   'neon-animation/reprojectio-demo',
//   'neon-animation/tile-demo',
  'paper-badge-demo',
  'paper-behaviors-demo',
  'paper-card-demo',
  'paper-checkbox-demo',
  'paper-dialog-demo',
  'paper-dialog-behavior-demo',
  'paper-dialog-scrollable-demo',
  'paper-drawer-panel-demo',
  'paper-dropdown-menu-demo',
  'paper-fab-demo',
  'paper-header-panel-demo',
  'paper-icon-button-demo',
  'paper-input-demo',
  'paper-item-demo',
  'paper-material-demo',
  'paper-menu-demo',
  'paper-menu-button-demo',
  'paper-progress-demo',
  'paper-radio-button-demo',
  'paper-radio-group-demo',
  'paper-ripple-demo',
  'paper-scroll-header-panel-demo',
  'paper-slider-demo',
  'paper-spinner-demo',
  'paper-styles-demo',
  'paper-tabs-demo',
  'paper-toast-demo',
  'paper-toggle-button-demo',
  'paper-toolbar-demo',
  'paper-tooltip-demo',
];
