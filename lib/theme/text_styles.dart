import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TS {
  static TextStyle medium23 = TextStyle(
    fontSize: 23.sp,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle medium20 = TextStyle(
    fontSize: 20.sp,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle medium18 = TextStyle(
    fontSize: 18.sp,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle light12 = TextStyle(
    fontSize: 12.sp,
    height: 1.2,
    fontWeight: FontWeight.w300
  );

  static TextStyle regular15 = TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle regular13 = TextStyle(
    fontSize: 13.sp,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle regular10 = TextStyle(
    fontSize: 10.sp,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

   static TextStyle regular12 = TextStyle(
    fontSize: 12.sp,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle regular8 = TextStyle(
    fontSize: 8.sp,
    height: 1.2,
    fontWeight: FontWeight.normal
  );

  static TextStyle medium15 = TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium13 = TextStyle(
    fontSize: 13.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium12 = TextStyle(
    fontSize: 12.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium16 = TextStyle(
    fontSize: 16.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium14 = TextStyle(
    fontSize: 14.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle medium10 = TextStyle(
    fontSize: 10.sp,
    height: 1.2,
    fontWeight: FontWeight.w500
  );

  static TextStyle light10 = TextStyle(
    fontSize: 10.sp,
    height: 1.2,
    fontWeight: FontWeight.w300
  );

  static TextStyle bold11 = TextStyle(
    fontSize: 11.sp,
    height: 1.2,
    fontWeight: FontWeight.bold
  );

  static TextStyle bold12 = TextStyle(
    fontSize: 12.sp,
    height: 1.2,
    fontWeight: FontWeight.bold
  );

  static TextStyle bold14 = TextStyle(
    fontSize: 14.sp,
    height: 1.2,
    fontWeight: FontWeight.bold
  );

  static TextStyle bold15 = TextStyle(
      fontSize: 15.sp,
      height: 1.2,
      fontWeight: FontWeight.bold
  );
}

extension InContext on TextStyle {
  TextStyle use(Color color) => copyWith(color: color);
}