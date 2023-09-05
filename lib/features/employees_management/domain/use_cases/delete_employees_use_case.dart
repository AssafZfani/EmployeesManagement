import 'package:employees_management/core/use_case/use_case.dart';
import 'package:employees_management/features/employees_management/domain/repository/employee_repository.dart';

class DeleteEmployeesUseCase implements UseCase<void, void> {
  final EmployeeRepository _employeeRepository;

  DeleteEmployeesUseCase(this._employeeRepository);

  @override
  Future<void> call({void params}) {
    return _employeeRepository.deleteEmployees();
  }
}
