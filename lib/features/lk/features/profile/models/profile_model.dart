class ProfileModel {
  final String firstName;
  final String lastName;
  final String patronymic;
  final String lkEmail;
  final String email;
  final String address;
  final String jobPlace;
  final String jobTitle;
  final String numberStudentCard;
  final String datetimeStudentCard;
  final String recordBookNumber;
  final List<EducationInfo> educationInfo;
  final List<Family> family;
  
  ProfileModel({
    required this.firstName, 
    required this.lastName, 
    required this.patronymic, 
    required this.lkEmail, 
    required this.email, 
    required this.address, 
    required this.jobTitle, 
    required this.numberStudentCard, 
    required this.datetimeStudentCard, 
    required this.recordBookNumber, 
    required this.educationInfo, 
    required this.family, 
    required this.jobPlace
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      patronymic: json['patronymic'],
      lkEmail: json['lk_email'],
      email: json['email'],
      address: json['address'],
      jobPlace: json['job_place'],
      jobTitle: json['job_title'],
      numberStudentCard: json['number_student_card'],
      datetimeStudentCard: json['datetime_student_card'],
      recordBookNumber: json['record_book_number'],
      educationInfo: (json.containsKey("education_info"))
        ? (json['education_info'] as List).map((v) => EducationInfo.fromJson(v)).toList()
        : [],
      family: (json.containsKey("family"))
        ? (json['family'] as List).map((v) => Family.fromJson(v)).toList()
        : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": firstName,
    "patronymic": firstName,
    "lk_email": firstName,
    "email": firstName,
    "address": firstName,
    "job_place": firstName,
    "job_title": firstName,
    "number_student_card": firstName,
    "datetime_student_card": firstName,
    "record_book_number": firstName,
    "education_info": educationInfo.map((e) => e.toJson()),
    "family": family.map((e) => e.toJson()),
  };

  String fullFIO() => "$lastName $firstName $patronymic";

}

class Family {
  final String kinship;
  final String fio;

  Family({
    required this.kinship,
    required this.fio
  });

  factory Family.fromJson(Map<String, dynamic> json) => Family(
    kinship: json['kinship'],
    fio: json['fio'],
  );

  Map<String, dynamic> toJson() => {
    "kinship": kinship,
    "fio": fio,
  };
}

class EducationInfo {
  final String faculty;
  final String form;
  final String typeForm;
  final String level;
  final String direction;
  final String group;
  final String course;
  final String status;
  final String profile;

  EducationInfo({
    required this.faculty,
    required this.form,
    required this.typeForm,
    required this.level,
    required this.direction,
    required this.group,
    required this.course,
    required this.status,
    required this.profile
  });

  factory EducationInfo.fromJson(Map<String, dynamic> json) => EducationInfo(
    faculty: json['faculty'],
    form: json['form'],
    typeForm: json['type_form'],
    level: json['level'],
    direction: json['direction'],
    group: json['group'],
    course: json['course'],
    status: json['status'],
    profile: json['profile'],
  );

  String get displayProfile => (profile.isEmpty) ? "-" : profile;

  Map<String, dynamic> toJson() => {
    "faculty": faculty,
    "form": form,
    "type_form": typeForm,
    "level": level,
    "direction": direction,
    "group": group,
    "course": course,
    "status": status,
    "profile": profile,
  };
}
