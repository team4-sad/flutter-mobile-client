import 'package:miigaik/core/bloc/with_data_state.dart';
import 'package:miigaik/features/news/models/news_pagination_model.dart';

abstract class WithPaginationState<T> extends WithDataState<T> {

  final PaginationModel? pagination;

  WithPaginationState({required super.data, this.pagination});

  @override
  bool get hasInvalid => super.hasInvalid || pagination == null;

  int? get nextPage => (pagination != null)
      ? (pagination!.hasNext)
      ? pagination!.currentPage + 1
      : null
      : 1;
}