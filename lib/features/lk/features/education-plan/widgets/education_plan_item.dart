import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/tag_widget.dart';
import 'package:miigaik/features/lk/features/education-plan/models/education_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class EducationPlanItem extends StatelessWidget {

  final EducationDisciplineModel educationDisciplineModel;

  const EducationPlanItem({super.key, required this.educationDisciplineModel});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: 14,
        vertical: 16
      ),
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            educationDisciplineModel.discipline,
            style: TS.medium16.use(context.palette.text)
          ),
          5.vs(),
          Text(
            educationDisciplineModel.department,
            style: TS.regular13.use(context.palette.subText)
          ),
          12.vs(),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              TagWidget(title: "Зачет с оценкой"),
              TagWidget(title: "${educationDisciplineModel.academicHours} часа"),
            ],
          )
        ],
      ),
    );
  }
}