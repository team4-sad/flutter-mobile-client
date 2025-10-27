import 'package:flutter/material.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/schedule-choose/schedule_choose_page.dart';

class ScheduleNotSelectedScheduleContent extends StatelessWidget {
  const ScheduleNotSelectedScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: Center(
          child: PlaceholderWidget(
            title: "Расписание не выбрано",
            textButton: "Выбрать расписание",
            onButtonPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScheduleChoosePage()),
              );
            },
          ),
        ),
      ),
    );
  }
}
