import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/tag_widget.dart';
import 'package:miigaik/features/academic-performance/models/academic_performance.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemAcademicPerformance extends StatelessWidget {

  final SubjectAcademicPerformance subject;

  const ItemAcademicPerformance({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: 14,
        horizontal: 14
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: context.palette.container
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: (subject.isHasAcademicDuty) ? context.palette.red : context.palette.tag,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Center(
                  child: (subject.isHasAcademicDuty)
                    ? Text("!", style: TS.regular13.use(context.palette.unAccent))
                    : (subject.rate == "Зачёт")
                      ? Icon(I.check, color: context.palette.unAccent, size: 14)
                      : Text(subject.rate.toString(), style: TS.regular13.use(context.palette.unAccent))
                )
              ),
              10.hs(),
              Text(subject.type, style: TS.medium14.use(context.palette.text))
            ],
          ),
          12.vs(),
          Text(subject.subject, style: TS.medium15.use(context.palette.text)),
          18.vs(),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              if (subject.isHasAcademicDuty)
                TagWidget(
                  title: "Долг",
                  selectedBackgroundColor: context.palette.red
                ),
              ...subject.teachers.map(
                (e) => TagWidget(
                  title: e,
                  selectedBackgroundColor: (subject.isHasAcademicDuty)
                    ? context.palette.red
                    : context.palette.tag
                )
              )
            ],
          )
        ],
      ),
    );
  }
}