import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';

import 'teacher_model.dart';

class LessonModel {
  final String groupName;
  final String subgroup;
  final int dayOfWeek;
  final String lessonDate;
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
  final String link;
  final List<TeacherModel> teachers;
  LessonModel({
    required this.groupName,
    required this.subgroup,
    required this.dayOfWeek,
    required this.lessonDate,
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
    required this.link,
    required this.teachers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupName': groupName,
      'subgroup': subgroup,
      'dayOfWeek': dayOfWeek,
      'lessonDate': lessonDate,
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
      'link': link,
      'teachers': teachers.map((x) => x.toMap()).toList(),
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      groupName: map['groupName'] as String,
      subgroup: map['subgroup'] as String,
      dayOfWeek: map['dayOfWeek'].toInt() as int,
      lessonDate: map['lessonDate'] as String,
      lessonOrderNumber: map['lessonOrderNumber'].toInt() as int,
      lessonStartTime: map['lessonStartTime'] as String,
      lessonEndTime: map['lessonEndTime'] as String,
      lessonType: map['lessonType'] as String,
      classroomId: map['classroomId'].toInt() as int,
      classroomName: map['classroomName'] as String,
      classroomFloor: map['classroomFloor'].toInt() as int,
      classroomType: map['classroomType'] as String,
      classroomBuilding: map['classroomBuilding'] as String,
      disciplineName: map['disciplineName'] as String,
      link: map['link'] as String,
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

  DateTime get start => DateFormat("HH:mm:ss").parse(lessonStartTime);
  DateTime get end => DateFormat("HH:mm:ss").parse(lessonEndTime);

  String get displayStartTime => DateFormat("HH:mm").format(start);
  String get displayEndTime => DateFormat("HH:mm").format(end);

  String get displayTime => "$displayStartTime-$displayEndTime";

  Duration calcDurationBetweenLessons(LessonModel other) {
    if (other.start.isAfter(end)) {
      return other.start.difference(end);
    } else {
      return other.end.difference(start);
    }
  }
}
