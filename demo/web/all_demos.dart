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

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements_demo/styles/demo_elements.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'firebase_element/firebase_element_demo.dart';
import 'gold_cc_cvc_input/gold_cc_cvc_input_demo.dart';
import 'gold_cc_expiration_input/gold_cc_expiration_input_demo.dart';
import 'gold_cc_input/gold_cc_input_demo.dart';
import 'gold_email_input/gold_email_input_demo.dart';
import 'gold_phone_input/gold_phone_input_demo.dart';
import 'gold_zip_input/gold_zip_input_demo.dart';
import 'google_analytics/google_analytics_demo.dart';
import 'google_apis/google_apis_demo.dart';
import 'google_calendar/google_calendar_demo.dart';
import 'google_castable_video/google_castable_video_demo.dart';
import 'google_chart/google_chart_demo.dart';
import 'google_feeds/google_feeds_demo.dart';
import 'google_hangout_button/google_hangout_button_demo.dart';
//import 'google_map/google_map_demo.dart';
//import 'google_map/google_map_polys_demo.dart';
import 'google_sheets/google_sheets_demo.dart';
import 'google_signin/google_signin_demo.dart';
import 'google_streetview_pano/google_streetview_pano_demo.dart';
import 'google_url_shortener/google_url_shortener_demo.dart';
import 'google_youtube/google_youtube_demo.dart';
import 'google_youtube_upload/google_youtube_upload_demo.dart';
import 'iron_a11y_announcer/iron_a11y_announcer_demo.dart';
import 'iron_a11y_keys/iron_a11y_keys_demo.dart';
import 'iron_a11y_keys_behavior/iron_a11y_keys_behavior_demo.dart';
import 'iron_ajax/iron_ajax_demo.dart';
import 'iron_autogrow_textarea/iron_autogrow_textarea_demo.dart';
import 'iron_behaviors/iron_behaviors_demo.dart';
import 'iron_checked_element_behavior/iron_checked_element_behavior_demo.dart';
import 'iron_collapse/iron_collapse_demo.dart';
import 'iron_component_page/iron_component_page_demo.dart';
import 'iron_doc_viewer/iron_doc_viewer_demo.dart';
import 'iron_dropdown/iron_dropdown_demo.dart';
import 'iron_fit_behavior/iron_fit_behavior_demo.dart';
import 'iron_flex_layout/iron_flex_layout_demo.dart';
import 'iron_form/iron_form_demo.dart';
import 'iron_form_element_behavior/iron_form_element_behavior_demo.dart';
import 'iron_icon/iron_icon_demo.dart';
import 'iron_icons/iron_icons_demo.dart';
import 'iron_iconset/iron_iconset_demo.dart';
import 'iron_iconset_svg/iron_iconset_svg_demo.dart';
import 'iron_image/iron_image_demo.dart';
import 'iron_input/iron_input_demo.dart';
import 'iron_jsonp_library/iron_jsonp_library_demo.dart';
import 'iron_list/iron_list_demo.dart';
import 'iron_list/iron_list_collapse_demo.dart';
import 'iron_list/iron_list_external_content_demo.dart';
import 'iron_list/iron_list_selection_demo.dart';
import 'iron_localstorage/iron_localstorage_demo.dart';
import 'iron_media_query/iron_media_query_demo.dart';
import 'iron_menu_behavior/iron_menu_behavior_demo.dart';
import 'iron_meta/iron_meta_demo.dart';
import 'iron_overlay_behavior/iron_overlay_behavior_demo.dart';
import 'iron_pages/iron_pages_demo.dart';
import 'iron_range_behavior/iron_range_behavior_demo.dart';
import 'iron_resizable_behavior/iron_resizable_behavior_demo.dart';
import 'iron_selector/iron_selector_demo.dart';
import 'iron_signals/iron_signals_demo.dart';
import 'iron_validatable_behavior/iron_validatable_behavior_demo.dart';
import 'iron_validator_behavior/iron_validator_behavior_demo.dart';
import 'marked_element/marked_element_demo.dart';
import 'paper_badge/paper_badge_demo.dart';
//import 'paper_behaviors/paper_behaviors_demo.dart';
import 'paper_button/paper_button_demo.dart';
import 'paper_card/paper_card_demo.dart';
import 'paper_checkbox/paper_checkbox_demo.dart';
import 'paper_dialog/paper_dialog_demo.dart';
import 'paper_dialog_behavior/paper_dialog_behavior_demo.dart';
import 'paper_dialog_scrollable/paper_dialog_scrollable_demo.dart';
import 'paper_drawer_panel/paper_drawer_panel_demo.dart';
import 'paper_dropdown_menu/paper_dropdown_menu_demo.dart';
import 'paper_fab/paper_fab_demo.dart';
import 'paper_header_panel/paper_header_panel_demo.dart';
import 'paper_icon_button/paper_icon_button_demo.dart';
import 'paper_input/paper_input_demo.dart';
import 'paper_item/paper_item_demo.dart';
//import 'paper_listbox/paper_listbox_demo.dart';
import 'paper_material/paper_material_demo.dart';
import 'paper_menu/paper_menu_demo.dart';
import 'paper_menu_button/paper_menu_button_demo.dart';
import 'paper_progress/paper_progress_demo.dart';
import 'paper_radio_button/paper_radio_button_demo.dart';
import 'paper_radio_group/paper_radio_group_demo.dart';
import 'paper_ripple/paper_ripple_demo.dart';
import 'paper_scroll_header_panel/paper_scroll_header_panel_demo.dart';
import 'paper_slider/paper_slider_demo.dart';
import 'paper_spinner/paper_spinner_demo.dart';
import 'paper_styles/paper_styles_demo.dart';
import 'paper_tabs/paper_tabs_demo.dart';
import 'paper_toast/paper_toast_demo.dart';
import 'paper_toggle_button/paper_toggle_button_demo.dart';
import 'paper_toolbar/paper_toolbar_demo.dart';
import 'paper_tooltip/paper_tooltip_demo.dart';
//  import 'chartjs_element/index.dart';
//  import 'google_domain_user_picker/google_domain_user_picker_demo.dart';
//  import 'google_drive/google_drive_demo.dart';
//  import 'google_recaptcha/google_recaptcha_demo.dart';
// import 'iron_label/iron_label_demo.dart';
//  import 'neon_animation/card/index.dart';
//  import 'neon_animation/declarative/index.dart';
//  import 'neon_animation/doc/index.dart';
//  import 'neon_animation/dropdown/index.dart';
//  import 'neon_animation/grid/index.dart';
//  import 'neon_animation/list/index.dart';
//  import 'neon_animation/load/index.dart';
//  import 'neon_animation/reprojection/index.dart';
//  import 'neon_animation/tiles/index.dart';


