import 'package:flutter/material.dart';
import 'package:miigaik/features/add-schedule/add_schedule_page.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';

class ChooseNewSignatureFloatingActionButton extends StatelessWidget {
  const ChooseNewSignatureFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddSchedulePage()),
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: context.palette.lightText,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(I.plus, color: context.palette.unAccent, size: 36),
        ),
      ),
    );
  }

}