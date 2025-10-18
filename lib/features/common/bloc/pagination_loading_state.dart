import 'package:miigaik/features/common/bloc/with_pagination_state.dart';

abstract class PaginationLoadingState<T> extends WithPaginationState<T> {

  PaginationLoadingState({super.data, super.pagination});
}