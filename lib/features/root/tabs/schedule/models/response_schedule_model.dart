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

  factory ResponseGroupScheduleModel.fromMiigaikMap(
    Map<String, dynamic> map,
  ) {
    return ResponseGroupScheduleModel(
      groupName: map["groupName"],
      schedule: DayScheduleModel.fromMiigaikData(map["schedule"])
    );
  }
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

  factory ResponseAudienceScheduleModel.fromMiigaikMap(
    Map<String, dynamic> map,
  ) {
    return ResponseAudienceScheduleModel(
      audienceName: map["classroomName"],
      schedule: DayScheduleModel.fromMiigaikData(map["schedule"])
    );
  }
}

class ResponseTeacherScheduleModel extends BaseScheduleModel {
  final TeacherModel teacher;

  ResponseTeacherScheduleModel({
    required this.teacher,
    required super.schedule,
  });

  factory ResponseTeacherScheduleModel.fromMap(Map<String, dynamic> map) {
    return ResponseTeacherScheduleModel(
      teacher: TeacherModel.fromMiigaikMap(map["teacher"]),
      schedule: (map["schedule"] as List)
          .map((e) => DayScheduleModel.fromMap(e))
          .toList(),
    );
  }

  factory ResponseTeacherScheduleModel.fromMiigaikMap(
    Map<String, dynamic> map,
  ) {
    return ResponseTeacherScheduleModel(
      teacher: TeacherModel.fromMiigaikMap(map["teacher"]),
      schedule: DayScheduleModel.fromMiigaikData(map["schedule"])
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

  static List<DayScheduleModel> fromMiigaikData(Map<String, dynamic> map) {
    return map.entries
      .map(
        (e) => DayScheduleModel(
          dayOfWeek: (e.value as List).first["dayOfWeek"] as int,
          nameDayOfWeek: e.key,
          date: ((e.value as List).first["lessonDate"] as String)
              .replaceFirst("T00:00:00Z", ""),
          lessons: (e.value as List).map(
            (l) => LessonModel.fromMiigaikMap(l)
          ).toList(),
        ),
      )
      .toList();
  }

  DateTime get onlyDate => DateTime.parse(date);
}
