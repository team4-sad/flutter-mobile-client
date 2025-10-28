import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemSchedule extends StatelessWidget {
  final LessonModel lessonModel;

  const ItemSchedule({super.key, required this.lessonModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(10),
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
                  child: _TagWidget(title: e.displayName),
                ),
              ),
              _TagWidget(title: lessonModel.lessonType),
              _TagWidget(title: lessonModel.classroomName),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagWidget extends StatelessWidget {
  final String title;

  const _TagWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.palette.calendar,
      ),
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      child: Text(title, style: TS.regular14.use(context.palette.unAccent)),
    );
  }
}
