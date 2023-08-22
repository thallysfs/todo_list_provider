import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFactory? _instance;

  Database? _db;
  // * garante que só abre uma conexão por instância em métodos async
  final _lock = Lock();

  // construtor privado
  SqliteConnectionFactory._();

  // construtor tipo factory
  factory SqliteConnectionFactory() {
    // * controlando a classe para ser Singleton (uma só instância)
    if (_instance == null) {
      _instance = SqliteConnectionFactory._();
    }

    return _instance!;
  }

  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      // * garantir que só tenha um acesso a base de dados
      await _lock.synchronized(() async {
        _db ??= await openDatabase(databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade);
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = _db?.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();

    for (var migration in migrations) {
      migration.create(batch!);
    }

    batch!.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = _db?.batch();

    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.update(batch!);
    }

    batch!.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
