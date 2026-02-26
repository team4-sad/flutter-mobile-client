import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/schedule-choose/bloc/signature_schedule_bloc/signature_schedule_bloc.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/features/schedule-choose/widgets/item_schedule_signature.dart';

class LoadedAddScheduleContent extends StatelessWidget {
  final List<SignatureScheduleModel> data;

  const LoadedAddScheduleContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<SignatureScheduleBloc>();
    return ListView.separated(
      separatorBuilder: (context, index) {
        return 10.vs();
      },
      padding: EdgeInsets.only(bottom: 10),
      itemBuilder: (context, index) {
        return ItemScheduleSignature(
          signatureModel: data[index],
          onTap: (model) async {
            bloc.add(AddSignatureEvent(newSignature: model));
            Navigator.pop(context);
          },
        );
      },
      itemCount: data.length,
    );
  }
}
