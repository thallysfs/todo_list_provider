import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

// * classe principal que controlará tudo
class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  // * aqui ficará a implementação do material

  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    // * método para adicionar no ciclo de vida quando a build terminar
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      initialRoute: '/login',
      theme: TodoListUiConfig.theme,
      routes: {...AuthModule().routes},
      home: SplashPage(),
    );
  }
}
