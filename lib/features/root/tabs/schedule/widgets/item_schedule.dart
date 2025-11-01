import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/tag_widget.dart';
import 'package:miigaik/features/root/tabs/schedule/bloc/current_time_cubit/current_time_cubit.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemSchedule extends StatelessWidget {
  final DateTime onlyDate;
  final LessonModel lessonModel;

  const ItemSchedule({
    super.key, 
    required this.lessonModel,
    required this.onlyDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentTimeCubit, CurrentTimeState>(
      bloc: GetIt.I.get(),
      builder: (BuildContext context, CurrentTimeState state) {
        return Container(
          decoration: BoxDecoration(
            color: context.palette.container,
            borderRadius: BorderRadius.circular(10),
            border: BoxBorder.all(
              color: lessonModel.isAlreadyUnderway(
                state.currentDateTime, onlyDate 
              ) ? context.palette.calendar 
                : Colors.transparent,
              width: 2
            )
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: context.palette.calendar,
                    ),
                    child: Center(
                      child: Text(
                        lessonModel.lessonOrderNumber.toString(),
                        style: TS.regular14.use(context.palette.unAccent),
                      ),
                    ),
                  ),
                  10.hs(),
                  Expanded(
                    child: Text(
                      lessonModel.displayTime,
                      style: TS.medium14.use(context.palette.calendar),
                    ),
                  ),
                  10.hs(),
                  GestureDetector(
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: context.palette.calendar,
                      ),
                      child: Center(
                        child: Icon(
                          I.map,
                          color: context.palette.unAccent,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              14.vs(),
              Text(
                lessonModel.disciplineName,
                style: TS.medium16.use(context.palette.text),
              ),
              22.vs(),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  ...lessonModel.teachers.map(
                    (e) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(title: Text(e.fio)),
                        );
                      },
                      child: TagWidget(title: e.displayName),
                    ),
                  ),
                  TagWidget(title: lessonModel.lessonType),
                  TagWidget(title: lessonModel.classroomName),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
