import 'package:miigaik/features/root/tabs/schedule/models/lesson_model.dart';
import 'package:miigaik/features/root/tabs/schedule/models/teacher_model.dart';

abstract class BaseScheduleModel {
  final List<DayScheduleModel> schedule;

  BaseScheduleModel({required this.schedule});
}

class ResponseGroupScheduleModel extends BaseScheduleModel {
  final String groupName;

  ResponseGroupScheduleModel({
    required this.groupName,
    required super.schedule,
  });

  factory ResponseGroupScheduleModel.fromMap(Map<String, dynamic> map) {
    return ResponseGroupScheduleModel(
      groupName: map["group_name"] as String,
      schedule: (map["schedule"] as List)
          .map((e) => DayScheduleModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    "group_name": groupName,
    "schedule": schedule.map((e) => e.toMap()).toList()
  };
}

class ResponseAudienceScheduleModel extends BaseScheduleModel {
  final String audienceName;

  ResponseAudienceScheduleModel({
    required this.audienceName,
    required super.schedule,
  });

  factory ResponseAudienceScheduleModel.fromMap(Map<String, dynamic> map) {
    return ResponseAudienceScheduleModel(
      audienceName: map["classroom_name"] as String,
      schedule: (map["schedule"] as List)
          .map((e) => DayScheduleModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    "classroom_name": audienceName,
    "schedule": schedule.map((e) => e.toMap()).toList()
  };
}

class ResponseTeacherScheduleModel extends BaseScheduleModel {
  final TeacherModel teacher;

  ResponseTeacherScheduleModel({
    required this.teacher,
    required super.schedule,
  });

  factory ResponseTeacherScheduleModel.fromMap(Map<String, dynamic> map) {
    return ResponseTeacherScheduleModel(
      teacher: TeacherModel.fromMap(map["teacher"]),
      schedule: (map["schedule"] as List)
          .map((e) => DayScheduleModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    "teacher": teacher.toMap(),
    "schedule": schedule.map((e) => e.toMap()).toList()
  };
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

  Map<String, dynamic> toMap() => {
    "day_of_week": dayOfWeek,
    "name_day_of_week": nameDayOfWeek,
    "date": date,
    "lessons": lessons.map((e) => e.toMap()).toList()
  };

  DateTime get onlyDate => DateTime.parse(date);
}
