import 'package:flutter/material.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class SquareIconButton extends StatelessWidget {
  final double size;
  final Widget icon;
  final VoidCallback onTap;

  const SquareIconButton({
    super.key, 
    required this.size, 
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Ink(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: context.palette.container,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
