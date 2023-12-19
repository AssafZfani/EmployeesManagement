// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmployeeDao? _employeeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `employees` (`id` INTEGER, `name` TEXT NOT NULL, `position` TEXT NOT NULL, `phone` TEXT NOT NULL, `startDate` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmployeeDao get employeeDao {
    return _employeeDaoInstance ??= _$EmployeeDao(database, changeListener);
  }
}

class _$EmployeeDao extends EmployeeDao {
  _$EmployeeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _employeeInsertionAdapter = InsertionAdapter(
            database,
            'employees',
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'position': item.position,
                  'phone': item.phone,
                  'startDate': item.startDate
                }),
        _employeeDeletionAdapter = DeletionAdapter(
            database,
            'employees',
            ['id'],
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'position': item.position,
                  'phone': item.phone,
                  'startDate': item.startDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Employee> _employeeInsertionAdapter;

  final DeletionAdapter<Employee> _employeeDeletionAdapter;

  @override
  Future<List<Employee>> getEmployees() async {
    return _queryAdapter.queryList('SELECT * FROM employees',
        mapper: (Map<String, Object?> row) => Employee(
            id: row['id'] as int?,
            name: row['name'] as String,
            position: row['position'] as String,
            phone: row['phone'] as String,
            startDate: row['startDate'] as String));
  }

  @override
  Future<List<Employee>> getEmployeesByName(String query) async {
    return _queryAdapter.queryList('SELECT * FROM employees WHERE name LIKE ?1',
        mapper: (Map<String, Object?> row) => Employee(
            id: row['id'] as int?,
            name: row['name'] as String,
            position: row['position'] as String,
            phone: row['phone'] as String,
            startDate: row['startDate'] as String),
        arguments: [query]);
  }

  @override
  Future<void> deleteEmployees() async {
    await _queryAdapter.queryNoReturn('Delete FROM employees');
  }

  @override
  Future<void> insertEmployee(Employee employee) async {
    await _employeeInsertionAdapter.insert(
        employee, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEmployee(Employee employee) async {
    await _employeeDeletionAdapter.delete(employee);
  }
}