/// Silence analyzer [DemoElements], [PaperItem], [PaperDrawerPanel],
/// [PaperHeaderPanel], [IronList], [PaperToolbar],
/// [FirebaseElementDemo]
/// [GoldCcCvcInputDemo]
/// [GoldCcExpirationInputDemo]
/// [GoldCcInputDemo]
/// [GoldEmailInputDemo]
/// [GoldPhoneInputDemo]
/// [GoldZipInputDemo]
/// [GoogleAnalyticsDemo]
/// [GoogleApisDemo]
/// [GoogleCalendarDemo]
/// [GoogleCastableVideoDemo]
/// [GoogleChartDemo]
/// [GoogleDomainUserPickerDemo]
/// [GoogleDriveDemo]
/// [GoogleFeedsDemo]
/// [GoogleHangoutButtonDemo]
/// [GoogleMapDemo]
/// [GoogleMapPolysDemo]
/// [GoogleRecaptchaDemo]
/// [GoogleSheetsDemo]
/// [GoogleSigninDemo]
/// [GoogleStreetviewPanoDemo]
/// [GoogleUrlShortenerDemo]
/// [GoogleYoutubeDemo]
/// [GoogleYoutubeUploadDemo]
/// [IronA11yAnnouncerDemo]
/// [IronA11yKeysDemo]
/// [IronA11yKeysBehaviorDemo]
/// [IronAjaxDemo]
/// [IronAutogrowTextareaDemo]
/// [IronBehaviorsDemo]
/// [IronCheckedElementBehaviorDemo]
/// [IronCollapseDemo]
/// [IronComponentPageDemo]
/// [IronDocViewerDemo]
/// [IronDropdownDemo]
/// [IronFitBehaviorDemo]
/// [IronFlexLayoutDemo]
/// [IronFormDemo]
/// [IronFormElementBehaviorDemo]
/// [IronIconDemo]
/// [IronIconsDemo]
/// [IronIconsetDemo]
/// [IronIconsetSvgDemo]
/// [IronImageDemo]
/// [IronInputDemo]
/// [IronJsonpLibraryDemo]
/// [IronLabelDemo]
/// [IronListDemo]
/// [IronListCollapseDemo]
/// [IronListExternalContentDemo]
/// [IronListSelectionDemo]
/// [IronLocalstorageDemo]
/// [IronMediaQueryDemo]
/// [IronMenuBehaviorDemo]
/// [IronMetaDemo]
/// [IronOverlayBehaviorDemo]
/// [IronPagesDemo]
/// [IronRangeBehaviorDemo]
/// [IronResizableBehaviorDemo]
/// [IronSelectorDemo]
/// [IronSignalsDemo]
/// [IronValidatableBehaviorDemo]
/// [IronValidatorBehaviorDemo]
/// [MarkedElementDemo]
/// [NeonAnimationCardDemo]
/// [NeonAnimationDeclarativeDemo]
/// [NeonAnimationDocDemo]
/// [NeonAnimationDropdownDemo]
/// [NeonAnimationGridDemo]
/// [NeonAnimationListDemo]
/// [NeonAnimationLoadDemo]
/// [NeonAnimationReprojectionDemo]
/// [NeonAnimationTilesDemo]
/// [PaperBadgeDemo]
/// [PaperBehaviorsDemo]
/// [PaperButtonDemo]
/// [PaperCardDemo]
/// [PaperCheckboxDemo]
/// [PaperDialogDemo]
/// [PaperDialogBehaviorDemo]
/// [PaperDialogScrollableDemo]
/// [PaperDrawerPanelDemo]
/// [PaperDropdownMenuDemo]
/// [PaperFabDemo]
/// [PaperHeaderPanelDemo]
/// [PaperIconButtonDemo]
/// [PaperInputDemo]
/// [PaperItemDemo]
/// [PaperListboxDemo]
/// [PaperMaterialDemo]
/// [PaperMenuDemo]
/// [PaperMenuButtonDemo]
/// [PaperProgressDemo]
/// [PaperRadioButtonDemo]
/// [PaperRadioGroupDemo]
/// [PaperRippleDemo]
/// [PaperScrollHeaderPanelDemo]
/// [PaperSliderDemo]
/// [PaperSpinnerDemo]
/// [PaperStylesDemo]
/// [PaperTabsDemo]
/// [PaperToastDemo]
/// [PaperToggleButtonDemo]
/// [PaperToolbarDemo]
/// [PaperTooltipDemo]
@PolymerRegister('all-demos')
class AllDemos extends PolymerElement {
  AllDemos.created() : super.created();
  @property List<DemoElementItem> demos;

