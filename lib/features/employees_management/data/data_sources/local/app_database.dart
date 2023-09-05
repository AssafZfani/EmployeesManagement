import 'dart:async';

import 'package:employees_management/features/employees_management/data/data_sources/local/employee_dao.dart';
import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
}
