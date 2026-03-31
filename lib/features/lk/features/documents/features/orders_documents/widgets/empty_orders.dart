import 'package:flutter/material.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: PlaceholderWidget(
        title: "Нет заказов",
        subTitle: "Вы еще ничего не заказывали",
      ),
    );
  }
}