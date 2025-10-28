import 'package:datetime_loop/datetime_loop.dart';
import 'package:flutter/material.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_between_lessons.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_schedule.dart';
import 'package:miigaik/theme/values.dart';

class LoadedScheduleContent extends StatelessWidget {
  final List<LessonModel> lessons;

  const LoadedScheduleContent({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList.separated(
        itemCount: lessons.length,
        itemBuilder: (context, index) => ItemSchedule(
          lessonModel: lessons[index]
        ),
        separatorBuilder: (context, index) {
          final beforeLesson = lessons[index];
          final afterLesson = lessons[index + 1];
          final duration = beforeLesson.calcDurationBetweenLessons(afterLesson);
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 15),
            child: ItemBetweenLessons(
              duration: duration, 
              beforeDateTime: beforeLesson.endDateTime, 
              afterDateTime: afterLesson.startDateTime,
            ),
          );
        },
      ),
      padding: EdgeInsets.only(bottom: heightAreaBottomNavBar),
    );
  }
}
