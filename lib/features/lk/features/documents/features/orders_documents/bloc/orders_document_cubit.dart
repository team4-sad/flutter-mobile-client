import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/lk/features/documents/models/order_document_model.dart';
import 'package:miigaik/features/lk/features/documents/use_case/get_orders_documents_use_case.dart';

part 'orders_document_state.dart';

class OrdersDocumentCubit extends Cubit<OrdersDocumentState> {

  final getOrdersUseCase = GetOrdersDocumentsUseCase();

  OrdersDocumentCubit() : super(OrdersDocumentInitial());

  void fetchOrders() async {
    emit(OrdersDocumentLoading());
    try {
      final orders = await getOrdersUseCase();
      emit(OrdersDocumentLoaded(data: orders));
    } on Object catch(e){
      emit(OrdersDocumentError(error: e));
    }
  }
}
