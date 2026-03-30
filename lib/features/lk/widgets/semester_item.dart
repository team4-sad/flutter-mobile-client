import 'package:flutter/material.dart';
import 'package:miigaik/features/lk/models/semester_entity.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class SemesterItem extends StatelessWidget {

  final SemesterEntity semester;
  final bool isSelected;
  final VoidCallback onTap;

  const SemesterItem({
    super.key,
    required this.isSelected,
    required this.semester,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final isHasDuty = semester.isHasDuty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: 7,
          horizontal: 17
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (isSelected)
            ? context.palette.tag
            : (isHasDuty)
              ? context.palette.lightRed
              : context.palette.container
        ),
        child: Center(
          child: Text(
            "${semester.semester} семестр",
            style: TS.regular12.use(
              (isSelected)
                ? context.palette.unAccent
                : (isHasDuty)
                  ? context.palette.darkRed
                  : context.palette.text
            )
          ),
        ),
      ),
    );
  }
}