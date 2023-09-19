class NotExistsException implements Exception {
  String item;
  NotExistsException(this.item);
}