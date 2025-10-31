import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';

class ResponseScheduleModel {
  final String groupName;
  final List<DayScheduleModel> schedule;

  ResponseScheduleModel({required this.groupName, required this.schedule});

  factory ResponseScheduleModel.fromMap(Map<String, dynamic> map) {
    return ResponseScheduleModel(
      groupName: map["group_name"] as String, 
      schedule: (map["schedule"] as List).map(
        (e) => DayScheduleModel.fromMap(e)
      ).toList()
    );
  }
}

class DayScheduleModel {
  final int dayOfWeek;
  final String nameDayOfWeek;
  final String date;
  final List<LessonModel> lessons;

  DayScheduleModel({
    required this.dayOfWeek,
    required this.nameDayOfWeek,
    required this.date,
    required this.lessons,
  });

  factory DayScheduleModel.fromMap(Map<String, dynamic> map) {
    return DayScheduleModel(
      dayOfWeek: map["day_of_week"] as int,
      nameDayOfWeek: map["name_day_of_week"] as String,
      date: map["date"] as String,
      lessons: (map["lessons"] as List)
          .map((e) => LessonModel.fromMap(e))
          .toList(),
    );
  }
  
  DateTime get onlyDate => DateTime.parse(date);
}
