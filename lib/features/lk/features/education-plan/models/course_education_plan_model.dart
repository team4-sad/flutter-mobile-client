import 'package:miigaik/features/lk/features/education-plan/models/semester_education_plan_model.dart';

class CourseEducationPlanModel {
  final int course;
  final List<SemesterEducationPlanModel> semesters;

  CourseEducationPlanModel({required this.course, required this.semesters});

  factory CourseEducationPlanModel.fromJson(Map<String, dynamic> json) => CourseEducationPlanModel(
    course: json["course"],
    semesters: (json["semesters"] as List).map((e) => SemesterEducationPlanModel.fromJson(e)).toList()
  );
}