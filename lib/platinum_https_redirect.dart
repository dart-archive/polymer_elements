// DO NOT EDIT: auto-generated with `pub run custom_element_apigen:update`

/// Dart API for the polymer element `platinum_https_redirect`.
@HtmlImport('platinum_https_redirect_nodart.html')
library polymer_elements.lib.src.platinum_https_redirect.platinum_https_redirect;

import 'dart:html';
import 'dart:js' show JsArray, JsObject;
import 'package:web_components/web_components.dart';
import 'package:polymer_interop/polymer_interop.dart';

/// The `<platinum-https-redirect>` element redirects the current page to HTTPS, unless the page is
/// loaded from a web server running on `localhost`.
///
/// Using [HTTP Strict Transport Security](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security)
/// (HSTS) can be used to enforce HTTPS for an entire
/// [origin](https://html.spec.whatwg.org/multipage/browsers.html#origin), following the first visit to
/// any page on the origin. Configuring the underlying web server to
/// [redirect](https://en.wikipedia.org/wiki/HTTP_301) all HTTP requests to their HTTPS equivalents
/// takes care of enforcing HTTPS on the initial visit as well.
/// Both options provide a more robust approach to enforcing HTTPS, but require access to the underlying
/// web server's configuration in order to implement.
///
/// This element provides a client-side option when HSTS and server-enforced redirects aren't possible,
/// such as when deploying code on a shared-hosting provider like
/// [GitHub Pages](https://pages.github.com/).
///
/// It comes in handy when used with other `<platinum-*>` elements, since those elements use
/// [features which are restricted to HTTPS](http://www.chromium.org/Home/chromium-security/prefer-secure-origins-for-powerful-new-features),
/// with an exception to support local web servers.
///
/// It can be used by just adding it to any page, e.g.
///
///     <platinum-https-redirect></platinum-https-redirect>
@CustomElementProxy('platinum-https-redirect')
class PlatinumHttpsRedirect extends HtmlElement with CustomElementProxyMixin, PolymerBase {
  PlatinumHttpsRedirect.created() : super.created();
  factory PlatinumHttpsRedirect() => new Element.tag('platinum-https-redirect');
}
