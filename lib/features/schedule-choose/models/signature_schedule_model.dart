import 'package:hive/hive.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';

part 'signature_schedule_model.g.dart';

@HiveType(typeId: 0)
class SignatureScheduleModel extends HiveObject {
  @HiveField(0)
  final SignatureScheduleType type;

  @HiveField(1)
  final String title;

  @HiveField(3)
  final String id;

  SignatureScheduleModel({
    required this.type,
    required this.title,
    required this.id
  });

  SignatureScheduleModel copy() => SignatureScheduleModel(
      type: type, title: title, id: id
  );
}