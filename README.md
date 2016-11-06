# Polymer elements

This package wraps the Polymer project's included js elements, providing the
following features:

 * Because the elements are bundled into a single pub package, you can add
   `polymer_elements` as a dependency in your pubspec. You don't need to
   install npm or bower.
 * The elements are wrapped with Dart proxy classes, making them easier to
   interact with from Dart apps.
   
You can find out more about Polymer elements here:
https://elements.polymer-project.org/


## Using elements

All elements live at the top level of the `lib/` folder.

Import into HTML:

    <link rel="import" href="packages/polymer_elements/iron_input.html">

Import into Dart:

    import 'package:polymer_elements/iron_input.dart';

### platinum-elements

For `platinum-sw-register` to work properly the following requirements should be met:

 1. you have to provide an `sw-import.js`
   script in the root of your application containing only the following line:


    importScripts('packages/polymer_elements/src/platinum-sw/service-worker.js');

 2. `baseUri` should be set to point to *'packages/polymer_elements/src/platinum-sw/'* (with trailing slash), for example :


    <platinum-sw-register base-uri='packages/polymer_elements/src/platinum-sw/'>
     <platinum-sw-cache></platinum-sw-cache>
    </platinum-sw-register>


