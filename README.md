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
