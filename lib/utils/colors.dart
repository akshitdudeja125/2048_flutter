import 'package:flutter/material.dart';

Map<int, Color> tileColors = <int, Color>{
  2: Colors.orange.shade50,
  4: Colors.orange.shade100,
  8: Colors.orange.shade200,
  16: Colors.orange.shade300,
  32: Colors.orange.shade400,
  64: Colors.orange.shade500,
  128: Colors.orange.shade600,
  256: Colors.orange.shade700,
  512: Colors.orange.shade800,
  1024: Colors.orange.shade900,
  2048: Colors.deepOrange,
};

Color? getTileColor(int value) {
  return tileColors[value];
}

const backgroundColor = Color.fromARGB(255, 217, 215, 203);
const textColor = Color(0xff776e65);
const textColorWhite = Color(0xfff9f6f2);
const boardColor = Color(0xffbbada0);
const emptyTileColor = Color(0xffcdc1b4);

const buttonColor = Color(0xff8f7a66);
const scoreColor = Color(0xffbbada0);
