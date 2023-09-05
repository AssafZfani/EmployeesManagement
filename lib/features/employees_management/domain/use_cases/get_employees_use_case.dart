import 'package:employees_management/core/resources/data_state.dart';
import 'package:employees_management/core/use_case/use_case.dart';
import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/domain/repository/employee_repository.dart';

class GetEmployeesUseCase implements UseCase<DataState<List<Employee>>, String?> {
  final EmployeeRepository _employeeRepository;

  GetEmployeesUseCase(this._employeeRepository);

  @override
  Future<DataState<List<Employee>>> call({String? params}) {
    return _employeeRepository.getEmployees(params);
  }
}
