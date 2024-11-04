class CircularList<T> {
  final int maxSize;
  final List<T> _items = [];

  CircularList(this.maxSize);

  void add(T item) {
    if (_items.length == maxSize) {
      // Remove the first element to maintain the max size
      _items.removeAt(0);
    }
    _items.add(item);
  }

  addAll(List<T> items) {
    for (var item in items) {
      add(item);
    }
  }

  List<T> get items => List.unmodifiable(_items);

  int get length => _items.length;

  T operator [](int index) => _items[index];

  map(Function(dynamic message) param0) {
    return _items.map(param0);
  }
}