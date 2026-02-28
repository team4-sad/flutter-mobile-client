import 'package:flutter/material.dart';
import 'package:miigaik/theme/palette.dart';
import 'package:path/path.dart';
import 'app_theme.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final AppTheme appTheme;
  final Palette palette;

  const AppThemeExtension({required this.appTheme, required this.palette});

  factory AppThemeExtension.fromAppTheme(AppTheme appTheme){
    final Palette palette = Palette.fromAppTheme(appTheme);
    return AppThemeExtension._(appTheme, palette);
  }

  AppThemeExtension._(this.appTheme, this.palette);

  static AppThemeExtension of(BuildContext context){
    return Theme.of(context).extension<AppThemeExtension>()!;
  }

  @override
  ThemeExtension<AppThemeExtension> copyWith() {
    return AppThemeExtension.fromAppTheme(appTheme);
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      appTheme: other.appTheme,
      palette: Palette.lerp(palette, other.palette, t),
    );
  }

  ThemeData getThemeData({
    String? fontFamily
  }) {
    final baseThemeData = ThemeData(
      fontFamily: fontFamily,
      iconTheme: IconThemeData(
        color: palette.subText
      )
    );
    final themeData = switch (appTheme) {
      AppTheme.light => baseThemeData.copyWith(
        brightness: Brightness.light
      ),
      AppTheme.dark => baseThemeData.copyWith(
        brightness: Brightness.dark
      )
    };
    return themeData.copyWith(
      primaryColor: palette.accent,
      scaffoldBackgroundColor: palette.background,
      extensions: [this],
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: palette.accent,
        selectionColor: palette.accent.withAlpha(48),
        selectionHandleColor: palette.accent,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette.accent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: palette.accent,
          foregroundColor: palette.unAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        checkColor: WidgetStateProperty.all(palette.background),
        side: BorderSide(
          color: palette.text,
          width: 2
        ),
        fillColor: WidgetStateProperty.resolveWith((state){
          if (state.contains(WidgetState.selected)){
            return palette.text;
          }else if (state.contains(WidgetState.hovered)){
            return palette.text.withAlpha(24);
          }else{
            return palette.background;
          }
        })
      )
    );
  }
}

extension InContext on BuildContext {
  AppThemeExtension get appTheme => AppThemeExtension.of(this);
  Palette get palette => appTheme.palette;
}