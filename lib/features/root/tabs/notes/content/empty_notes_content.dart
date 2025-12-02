import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';

class EmptyNotesContent extends StatelessWidget {
  const EmptyNotesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Center(
        child: PlaceholderWidget(
          title: "Заметок нет",
          subTitle: "Добавьте новую заметку",
        )
      ),
    );
  }
}