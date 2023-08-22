import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  // * o formatdo abaixo é uma atribuição de atributro privado, pois nos parâmetros do construtor
  // * não é permitido atributo com underline
  TodoListModule({
    required final Map<String, WidgetBuilder> routers,
    final List<SingleChildWidget>? bindings,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routes {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }
}
