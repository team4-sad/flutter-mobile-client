part of 'orders_document_cubit.dart';

sealed class OrdersDocumentState {}
final class OrdersDocumentInitial extends OrdersDocumentState {}
final class OrdersDocumentLoading extends OrdersDocumentState {}
final class OrdersDocumentError extends WithErrorState implements OrdersDocumentState {
  OrdersDocumentError({required super.error});
}
final class OrdersDocumentLoaded extends WithAbsoluteDataState<OrderDocumentModel> implements OrdersDocumentState {
  OrdersDocumentLoaded({required super.data});
}

