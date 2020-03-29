import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

getIconTheme(context) {
  return new IconThemeData(
    color: getColor(context)
  );
}


 getColor(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}