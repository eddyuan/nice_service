extension NSListExt<E> on List<E> {
  List<E> takeLast(int num) {
    if (length <= num || num < 0) {
      return this;
    }
    return sublist(length - num);
  }

  List<E> takeFirst(int num) {
    if (length <= num || num < 0) {
      return this;
    }
    return take(num).toList();
  }
}
