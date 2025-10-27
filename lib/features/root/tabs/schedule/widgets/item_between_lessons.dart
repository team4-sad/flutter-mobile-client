import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemBetweenLessons extends StatelessWidget {
  final Duration duration;

  const ItemBetweenLessons({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: BoxBorder.all(color: context.palette.container),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Перерыв", 
              style: TS.regular14.use(context.palette.calendar)
            ),
          ),
          Icon(I.schedule, color: context.palette.calendar),
          3.hs(),
          Text(
            "${duration.inMinutes} мин.", 
            style: TS.regular14.use(context.palette.calendar)
          ),
        ]
      ),
    );
  }
}
