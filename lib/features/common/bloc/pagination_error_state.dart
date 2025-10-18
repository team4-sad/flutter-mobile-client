import 'package:miigaik/features/common/bloc/with_pagination_state.dart';

abstract class PaginationErrorState<T> extends WithPaginationState<T> {

  final Object error;

  PaginationErrorState({required this.error, super.data, super.pagination});

}