import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';

class SignatureScheduleModel {
  final SignatureScheduleType type;
  final String title;
  final String id;

  SignatureScheduleModel({
    required this.type,
    required this.title,
    required this.id
  });
}