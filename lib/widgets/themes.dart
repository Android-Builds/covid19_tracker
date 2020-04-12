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
getTheme(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return 'Dark';
  else
    return 'Light';
}

TextStyle caseStyles = TextStyle(
  fontSize: 15.0,
  fontFamily: 'NewsCycle',
  fontWeight: FontWeight.w700
);

TextStyle countryName = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 20.0
);

TextStyle detailCaseStyles = TextStyle(
  fontSize: 20.0,
  fontFamily: 'NewsCycle',
  fontWeight: FontWeight.w700
);

TextStyle chartText = TextStyle(
  fontWeight: FontWeight.bold
);

TextStyle globalTile = new TextStyle(
  fontWeight: FontWeight.bold
);