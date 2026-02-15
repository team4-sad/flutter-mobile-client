import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:miigaik/features/root/tabs/schedule/models/teacher_model.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';

part 'signature_schedule_model.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class SignatureScheduleModel extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final SignatureScheduleType type;

  @HiveField(1)
  final String title;

  @HiveField(3)
  final String id;

  SignatureScheduleModel({
    required this.type,
    required this.title,
    required this.id,
  });

  SignatureScheduleModel copy() =>
      SignatureScheduleModel(type: type, title: title, id: id);

  @override
  List<Object?> get props => [type, title, id];

  Map<String, Object> toMap() => {
    "title": title,
    "type": type.display,
    "id": id
  };

  factory SignatureScheduleModel.fromAudienceMap(Map<String, dynamic> map) =>
      SignatureScheduleModel( 
        type: SignatureScheduleType.audience, 
        title: map["classroom_name"].toString(), 
        id: map["classroom_id"].toString()
      );
  
  factory SignatureScheduleModel.fromTeacherMap(Map<String, dynamic> map) =>
      SignatureScheduleModel( 
        type: SignatureScheduleType.teacher, 
        id: map["id"].toString(),
        title: TeacherModel.fromMap(map["teacher"]).fio, 
      );

  factory SignatureScheduleModel.fromGroupMap(Map<String, dynamic> map) =>
      SignatureScheduleModel( 
        type: SignatureScheduleType.group, 
        id: map["id"].toString(),
        title: map["group_name"].toString(), 
      );

  factory SignatureScheduleModel.fromMap(Map<String, dynamic> map) =>
      SignatureScheduleModel(
          type: SignatureScheduleType.fromDisplay(map["type"] as String),
          title: map["title"] as String,
          id: map["id"]
      );
}
