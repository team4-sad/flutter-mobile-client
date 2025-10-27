import 'package:flutter/material.dart';
import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_between_lessons.dart';
import 'package:miigaik/features/root/tabs/schedule/widgets/item_schedule.dart';
import 'package:miigaik/theme/values.dart';

class LoadedScheduleContent extends StatelessWidget {
  const LoadedScheduleContent({super.key});

  static final data = [
    {
      "groupName": "2023-ФГиИБ-ПИ-1б",
      "subgroup": "",
      "dayOfWeek": 5,
      "lessonDate": "2025-10-31T00:00:00Z",
      "lessonOrderNumber": 3,
      "lessonStartTime": "12:50:00",
      "lessonEndTime": "14:20:00",
      "lessonType": "Практические занятия",
      "classroomId": 410,
      "classroomName": "303 к.2",
      "classroomFloor": 3,
      "classroomType": "Компьютерный класс",
      "classroomBuilding": "2-ой корпус",
      "disciplineName": "Экономическое обоснование проектов",
      "link": "",
      "teachers": [
        {
          "firstName": "Олеся",
          "lastName": "Чужина",
          "patronymic": "Михайловна",
        },
      ],
    },
    {
      "groupName": "2023-ФГиИБ-ПИ-1б",
      "subgroup": "",
      "dayOfWeek": 5,
      "lessonDate": "2025-10-31T00:00:00Z",
      "lessonOrderNumber": 4,
      "lessonStartTime": "14:30:00",
      "lessonEndTime": "16:00:00",
      "lessonType": "Практические занятия",
      "classroomId": 412,
      "classroomName": "508 к.2",
      "classroomFloor": 5,
      "classroomType": "Компьютерный класс",
      "classroomBuilding": "2-ой корпус",
      "disciplineName": "Веб-технологии",
      "link": "",
      "teachers": [
        {
          "firstName": "Аброр",
          "lastName": "Махкамбоев",
          "patronymic": "Ихтиёр угли",
        },
      ],
    },
    {
      "groupName": "2023-ФГиИБ-ПИ-1б",
      "subgroup": "",
      "dayOfWeek": 5,
      "lessonDate": "2025-10-31T00:00:00Z",
      "lessonOrderNumber": 5,
      "lessonStartTime": "16:10:00",
      "lessonEndTime": "17:40:00",
      "lessonType": "Практические занятия",
      "classroomId": 412,
      "classroomName": "508 к.2",
      "classroomFloor": 5,
      "classroomType": "Компьютерный класс",
      "classroomBuilding": "2-ой корпус",
      "disciplineName": "Учебная (проектно-технологическая) практика",
      "link": "",
      "teachers": [
        {
          "firstName": "Роман",
          "lastName": "Злоников",
          "patronymic": "Русланович",
        },
      ],
    },
    {
      "groupName": "2023-ФГиИБ-ПИ-1б",
      "subgroup": "",
      "dayOfWeek": 5,
      "lessonDate": "2025-10-31T00:00:00Z",
      "lessonOrderNumber": 6,
      "lessonStartTime": "17:50:00",
      "lessonEndTime": "19:20:00",
      "lessonType": "Практические занятия",
      "classroomId": 336,
      "classroomName": "450",
      "classroomFloor": 4,
      "classroomType": "Компьютерный класс",
      "classroomBuilding": "Главный корпус",
      "disciplineName": "Информационные технологии",
      "link": "",
      "teachers": [
        {
          "firstName": "Дмитрий",
          "lastName": "Кондрашин",
          "patronymic": "Михайлович",
        },
      ],
    },
    {
      "groupName": "2023-ФГиИБ-ПИ-1б",
      "subgroup": "",
      "dayOfWeek": 5,
      "lessonDate": "2025-10-31T00:00:00Z",
      "lessonOrderNumber": 7,
      "lessonStartTime": "19:30:00",
      "lessonEndTime": "21:00:00",
      "lessonType": "Практические занятия",
      "classroomId": 346,
      "classroomName": "3 к.3",
      "classroomFloor": 1,
      "classroomType": "Компьютерный класс",
      "classroomBuilding": "3-ий корпус",
      "disciplineName": "Проектирование сетей и систем передачи информации",
      "link": "",
      "teachers": [
        {
          "firstName": "Игорь",
          "lastName": "Кондауров",
          "patronymic": "Николаевич",
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList.separated(
        itemCount: data.length,
        itemBuilder: (context, index) =>
            ItemSchedule(lessonModel: LessonModel.fromMap(data[index])),
        separatorBuilder: (context, index) {
          final beforeLesson = LessonModel.fromMap(data[index]);
          final afterLesson = LessonModel.fromMap(data[index + 1]);
          final duration = beforeLesson.calcDurationBetweenLessons(afterLesson);
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 15),
            child: ItemBetweenLessons(duration: duration),
          );
        },
      ),
      padding: EdgeInsets.only(bottom: heightAreaBottomNavBar),
    );
  }
}
