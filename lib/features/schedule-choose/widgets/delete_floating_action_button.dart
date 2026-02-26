import 'package:flutter/material.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class DeleteFloatingActionButton extends StatelessWidget {

  final VoidCallback onDelete;

  const DeleteFloatingActionButton({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDelete,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: context.palette.lightText,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(I.trash, color: context.palette.unAccent, size: 36),
        ),
      ),
    );
  }

}