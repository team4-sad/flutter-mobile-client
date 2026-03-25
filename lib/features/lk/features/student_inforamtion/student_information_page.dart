import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/student_inforamtion/widgets/information_container.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class StudentInformationPage extends StatelessWidget {
  const StudentInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Информация о студенте",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Основная информация", style: TS.bold12.use(context.palette.accent)),
              InformationContainer(
                title: "Факультет",
                value: "Факультет Геоинформатики и информационной безопасности"
              ),
              InformationContainer(
                title: "Форма обучения",
                value: "Очная"
              ),
              InformationContainer(
                title: "Основа обучения",
                value: "Бюджетная основа"
              ),
              InformationContainer(
                title: "Уровень подготовки",
                value: "Академический бакалавриат"
              ),
              InformationContainer(
                title: "Направление подготовки",
                value: "09.03.03 Прикладная информатика"
              ),
              InformationContainer(
                title: "Профиль",
                value: "-"
              ),
              Row(
                children: [
                  Expanded(
                    child: InformationContainer(
                      title: "Группа",
                      value: "2023-ФГиИБ-ИСиТибикс-1м"
                    ),
                  ),
                  10.hs(),
                  InformationContainer(
                    width: 70,
                    title: "Курс",
                    value: "3"
                  ),
                ],
              ),
              InformationContainer(
                title: "Статус",
                value: "Является студентом"
              ),
              20.vs(),
              Text("Родство", style: TS.bold12.use(context.palette.accent)),
              InformationContainer(
                title: "Мать",
                value: "Томоко Хигашиката"
              ),
              InformationContainer(
                title: "Отец",
                value: "Джозеф Джостар"
              ),
              50.vs()
            ],
          ),
        ),
      ),
    );
  }
}