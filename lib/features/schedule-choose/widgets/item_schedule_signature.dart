import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/delete_dismissible.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemScheduleSignature extends StatelessWidget {

  final SignatureScheduleModel signatureModel;
  final void Function(SignatureScheduleModel) onTap;
  final void Function(SignatureScheduleModel)? onLongTap;
  final void Function(SignatureScheduleModel)? onDelete;
  final bool isSelected;
  final bool isMultipleSelect;

  const ItemScheduleSignature({
    super.key,
    required this.signatureModel,
    required this.onTap,
    this.onDelete,
    this.onLongTap,
    this.isSelected = false,
    this.isMultipleSelect = false
  });

  Widget buildContent(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.palette.container,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: context.palette.accent.withAlpha(16),
          onTap: (){
            onTap(signatureModel);
          },
          onLongPress: (){
            if (onLongTap != null) {
              onLongTap!(signatureModel);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(signatureModel.type.display, style: TS.regular12.use(context.palette.subText)),
                3.vs(),
                Text(signatureModel.title, style: TS.medium15.use(context.palette.text))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: (isMultipleSelect)
                ? context.palette.text
                : (isSelected)
                  ? context.palette.accent
                  : Colors.transparent,
            width: 2
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: (onDelete != null)
            ? DeleteDismissible(
              key: ValueKey<int>(signatureModel.hashCode),
              onDelete: () {
                onDelete!(signatureModel);
              },
              child: buildContent(context),
            )
            : buildContent(context),
        )
      ),
    );
  }
}