import 'package:employees_management/core/resources/data_state.dart';
import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';

abstract class EmployeeRepository {
  Future<DataState<List<Employee>>> getEmployees(String? params);

  Future<void> insertEmployee(Employee employee);

  Future<void> deleteEmployee(Employee employee);

  Future<void> deleteEmployees();

  Future<String> exportEmployees();
}
