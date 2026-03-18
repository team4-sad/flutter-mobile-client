import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class SquareFilledIconButton extends StatelessWidget {
  final double? size;
  final Widget icon;
  final VoidCallback onPress;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? backgroundColor;

  const SquareFilledIconButton({
    super.key,
    required this.icon,
    required this.onPress,
    this.borderRadiusGeometry,
    this.backgroundColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadiusGeometry ?? BorderRadius.circular(10),
            color: backgroundColor ?? context.palette.accent,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onPress,
              child: Container(alignment: Alignment.center, child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