  @property
  DemoElementItem selected;

  void ready() {
    set('demos', demoElements.map((name) => new DemoElementItem(name)).toList());
    _demoList.selectItem(convertToJs(demos.first));
    _loadDemo(demos.first);
  }

  IronList get _demoList => $['demolist'] as IronList;

  @reflectable
  void demoClickHandler(dom.Event event, [_]) {
    // TODO(zoechi) remove workaround when #90 is fixed
    final item = convertToDart(_demoList.jsElement.callMethod(
        'modelForElement', [event.target])['demo']) as DemoElementItem;
    // If the currently selected item is clicked, IronList deselects it.
    // We disable this behavior.
    if (_demoList.selectedItem == null) {
      _demoList.selectItem(convertToJs(item));
    } else {
      _loadDemo(item);
    }
  }

  void _loadDemo(DemoElementItem item) {
    final demo = new dom.Element.tag(item.name);
    final placeholder = Polymer.dom($['placeholder']) as PolymerDom;
    placeholder.childNodes.clear();
    placeholder.append(demo);
  }
}

class DemoElementItem extends JsProxy {
  @reflectable
  bool isActive = false;
  @reflectable
  final String name;
  @reflectable
  DemoElementItem(this.name);

  bool operator ==(other) => other is DemoElementItem && name == other.name;

  @override
  int get hashCode => name.hashCode;
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
//   'google-domain-user-picker-demo',
//   'google-drive-demo',
  'google-feeds-demo',
  'google-hangout-button-demo',
//  'google-map-demo',
//  'google-map-polys-demo',
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
  'iron-checked-element-behavior-demo',
  'iron-collapse-demo',
  'iron-component-page-demo',
  'iron-doc-viewer-demo',
  'iron-dropdown-demo',
  'iron-fit-behavior-demo',
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
//  'iron-label-demo',
  'iron-list-demo',
  'iron-list-collapse-demo',
  'iron-list-external-content-demo',
  'iron-list-selection-demo',
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
//  'paper-behaviors-demo',
  'paper-button-demo',
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
//  'paper-listbox-demo',
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
