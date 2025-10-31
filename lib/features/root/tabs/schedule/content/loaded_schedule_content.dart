import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/root/tabs/schedule/models/response_schedule_model.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_between_lessons.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_schedule.dart';
import 'package:miigaik/theme/values.dart';

class LoadedScheduleContent extends StatelessWidget {
  final DayScheduleModel dayScheduleModel;

  const LoadedScheduleContent({
    super.key, 
    required this.dayScheduleModel
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList.separated(
        itemCount: dayScheduleModel.lessons.length,
        itemBuilder: (context, index) => ItemSchedule(
          lessonModel:  dayScheduleModel.lessons[index],
          onlyDate: dayScheduleModel.onlyDate,
        ),
        separatorBuilder: (context, index) {
          final beforeLesson = dayScheduleModel.lessons[index];
          final afterLesson = dayScheduleModel.lessons[index + 1];
          final duration = beforeLesson.calcDurationBetweenLessons(afterLesson);
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 15),
            child: ItemBetweenLessons(
              duration: duration, 
              beforeDateTime: beforeLesson.endTime.setDate(dayScheduleModel.onlyDate), 
              afterDateTime: afterLesson.startTime.setDate(dayScheduleModel.onlyDate),
            ),
          );
        },
      ),
      padding: EdgeInsets.only(bottom: heightAreaBottomNavBar),
    );
  }
}
