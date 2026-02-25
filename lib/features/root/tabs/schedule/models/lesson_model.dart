import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';
import 'package:miigaik/features/root/tabs/map/models/room_model.dart';

import 'teacher_model.dart';

class LessonModel {
  final String? subgroup;
  final int lessonOrderNumber;
  final String lessonStartTime;
  final String lessonEndTime;
  final String lessonType;
  final int classroomId;
  final String classroomName;
  final int classroomFloor;
  final String classroomType;
  final String classroomBuilding;
  final String disciplineName;
  final List<TeacherModel>? teachers;
  final List<String>? groups;

  LessonModel({
    this.subgroup,
    required this.lessonOrderNumber,
    required this.lessonStartTime,
    required this.lessonEndTime,
    required this.lessonType,
    required this.classroomId,
    required this.classroomName,
    required this.classroomFloor,
    required this.classroomType,
    required this.classroomBuilding,
    required this.disciplineName,
    this.teachers,
    this.groups,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subgroup': subgroup,
      'lesson_order_number': lessonOrderNumber,
      'lesson_start_time': lessonStartTime,
      'lesson_end_time': lessonEndTime,
      'lesson_type': lessonType,
      'classroom_id': classroomId,
      'classroom_name': classroomName,
      'classroom_floor': classroomFloor,
      'classroom_type': classroomType,
      'classroom_building': classroomBuilding,
      'discipline_name': disciplineName,
      'teachers': teachers?.map((x) => x.toMap()).toList(),
      'groups': groups,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      subgroup: map['subgroup'] as String?,
      lessonOrderNumber: map['lesson_order_number'] as int,
      lessonStartTime: map['lesson_start_time'] as String,
      lessonEndTime: map['lesson_end_time'] as String,
      lessonType: map['lesson_type'] as String,
      classroomId: map['classroom_id'].toInt() as int,
      classroomName: map['classroom_name'] as String,
      classroomFloor: map['classroom_floor'].toInt() as int,
      classroomType: map['classroom_type'] as String,
      classroomBuilding: map['classroom_building'] as String,
      disciplineName: map['discipline_name'] as String,
      teachers: (map['teachers'] as List?)?.map<TeacherModel>(
        (x) => TeacherModel.fromMap(x as Map<String, dynamic>),
      ).toList(),
      groups: (map["groups"] as List?)?.map((e) => e as String).toList()
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonModel.fromJson(String source) =>
      LessonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  DateTime get startTime => DateFormat("HH:mm:ss").parse(lessonStartTime);
  DateTime startDateTime(DateTime onlyDate) => startTime.setDate(onlyDate);

  DateTime get endTime => DateFormat("HH:mm:ss").parse(lessonEndTime);
  DateTime endDateTime(DateTime onlyDate) => endTime.setDate(onlyDate);

  String get displayStartTime => DateFormat("HH:mm").format(startTime);
  String get displayEndTime => DateFormat("HH:mm").format(endTime);

  String get displayTime => "$displayStartTime-$displayEndTime";

  Duration calcDurationBetweenLessons(LessonModel other) {
    if (other.startTime.isAfter(endTime)) {
      return other.startTime.difference(endTime);
    } else {
      return other.endTime.difference(startTime);
    }
  }

  bool isAlreadyUnderway(DateTime currentDateTime, DateTime onlyDate) {
    return currentDateTime.isBetween(
      startDateTime(onlyDate), 
      endDateTime(onlyDate)
    );
  }

  RoomModel toRoomModel() {
    return RoomModel(
      id: classroomId,
      label: classroomName,
      floor: classroomFloor
    );
  }
}
