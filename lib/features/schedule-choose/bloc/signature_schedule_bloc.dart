import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/features/common/bloc/with_data_state.dart';
import 'package:miigaik/features/schedule-choose/enum/signature_schedule_type.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

part 'signature_schedule_event.dart';
part 'signature_schedule_state.dart';

class SignatureScheduleBloc extends Bloc<SignatureScheduleEvent, SignatureScheduleState> {
  SignatureScheduleBloc() : super(SignatureScheduleInitial()) {
    on<FetchSignaturesEvent>((event, emit) async {
      if (state is SignatureScheduleLoading || state is SignatureScheduleLoaded){
        return;
      }
      emit(SignatureScheduleLoading());
      final result = await Future.delayed(Duration(milliseconds: 500), () => [
        SignatureScheduleModel(type: SignatureScheduleType.group, title: '2023-ФГиИБ-ИСиТибикс-1м', id: '0'),
        SignatureScheduleModel(type: SignatureScheduleType.audience, title: '450 | Главный корпус | 4 этаж', id: '1'),
        SignatureScheduleModel(type: SignatureScheduleType.audience, title: '303 к.2 | 2-ой корпус | 3 этаж', id: "2"),
        SignatureScheduleModel(type: SignatureScheduleType.teacher, title: 'Литвинцева Екатерина Константиновна', id: "3"),
      ]);
      emit(SignatureScheduleLoaded(data: result, selected: result[0]));
    }, transformer: droppable());

    on<SelectSignatureEvent>((event, emit) {
      if (state is! SignatureScheduleLoaded){
        return;
      }
      final s = state as SignatureScheduleLoaded;
      emit(SignatureScheduleLoaded(data: s.data, selected: event.selectedSignature));
    });
  }
}
