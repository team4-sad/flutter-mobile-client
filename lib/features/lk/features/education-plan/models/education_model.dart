class EducationDisciplineModel {
  final String discipline;
  final int academicHours;
  final String department;
  final CertificationDisciplineModel certification;

  EducationDisciplineModel({
    required this.discipline,
    required this.academicHours,
    required this.department,
    required this.certification
  });

  factory EducationDisciplineModel.fromJson(Map<String, dynamic> json) => EducationDisciplineModel(
    discipline: json["discipline"],
    academicHours: json["academic_hours"],
    department: json["department"],
    certification: CertificationDisciplineModel.fromJson(json["certification"])
  );
}

class CertificationDisciplineModel {
  final bool exam;
  final bool creditWithRate;
  final bool credit;
  final bool courseWork;
  final bool courseProject;

  CertificationDisciplineModel({
    required this.exam,
    required this.creditWithRate,
    required this.credit,
    required this.courseWork,
    required this.courseProject
  });

  factory CertificationDisciplineModel.fromJson(Map<String, dynamic> json) => CertificationDisciplineModel(
    exam: json["exam"],
    creditWithRate: json["credit_with_rate"],
    credit: json["credit"],
    courseWork: json["course_work"],
    courseProject: json["course_project"],
  );
}