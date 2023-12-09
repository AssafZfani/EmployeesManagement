import 'package:employees_management/features/employees_management/data/data_sources/local/app_database.dart';
import 'package:employees_management/features/employees_management/data/data_sources/local/employee_dao.dart';
import 'package:employees_management/features/employees_management/data/repository/employee_repository_impl.dart';
import 'package:employees_management/features/employees_management/domain/repository/employee_repository.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/delete_employee_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/delete_employees_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/export_employees_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/get_employees_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/insert_employee_use_case.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  // Localization
  locator.registerSingleton<FlutterLocalization>(FlutterLocalization.instance);

  // Database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<EmployeeDao>(database.employeeDao);

  // Repositories
  locator
      .registerSingleton<EmployeeRepository>(EmployeeRepositoryImpl(locator()));

  // Use Cases
  locator
      .registerSingleton<GetEmployeesUseCase>(GetEmployeesUseCase(locator()));

  locator.registerSingleton<InsertEmployeeUseCase>(
      InsertEmployeeUseCase(locator()));

  locator.registerSingleton<DeleteEmployeeUseCase>(
      DeleteEmployeeUseCase(locator()));

  locator.registerSingleton<DeleteEmployeesUseCase>(
      DeleteEmployeesUseCase(locator()));

  locator.registerSingleton<ExportEmployeesUseCase>(
      ExportEmployeesUseCase(locator()));

  // Blocs
  locator.registerFactory<EmployeeBloc>(() =>
      EmployeeBloc(locator(), locator(), locator(), locator(), locator()));
}
