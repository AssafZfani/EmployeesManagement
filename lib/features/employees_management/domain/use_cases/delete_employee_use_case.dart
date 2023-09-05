import 'package:employees_management/core/use_case/use_case.dart';
import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/domain/repository/employee_repository.dart';

class DeleteEmployeeUseCase implements UseCase<void, Employee> {
  final EmployeeRepository _employeeRepository;

  DeleteEmployeeUseCase(this._employeeRepository);

  @override
  Future<void> call({Employee? params}) {
    return _employeeRepository.deleteEmployee(params!);
  }
}
