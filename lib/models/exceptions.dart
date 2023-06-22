class FormException implements Exception {
  final String message;
  FormException(this.message);

  @override
  String toString() => message;
}