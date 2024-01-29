import 'package:flutter/material.dart';

class Category {
  const Category(String this.type, Color this.color);
  final String type;
  final Color color;
}

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}
