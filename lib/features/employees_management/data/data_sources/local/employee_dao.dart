import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class EmployeeDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEmployee(Employee employee);

  @delete
  Future<void> deleteEmployee(Employee employee);

  @Query('SELECT * FROM employees')
  Future<List<Employee>> getEmployees();

  @Query('SELECT * FROM employees WHERE name LIKE :query')
  Future<List<Employee>> getEmployeesByName(String query);

  @Query('Delete FROM employees')
  Future<void> deleteEmployees();
}
