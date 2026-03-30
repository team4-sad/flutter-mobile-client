import 'package:miigaik/features/lk/models/semester_entity.dart';

class CourseAcademicPerformance {
  final int course;
  final List<SemesterAcademicPerformance> records;

  CourseAcademicPerformance({required this.course, required this.records});

  factory CourseAcademicPerformance.fromJson(Map<String, dynamic> json) {
    return CourseAcademicPerformance(
      course: json['course'],
      records: (json['records'] as List)
        .map((i) => SemesterAcademicPerformance.fromJson(i))
        .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['course'] = course;
    data['records'] = records.map((v) => v.toJson()).toList();
    return data;
  }
}

class SemesterAcademicPerformance {
  final List<SubjectAcademicPerformance> records;
  final int semester;

  SemesterAcademicPerformance({required this.records, required this.semester});

  factory SemesterAcademicPerformance.fromJson(Map<String, dynamic> json) {
    return SemesterAcademicPerformance(
      records: (json['records'] as List)
        .map((i) => SubjectAcademicPerformance.fromJson(i))
        .toList(),
      semester: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['records'] = records.map((v) => v.toJson()).toList();
    data['semester'] = semester;
    return data;
  }
  
  bool get isHasAcademicDuty => records.any((e) => e.isHasAcademicDuty);

  SemesterEntity toEntity() => SemesterEntity(
    semester: semester,
    isHasDuty: isHasAcademicDuty
  );
}

class SubjectAcademicPerformance {
  final String? rate;
  final String subject;
  final List<String> teachers;
  final String type;

  bool get isHasAcademicDuty => rate == null || ["2", "Неявка", "Не зачтено"].contains(rate);

  SubjectAcademicPerformance({
    required this.rate, required this.subject,
    required this.teachers, required this.type
  });

  factory SubjectAcademicPerformance.fromJson(Map<String, dynamic> json) {
    return SubjectAcademicPerformance(
      rate: json.containsKey("rate") ? json['rate'] : null,
      subject: json['subject'],
      teachers: List<String>.from(json['teachers']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rate'] = rate;
    data['subject'] = subject;
    data['teachers'] = teachers;
    data['type'] = type;
    return data;
  }
}
