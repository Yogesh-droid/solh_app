class Exceptions implements Exception {
  final String error;
  final int statusCode;
  Exceptions({required this.error, required this.statusCode});

  int getStatus() {
    return statusCode;
  }
}
