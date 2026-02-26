import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/placeholder_widget.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

import 'item_schedule_signature.dart';

class ChooseScheduleWidget extends StatelessWidget {

  final List<SignatureScheduleModel> data;
  final SignatureScheduleModel? selected;

  final String emptyTitle;
  final String emptySubTitle;

  final void Function(SignatureScheduleModel) onChoose;
  final void Function(SignatureScheduleModel)? onDelete;

  const ChooseScheduleWidget({
    super.key, required this.data, this.selected, required this.emptyTitle,
    required this.emptySubTitle, required this.onChoose, this.onDelete
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
      return ListView.separated(
        itemBuilder: (_, index) {
          final signature = data[index];
          return ItemScheduleSignature(
            signatureModel: signature,
            onTap: onChoose,
            isSelected: selected == signature,
            onDelete: onDelete
          );
        },
        separatorBuilder: (_, __) => 10.vs(),
        padding: EdgeInsets.only(bottom: 10),
        itemCount: data.length,
      );
    }
  }

}