import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  void unFocus() {
    FocusScope.of(this).unfocus();
  }
}
