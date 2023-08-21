// ignore: depend_on_referenced_packages
import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migrations.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table teste2(
        id Integer
      )
    ''');
  }

  @override
  void update(Batch batch) {
    batch.execute('''
      create table teste2(
        id Integer
      )
    ''');
  }
}
