## 1.0.0-rc.6

* Update to work with polymer_interop v1.0.0-rc.8.
* Update the elements to the latest versions, and add new elements.
  * New element `iron-label`.
  * New element `demo-snippet`.
  * New element `iron-page-url` (beta release, expect changes).
  * New element `iron-swipeable-container`.

## 1.0.0-rc.5

Update the elements to the following versions:

 - `paper-dialog-behavior` 1.1.0
 - `paper-dialog` 1.0.3
 - `paper-header-panel` 1.1.2
 - `paper-elements` 1.0.6

New component:

 - `paper-listbox`

## 1.0.0-rc.4

Update to allow reflectable 0.4.x.

## 1.0.0-rc.3

Update the elements and resolve multiple outstanding issues.

Renamed a few methods for the `firebase-collection` element so they don't
overlap with methods from the `PolymerBase` mixin:

  * `add` => `firebaseAdd`
  * `removeItem` => `firebaseRemove`

## 1.0.0-rc.2

Update the elements to the following versions:

  - iron-elements 1.0.4
  - paper-elements 1.0.5
  - gold-elements 1.0.1
  - neon-elements 1.0.0
  - molecules 1.0.0
  - google-web-components 1.0.1

Also fixed generated mixins for elements with deeply nested behaviors.

## 1.0.0-rc.1

First official release candidate, updated to latest polymer and polymer_interop.

## 0.1.0

This is the initial version.
