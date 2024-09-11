import 'package:flutter/material.dart';


// ignore: non_constant_identifier_names
Hexcolors(String hexcolor){
  hexcolor = hexcolor.toUpperCase().replaceAll("#", "");
  if(hexcolor.length == 6){
    // ignore: prefer_interpolation_to_compose_strings
    hexcolor = "FF" + hexcolor;
  }

  return Color(int.parse(hexcolor, radix: 16));
}