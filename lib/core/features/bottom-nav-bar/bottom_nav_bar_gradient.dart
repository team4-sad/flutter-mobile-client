import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class BottomNavBarGradient extends StatelessWidget {

  final Widget child;

  const BottomNavBarGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.palette.background,
            context.palette.background.withAlpha(0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )
      ),
      child: child
    );
  }
}