import 'package:flutter/material.dart';

Color getColorForTag(String tag) {
  switch (tag) {
    case 'bacterial_leaf_blight':
      return Colors.red; // or any color you prefer
    case 'bacterial_leaf_streak':
      return Colors.blue; // or any color you prefer
    case 'bacterial_panicle_blight':
      return Colors.green; // or any color you prefer
    case 'black_stem_borer':
      return Colors.orange; // or any color you prefer
    case 'blast':
      return Colors.yellow; // or any color you prefer
    case 'brown_spot':
      return Colors.purple; // or any color you prefer
    case 'downy_mildew':
      return Colors.teal; // or any color you prefer
    case 'hispa':
      return Colors.cyan; // or any color you prefer
    case 'leaf_roller':
      return Colors.brown; // or any color you prefer
    case 'normal':
      return Colors.black; // or any color you prefer
    case 'tungro':
      return Colors.indigo; // or any color you prefer
    case 'white_stem_borer':
      return Colors.deepOrange; // or any color you prefer
    case 'yellow_stem_borer':
      return Colors.amber; // or any color you prefer
    default:
      return Colors.white; // default color
  }
}