extension IterableX<T> on Iterable<T> {
  Stream<T> asStream() => Stream<T>.fromIterable(this);
}
