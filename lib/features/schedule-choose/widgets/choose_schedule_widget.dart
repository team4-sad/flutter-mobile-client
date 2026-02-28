import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/schedule-choose/bloc/selecting_schedule_choose_page_cubit/selecting_schedule_choose_page_cubit.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

import 'item_schedule_signature.dart';

class ChooseScheduleWidget extends StatelessWidget {

  final SelectingScheduleChoosePageCubit selectingCubit = GetIt.I.get();

  final List<SignatureScheduleModel> data;
  final SignatureScheduleModel? selected;

  final String emptyTitle;
  final String emptySubTitle;

  final bool enableMultipleSelect;

  final void Function(SignatureScheduleModel) onChoose;
  final void Function(SignatureScheduleModel)? onDelete;

  ChooseScheduleWidget({
    super.key, required this.data, this.selected, required this.emptyTitle,
    required this.emptySubTitle, required this.onChoose, this.onDelete,
    this.enableMultipleSelect = true
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: PlaceholderWidget(
          title: emptyTitle,
          subTitle: emptySubTitle,
        ),
      );
    } else {
      return BlocBuilder<SelectingScheduleChoosePageCubit, List<SignatureScheduleModel>?>(
        bloc: selectingCubit,
        builder: (context, state) {
          debugPrint(state.toString());
          return ListView.separated(
            itemBuilder: (_, index) {
              final signature = data[index];
              return ItemScheduleSignature(
                signatureModel: signature,
                onTap: (signature){
                  if (!selectingCubit.isSelectionMode){
                    onChoose(signature);
                  }else{
                    selectingCubit.onSelect(signature);
                  }
                },
                onLongTap: (signature){
                  if (enableMultipleSelect){
                    selectingCubit.onSelect(signature);
                  }
                },
                isSelected: selected == signature && !selectingCubit.isSelectionMode,
                isMultipleSelect: selectingCubit.state?.contains(signature) ?? false,
                onDelete: onDelete
              );
            },
            separatorBuilder: (_, __) => 10.vs(),
            padding: EdgeInsets.only(bottom: 10),
            itemCount: data.length,
          );
        },
      );
    }
  }

}