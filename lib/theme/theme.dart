import 'package:flutter/material.dart';

TextStyle textStyle = const TextStyle(
    
    // const Color(0xFFFF8A65),
   color: const Color(0XFFFFFFFF),
    // color: const Color(0xFFE65100),
    fontSize: 16.0,
   
    fontWeight: FontWeight.bold);
    TextStyle DarkTextStyle = const TextStyle(
    
    // const Color(0xFFFF8A65),
   color:const Color(0xFFE65100),
    // color: const Color(0xFFE65100),
    fontSize: 22.0,
   
    fontWeight: FontWeight.normal);

    TextStyle headingTextStyle = const TextStyle(decorationColor: const Color(0xFFFF8A65),
   color: const Color(0XFFFFFFFF),
// color: const Color(0xFFFF8A65),
// color:const Color(0xFFE65100),
//    color: const Color(0xFFFF8A65),
    // color: Colors.yellowAccent,
    fontSize: 42.0,
   
    fontWeight: FontWeight.normal);

ThemeData appTheme = new ThemeData(
    
    primaryIconTheme: new IconThemeData(
        color: secondaryColor
    ),
    iconTheme: new IconThemeData(
        color: secondaryColor
    ),
    highlightColor: Colors.yellow,
    //indicatorColor: Colors.black,
    //cardColor: Colors.black,
    fontFamily:  "Varela Round",
  hintColor: primaryColor,
  //disabledColor: primaryColor,
  primaryColor: primaryColor,
  //canvasColor: secondaryColor,
  accentColor: secondaryColor,
);

Color textFieldColor = const Color.fromRGBO(255, 255, 255, 0.1);

Color primaryColor = const Color(0xFFFF8A65);
Color secondaryColor = const Color(0xFFE65100);

Color primaryIconColor = const Color(0xFFFF8A65);
Color secondaryIconColor = const Color(0x00000000);

TextStyle buttonTextStyle = const TextStyle(
    color: const Color(0xFFFF8A65),
    //color: const Color.fromRGBO(255, 255, 255, 0.8),
    fontSize: 14.0,
   // fontFamily: "Roboto",
    fontWeight: FontWeight.bold);
