import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/lk/features/profile/models/profile_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

import 'information_container.dart';

class LoadedInformation extends StatelessWidget {

  final EducationInfo educationInfo;
  final List<Family> family;

  const LoadedInformation({
    super.key,
    required this.educationInfo,
    required this.family
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Основная информация", style: TS.bold12.use(context.palette.accent)),
          InformationContainer(
            title: "Факультет",
            value: educationInfo.faculty
          ),
          InformationContainer(
            title: "Форма обучения",
            value: educationInfo.form
          ),
          InformationContainer(
            title: "Основа обучения",
            value: educationInfo.typeForm
          ),
          InformationContainer(
            title: "Уровень подготовки",
            value: educationInfo.level
          ),
          InformationContainer(
            title: "Направление подготовки",
            value: educationInfo.direction
          ),
          InformationContainer(
            title: "Профиль",
            value: educationInfo.displayProfile
          ),
          Row(
            children: [
              Expanded(
                child: InformationContainer(
                  title: "Группа",
                  value: educationInfo.group
                ),
              ),
              10.hs(),
              InformationContainer(
                width: 70,
                title: "Курс",
                value: educationInfo.course
              ),
            ],
          ),
          InformationContainer(
            title: "Статус",
            value: educationInfo.status
          ),
          10.vs(),
          Text("Родство", style: TS.bold12.use(context.palette.accent)),
          ...family.map(
            (e) =>  InformationContainer(
              title: e.kinship,
              value: e.fio
            ),
          ),
          50.vs()
        ],
      ),
    );
  }
}