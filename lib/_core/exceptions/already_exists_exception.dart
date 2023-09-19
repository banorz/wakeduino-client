class AlreadyExistsException implements Exception {
  String item;
  AlreadyExistsException(this.item);
}