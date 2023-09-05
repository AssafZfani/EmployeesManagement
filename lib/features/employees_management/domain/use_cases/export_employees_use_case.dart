import 'package:employees_management/core/use_case/use_case.dart';
import 'package:employees_management/features/employees_management/domain/repository/employee_repository.dart';

class ExportEmployeesUseCase implements UseCase<void, void> {
  final EmployeeRepository _employeeRepository;

  ExportEmployeesUseCase(this._employeeRepository);

  @override
  Future<String> call({void params}) {
    return _employeeRepository.exportEmployees();
  }
}
