import 'package:flutter/material.dart';

import 'app_theme.dart';

class Palette {
  final Color accent;
  final Color unAccent;
  final Color text;
  final Color subText;
  final Color background;
  final Color container;
  final Color tag;
  final Color currentLessonBorder;
  final Color lightText;
  final Color lightRed;
  final Color red;
  final Color darkRed;

  final BoxShadow mapShadow;

  Palette({
    required this.accent,
    required this.unAccent,
    required this.text,
    required this.subText,
    required this.background,
    required this.container,
    required this.lightText,
    required this.tag,
    required this.currentLessonBorder,
    required this.mapShadow,
    required this.lightRed,
    required this.red,
    required this.darkRed,
  });

  static Palette fromAppTheme(AppTheme appTheme) {
    return switch (appTheme) {
      AppTheme.light => Palette(
        accent: Color(0xFF4964BE),
        unAccent: Color(0xFFFFFFFF),
        text: Color(0xFF000000),
        subText: Color(0xFF939396),
        background: Color(0xFFFFFFFF),
        container: Color(0xFFF2F3F5),
        lightText: Color(0xFF2A2929),
        tag: Color(0xFF3B3C51),
        currentLessonBorder: Color(0xFF9D9D9D),
        mapShadow: BoxShadow(
          blurRadius: 6.0,
          offset: Offset(0, 4),
          color: Color(0x25000000)
        ),
        lightRed: Color(0xFFE8CACB),
        red: Color(0xFF862E30),
        darkRed: Color(0xFF581416),
      ),
      // Пока нет тёмной темы
      AppTheme.dark => Palette(
        accent: Color(0xFF4964BE),
        currentLessonBorder: Color(0xFF9D9D9D),
        unAccent: Color(0xFFFFFFFF),
        text: Color(0xFFFFFFFF),
        subText: Color(0xFF939396),
        background: Color(0xFF000000),
        container: Color(0xFF313131),
        lightText: Color(0xFF2A2929),
        tag: Color(0xFF3B3C51),
        mapShadow: BoxShadow(
          blurRadius: 6.0,
          offset: Offset(0, 4),
          color: Color(0x25000000)
        ),
        lightRed: Color(0xFFE8CACB),
        red: Color(0xFF862E30),
        darkRed: Color(0xFF581416),
      ),
    };
  }

  static Palette lerp(Palette first, Palette other, double t) {
    return Palette(
      accent: Color.lerp(first.accent, other.accent, t)!,
      unAccent: Color.lerp(first.unAccent, other.unAccent, t)!,
      text: Color.lerp(first.text, other.text, t)!,
      subText: Color.lerp(first.subText, other.subText, t)!,
      background: Color.lerp(first.background, other.background, t)!,
      container: Color.lerp(first.container, other.container, t)!,
      lightText: Color.lerp(first.lightText, other.lightText, t)!,
      tag: Color.lerp(first.tag, other.tag, t)!,
      lightRed: Color.lerp(first.lightRed, other.lightRed, t)!,
      darkRed: Color.lerp(first.darkRed, other.darkRed, t)!,
      red: Color.lerp(first.red, other.red, t)!,
      currentLessonBorder: Color.lerp(first.currentLessonBorder, other.currentLessonBorder, t)!,
      mapShadow: first.mapShadow.copyWith(
        color: Color.lerp(first.mapShadow.color, other.mapShadow.color, t)!
      )
    );
  }
}
