import 'package:miigaik/features/lk/features/education-plan/models/education_model.dart';
import 'package:miigaik/features/lk/models/semester_entity.dart';

class SemesterEducationPlanModel {
  final int semester;
  final List<EducationDisciplineModel> plan;

  SemesterEducationPlanModel({required this.semester, required this.plan});

  factory SemesterEducationPlanModel.fromJson(Map<String, dynamic> json) => SemesterEducationPlanModel(
    semester: json["semester"],
    plan: (json["plan"] as List).map((e) => EducationDisciplineModel.fromJson(e)).toList()
  );

  SemesterEntity toEntity() => SemesterEntity(semester: semester, isHasDuty: false);
}