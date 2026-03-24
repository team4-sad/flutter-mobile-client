import 'package:flutter/material.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';

class EmptyExamsWidget extends StatelessWidget {
  const EmptyExamsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderWidget(
      title: "Экзамены впереди ;)",
      subTitle: "После сдачи первых экзаменов вы узнаете свою успеваемость"
    );
  }
}