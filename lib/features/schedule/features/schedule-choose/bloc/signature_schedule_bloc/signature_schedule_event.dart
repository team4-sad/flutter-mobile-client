part of 'signature_schedule_bloc.dart';

abstract class SignatureScheduleEvent {}

class FetchSignaturesEvent extends SignatureScheduleEvent {}

class SelectSignatureEvent extends SignatureScheduleEvent {
  final SignatureScheduleModel selectedSignature;

  SelectSignatureEvent({required this.selectedSignature});
}

class AddSignatureEvent extends SignatureScheduleEvent {
  final SignatureScheduleModel newSignature;

  AddSignatureEvent({required this.newSignature});
}

class RemoveSignatureEvent extends SignatureScheduleEvent {
  final SignatureScheduleModel deleteSignature;

  RemoveSignatureEvent({required this.deleteSignature});
}

class ManyRemoveSignatureEvent extends SignatureScheduleEvent {
  final List<SignatureScheduleModel> deleteSignatures;

  ManyRemoveSignatureEvent({required this.deleteSignatures});
}
