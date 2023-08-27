// * Todos os controllers herdarão essa classe
import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  bool _success = false;

  // Encapsulando os atributos e colocando-os para retornar nos métodos abaixo
  bool get loading => _loading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isSuccess => _success;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _success = true;
  void setError(String? error) => _error = error;
  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _success = false;
  }
}
