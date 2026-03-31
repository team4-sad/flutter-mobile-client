import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/date_time_extensions.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/core/widgets/tag_widget.dart';
import 'package:miigaik/features/lk/features/documents/models/order_document_model.dart';
import 'package:miigaik/theme/app_theme_extensions.dart';
import 'package:miigaik/theme/text_styles.dart';

class OrderDocumentItem extends StatelessWidget {

  final OrderDocumentModel order;

  const OrderDocumentItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(14),
      decoration: BoxDecoration(
        color: context.palette.container,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: context.palette.tag,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Center(child: Text("№", style: TS.regular12.use(context.palette.unAccent))),
              ),
              10.hs(),
              Text(order.number, style: TS.medium14.use(context.palette.text))
            ],
          ),
          if (order.comment != null)
            Padding(
              padding: EdgeInsetsGeometry.only(top: 4),
              child: Text("*${order.comment}", style: TS.regular10.use(context.palette.text)),
            ),
          8.vs(),
          Text(order.name, style: TS.medium16.use(context.palette.text)),
          3.vs(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Изготовление: ",
                  style: TS.medium14.use(context.palette.text)
                ),
                TextSpan(
                  text: "от ${order.intervalModel.startDay} до ${order.intervalModel.endDay} рабочих дней",
                  style: TS.regular14.use(context.palette.text)
                ),
              ]
            ),
          ),
          3.vs(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "Заказано: ", style: TS.medium14.use(context.palette.text)),
                TextSpan(text: order.createdAt.ddMMyyyyHHmmSS, style: TS.regular14.use(context.palette.text)),
              ]
            ),
          ),
          16.vs(),
          TagWidget(title: order.status.display)
        ],
      ),
    );
  }
  
}