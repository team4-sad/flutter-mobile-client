import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';

class EmptyScheduleContent extends StatelessWidget {
  const EmptyScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: Center(
          child: PlaceholderWidget(
            title: "Выходной",
            subTitle: "По расписанию нет пар",
          ),
        ),
      ),
    );
  }
}
