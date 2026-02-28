import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/widgets/choose_schedule_widget.dart';

class LoadedScheduleChooseContent extends StatelessWidget {

  final List<SignatureScheduleModel> data;
  final SignatureScheduleModel? selected;

  LoadedScheduleChooseContent({super.key, required this.data, required this.selected});

  final SignatureScheduleBloc bloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return ChooseScheduleWidget(
      data: data,
      emptyTitle: "Расписаний нет",
      emptySubTitle: "Добавьте новое расписание",
      onChoose: (signature){
        bloc.add(
          SelectSignatureEvent(selectedSignature: signature),
        );
      },
      onDelete: (signature){
        bloc.add(
          RemoveSignatureEvent(deleteSignature: signature),
        );
      },
      selected: selected,
    );
  }
}