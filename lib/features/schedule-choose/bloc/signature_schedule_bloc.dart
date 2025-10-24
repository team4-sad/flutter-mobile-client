import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/bloc/with_data_state.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/repository/signature_schedule_repository.dart';

part 'signature_schedule_event.dart';
part 'signature_schedule_state.dart';

class SignatureScheduleBloc extends Bloc<SignatureScheduleEvent, SignatureScheduleState> {

  final SignatureScheduleRepository _repository = GetIt.I.get();

  SignatureScheduleBloc() : super(SignatureScheduleInitial()) {
    on<FetchSignaturesEvent>((event, emit) async {
      if (state is SignatureScheduleLoading || state is SignatureScheduleLoaded){
        return;
      }
      emit(SignatureScheduleLoading());
      try {
        final result = await _repository.fetchAll();
        final selected = await _repository.getSelected();
        emit(SignatureScheduleLoaded(data: result, selected: selected));
      } on Object catch(e){
        emit(SignatureScheduleError(error: e));
      }
    }, transformer: droppable());

    on<SelectSignatureEvent>((event, emit) async {
      if (state is! SignatureScheduleLoaded){
        return;
      }
      final s = state as SignatureScheduleLoaded;
      try{
        await _repository.select(event.selectedSignature);
        emit(SignatureScheduleLoaded(
          data: s.data, 
          selected: event.selectedSignature,
          isNewSelection: true
        ));
      } on Object catch(e){
        emit(SignatureScheduleError(error: e));
      }
    }, transformer: droppable());

    on<AddSignatureEvent>((event, emit) async {
      try {
        await _repository.add(event.newSignature);
        if (state is SignatureScheduleLoaded){
          final s = state as SignatureScheduleLoaded;
          emit(SignatureScheduleLoaded(
            data: s.data..add(event.newSignature),
            selected: s.selected
          ));
        }else{
          add(FetchSignaturesEvent());
        }
      } on Object catch(e){
        emit(SignatureScheduleError(error: e));
      }
    }, transformer: sequential());

    on<RemoveSignatureEvent>((event, emit) async {
      try {
        await _repository.remove(event.deleteSignature);
        if (state is SignatureScheduleLoaded){
          final s = state as SignatureScheduleLoaded;
          if (s.hasSelected && event.deleteSignature == s.selected){
            await _repository.unSelect();
            emit(SignatureScheduleLoaded(
              data: s.data..remove(event.deleteSignature),
            ));
          }else{
            emit(SignatureScheduleLoaded(
              data: s.data..remove(event.deleteSignature),
              selected: s.selected
            ));
          }
        }else{
          add(FetchSignaturesEvent());
        }
      } on Object catch(e){
        emit(SignatureScheduleError(error: e));
      }
    }, transformer: sequential());
  }
}
