import 'package:flutter/material.dart';

abstract class TS {
  static TextStyle medium25 = TextStyle(
    fontSize: 25,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle medium20 = TextStyle(
    fontSize: 20,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle light15 = TextStyle(
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w300
  );

  static TextStyle regular15 = TextStyle(
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle regular12 = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

   static TextStyle regular14 = TextStyle(
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle regular10 = TextStyle(
    fontSize: 10,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle medium15 = TextStyle(
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium14 = TextStyle(
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium16 = TextStyle(
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium12 = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle light12 = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w300
  );
}

extension InContext on TextStyle {
  TextStyle use(Color color) => copyWith(color: color);
}