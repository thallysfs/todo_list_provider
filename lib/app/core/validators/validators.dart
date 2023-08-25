import 'package:flutter/widgets.dart';

class Validators {
  // contrutor privado para impedir que a classe seja instanciada
  Validators._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != valueCompare)) {
        return message;
      }
    };
  }
}
