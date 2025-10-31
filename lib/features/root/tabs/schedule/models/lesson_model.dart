import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:miigaik/features/common/extensions/date_time_extensions.dart';

import 'teacher_model.dart';

class LessonModel {
  final String subgroup;
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
  final List<TeacherModel> teachers;
  LessonModel({
    required this.subgroup,
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
    required this.teachers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subgroup': subgroup,
      'lessonOrderNumber': lessonOrderNumber,
      'lessonStartTime': lessonStartTime,
      'lessonEndTime': lessonEndTime,
      'lessonType': lessonType,
      'classroomId': classroomId,
      'classroomName': classroomName,
      'classroomFloor': classroomFloor,
      'classroomType': classroomType,
      'classroomBuilding': classroomBuilding,
      'disciplineName': disciplineName,
      'teachers': teachers.map((x) => x.toMap()).toList(),
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      subgroup: map['subgroup'] as String,
      lessonOrderNumber: map['lessonOrderNumber'] as int,
      lessonStartTime: map['lessonStartTime'] as String,
      lessonEndTime: map['lessonEndTime'] as String,
      lessonType: map['lessonType'] as String,
      classroomId: map['classroomId'].toInt() as int,
      classroomName: map['classroomName'] as String,
      classroomFloor: map['classroomFloor'].toInt() as int,
      classroomType: map['classroomType'] as String,
      classroomBuilding: map['classroomBuilding'] as String,
      disciplineName: map['disciplineName'] as String,
      teachers: List<TeacherModel>.from(
        (map['teachers'] as List).map<TeacherModel>(
          (x) => TeacherModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
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
}
