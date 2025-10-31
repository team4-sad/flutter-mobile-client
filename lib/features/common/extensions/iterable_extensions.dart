extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndex<T>(T Function(E e, int index) toElement) {
    int index = 0;
    return map((e) {
      final res = toElement(e, index);
      index++;
      return res;
    });
  }

  Iterable<T> mapSepIndexed<T>(
    T Function(int index, E e) toElement,
    T Function(int index) toSep,
  ) {
    final iter = iterator;
    iter.moveNext();
    int realIndex = 0;
    return Iterable.generate(2 * length - 1, (i) {
      if (i % 2 != 1) {
        final newE = toElement(realIndex, iter.current);
        iter.moveNext();
        return newE;
      } else {
        final sep = toSep(realIndex);
        realIndex++;
        return sep;
      }
    });
  }

  Iterable<T> mapSep<T>(T Function(E e) toElement, T Function() toSep) {
    final iter = iterator;
    iter.moveNext();
    return Iterable.generate(2 * length - 1, (i) {
      if (i % 2 != 1) {
        final newE = toElement(iter.current);
        iter.moveNext();
        return newE;
      } else {
        return toSep();
      }
    });
  }
}
