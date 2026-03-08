abstract class WithDataState<T> {
  final List<T>? data;

  WithDataState({required this.data});

  bool get hasNotEmptyData => data != null && data!.isNotEmpty;
  bool get hasEmptyData => data != null && data!.isEmpty;
  bool get hasInvalid => data == null;
}

abstract class WithAbsoluteDataState<T> {
  final List<T> data;

  WithAbsoluteDataState({required this.data});

  bool get hasEmptyData => data.isEmpty;
}