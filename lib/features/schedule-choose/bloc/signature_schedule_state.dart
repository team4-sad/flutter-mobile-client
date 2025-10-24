part of 'signature_schedule_bloc.dart';

sealed class SignatureScheduleState {}

final class SignatureScheduleInitial extends SignatureScheduleState {}

final class SignatureScheduleLoading extends SignatureScheduleState {}

final class SignatureScheduleError extends SignatureScheduleState {
  final Object error;

  SignatureScheduleError({required this.error});
}

final class SignatureScheduleLoaded extends WithAbsoluteDataState<SignatureScheduleModel> implements SignatureScheduleState{
  SignatureScheduleLoaded({
    required super.data,
    this.isNewSelection = false,
    this.selected,
  });

  final SignatureScheduleModel? selected;
  final bool isNewSelection;

  bool get hasSelected => selected != null;
}
