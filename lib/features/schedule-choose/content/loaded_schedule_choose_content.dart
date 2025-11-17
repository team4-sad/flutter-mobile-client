import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/widgets/item_schedule_signature.dart';

class LoadedScheduleChooseContent extends StatelessWidget {

  final List<SignatureScheduleModel> data;
  final SignatureScheduleModel? selected;

  LoadedScheduleChooseContent({super.key, required this.data, required this.selected});

  final SignatureScheduleBloc bloc = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: PlaceholderWidget(
          title: "Расписаний нет",
          subTitle: "Добавьте новое расписание",
        ),
      );
    } else {
      return ListView.separated(
        itemBuilder: (_, index) {
          final signature = data[index];
          return ItemScheduleSignature(
            signatureModel: signature,
            onTap: (signature) {
              bloc.add(
                SelectSignatureEvent(selectedSignature: signature),
              );
            },
            onLongTap: (signature) {
              bloc.add(
                RemoveSignatureEvent(deleteSignature: signature),
              );
            },
            isSelected: selected == signature,
          );
        },
        separatorBuilder: (_, __) => 10.vs(),
        itemCount: data.length,
      );
    }
  }
}