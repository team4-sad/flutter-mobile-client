import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/extensions/date_time_extensions.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/schedule/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:miigaik/features/schedule/models/response_schedule_model.dart';
import 'package:miigaik/features/schedule/widgets/item_between_lessons.dart';
import 'package:miigaik/features/schedule/widgets/item_schedule.dart';
import 'package:miigaik/features/schedule/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/theme/values.dart';

class LoadedScheduleContent extends StatelessWidget {
  final DayScheduleModel dayScheduleModel;

  const LoadedScheduleContent({
    super.key, 
    required this.dayScheduleModel
  });

  bool get isClassroomSchedule => (GetIt.I.get<ScheduleBloc>().state as ScheduleLoaded)
    .signature.type == SignatureScheduleType.audience;

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
          if (beforeLesson.lessonOrderNumber == afterLesson.lessonOrderNumber) {
            return 15.vs();
          }
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
