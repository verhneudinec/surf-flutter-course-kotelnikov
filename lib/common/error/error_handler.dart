import 'package:mwwm/mwwm.dart';

class StandardErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    print('Handled error: $e');
  }
}
