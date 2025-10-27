import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/generated/icons.g.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class ItemSchedule extends StatelessWidget {
  const ItemSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: context.palette.calendar,
                ),
                child: Center(
                  child: Text(
                    "2",
                    style: TS.regular14.use(context.palette.unAccent),
                  ),
                ),
              ),
              10.hs(),
              Expanded(
                child: Text(
                  "10:40-12:10",
                  style: TS.medium14.use(context.palette.calendar),
                ),
              ),
              10.hs(),
              GestureDetector(
                child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: context.palette.calendar,
                ),
                child: Center(
                  child: Icon(
                    I.map, 
                    color: context.palette.unAccent,
                    size: 18,
                  ) 
                ),
              ),
              )
            ],
          ),
          14.vs(),
          Text(
            "Технологии и методы программирования",
            style: TS.medium16.use(context.palette.text),
          ),
          22.vs(),
          Row(
            spacing: 4,
            children: ["Лазуренко Н.С.", "Семинар", "303к2"].map((e) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: context.palette.calendar,
              ),
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              child: Text(
                e,
                style: TS.regular14.use(context.palette.unAccent),
              ),
            )).toList()
          ),
        ],
      ),
    );
  }
}
