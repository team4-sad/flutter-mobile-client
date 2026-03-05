import 'package:flutter/material.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class AddNoteFloatingActionButton extends StatelessWidget {

  final VoidCallback onTap;

  const AddNoteFloatingActionButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: context.palette.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.palette.container)
          ),
          child: Icon(I.plus, size: 36),
        ),
      ),
    );
  }
}