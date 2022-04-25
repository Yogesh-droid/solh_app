import '../utility.dart';

class ErrorHandler {
  static void handleException(String exception) {
    print(exception.toString());
    Utility.showToast(exception);
  }
}
