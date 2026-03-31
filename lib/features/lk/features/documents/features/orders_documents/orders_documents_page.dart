import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/core/features/bottom-nav-bar/bottom_nav_bar_gradient.dart';
import 'package:miigaik/core/widgets/placeholder_widget.dart';
import 'package:miigaik/core/widgets/simple_app_bar.dart';
import 'package:miigaik/features/lk/features/documents/features/orders_documents/bloc/orders_document_cubit.dart';
import 'package:miigaik/features/lk/features/documents/features/orders_documents/widgets/empty_orders.dart';
import 'package:miigaik/features/lk/features/documents/features/orders_documents/widgets/loaded_orders_widget.dart';
import 'package:miigaik/features/lk/features/documents/features/orders_documents/widgets/loading_orders_widget.dart';
import 'package:miigaik/theme/text_styles.dart';
import 'package:miigaik/theme/values.dart';

class OrdersDocumentsPage extends StatelessWidget {
  const OrdersDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = GetIt.I.get<OrdersDocumentCubit>();
    cubit.fetchOrders();

    return Scaffold(
      appBar: SimpleAppBar(
        title: "Заказанные документы",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: Stack(
          children: [
            BlocBuilder<OrdersDocumentCubit, OrdersDocumentState>(
              bloc: cubit,
              builder: (context, state) {
                return switch(state) {
                  OrdersDocumentInitial() => LoadingOrdersWidget(),
                  OrdersDocumentLoading() => LoadingOrdersWidget(),
                  OrdersDocumentError(error: var err) => Center(
                    child: PlaceholderWidget.fromException(err)
                  ),
                  OrdersDocumentLoaded(data: var orders) => (orders.isEmpty)
                    ? EmptyOrders()
                    : LoadedOrdersWidget(orders: orders)
                };
              }
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavBarGradient(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    height: 46.h,
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: (){

                      },
                      child: Text("Заказать документ", style: TS.medium15,)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}