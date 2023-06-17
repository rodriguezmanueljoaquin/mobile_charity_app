Map<V, int> listToIndexMapByKey<T, V>(List<T> list, V Function(T) valueGetter) {
  Map<V, int> map = {};
  for (int i = 0; i < list.length; i++) {
    map[valueGetter(list[i])] = i;
  }
  return map;
}
