import 'package:flutter/material.dart';
import 'package:miigaik/core/extensions/num_widget_extension.dart';
import 'package:miigaik/features/lk/features/documents/models/order_document_model.dart';

import 'order_document_item.dart';

class LoadedOrdersWidget extends StatelessWidget {

  final List<OrderDocumentModel> orders;

  const LoadedOrdersWidget({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsGeometry.only(bottom: 120),
      itemBuilder: (context, index) => OrderDocumentItem(
        order: orders[index],
      ),
      separatorBuilder: (context, index) => 20.vs(),
      itemCount: orders.length
    );
  }
}