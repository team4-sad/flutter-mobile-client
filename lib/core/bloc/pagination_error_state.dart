import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/core/bloc/with_pagination_state.dart';

abstract class PaginationErrorState<T> extends WithPaginationState<T> implements WithErrorState {
  @override
  final Object error;

  PaginationErrorState({required this.error, super.data, super.pagination});
}