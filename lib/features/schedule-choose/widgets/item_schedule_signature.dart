import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/extensions/widget_extension.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemScheduleSignature extends StatelessWidget {

  final SignatureScheduleModel signatureModel;
  final void Function(SignatureScheduleModel) onTap;
  final void Function(SignatureScheduleModel) onLongTap;
  final bool isSelected;

  const ItemScheduleSignature({
    super.key,
    required this.signatureModel,
    required this.onTap,
    required this.onLongTap,
    this.isSelected = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap(signatureModel);
      },
      onLongPress: (){
        onLongTap(signatureModel);
      },
      child: Container(
        padding: 14.all(),
        decoration: BoxDecoration(
          color: context.palette.container,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: (isSelected) ? context.palette.accent : Colors.transparent, width: 2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(signatureModel.type.display, style: TS.regular12.use(context.palette.subText)),
            3.vs(),
            Text(signatureModel.title, style: TS.medium15.use(context.palette.text))
          ],
        ),
      ).p(2.all()),
    );
  }
}