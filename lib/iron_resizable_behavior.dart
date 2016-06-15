// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `iron_resizable_behavior`.
@HtmlImport('iron_resizable_behavior_nodart.html')
library polymer_elements.lib.src.iron_resizable_behavior.iron_resizable_behavior;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// `IronResizableBehavior` is a behavior that can be used in Polymer elements to
/// coordinate the flow of resize events between "resizers" (elements that control the
/// size or hidden state of their children) and "resizables" (elements that need to be
/// notified when they are resized or un-hidden by their parents in order to take
/// action on their new measurements).
///
/// Elements that perform measurement should add the `IronResizableBehavior` behavior to
/// their element definition and listen for the `iron-resize` event on themselves.
/// This event will be fired when they become showing after having been hidden,
/// when they are resized explicitly by another resizable, or when the window has been
/// resized.
///
/// Note, the `iron-resize` event is non-bubbling.
@BehaviorProxy(const ['Polymer', 'IronResizableBehavior'])
abstract class IronResizableBehavior implements CustomElementProxyMixin {

  /// Used to assign the closest resizable ancestor to this resizable
  /// if the ancestor detects a request for notifications.
  assignParentResizable(parentResizable) =>
      jsElement.callMethod('assignParentResizable', [parentResizable]);

  /// Can be called to manually notify a resizable and its descendant
  /// resizables of a resize change.
  notifyResize() =>
      jsElement.callMethod('notifyResize', []);

  /// This method can be overridden to filter nested elements that should or
  /// should not be notified by the current element. Return true if an element
  /// should be notified, or false if it should not be notified.
  /// [element]: A candidate descendant element that
  ///     implements `IronResizableBehavior`.
  bool resizerShouldNotify(element) =>
      jsElement.callMethod('resizerShouldNotify', [element]);

  /// Used to remove a resizable descendant from the list of descendants
  /// that should be notified of a resize change.
  stopResizeNotificationsFor(target) =>
      jsElement.callMethod('stopResizeNotificationsFor', [target]);
}
