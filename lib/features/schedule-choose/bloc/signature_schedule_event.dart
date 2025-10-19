part of 'signature_schedule_bloc.dart';

abstract class SignatureScheduleEvent {}

class FetchSignaturesEvent extends SignatureScheduleEvent {}

class SelectSignatureEvent extends SignatureScheduleEvent {
  final SignatureScheduleModel selectedSignature;

  SelectSignatureEvent({required this.selectedSignature});
}
