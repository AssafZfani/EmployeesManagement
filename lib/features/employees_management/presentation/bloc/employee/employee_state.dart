import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';

abstract class EmployeeState {
  final List<Employee>? employees;
  final String? error;
  final String? filePath;

  const EmployeeState({this.employees, this.error, this.filePath});
}

class GetEmployeesLoadingState extends EmployeeState {
  const GetEmployeesLoadingState();
}

class GetEmployeesSuccessState extends EmployeeState {
  const GetEmployeesSuccessState(List<Employee> employees)
      : super(employees: employees);
}

class GetEmployeesFailState extends EmployeeState {
  const GetEmployeesFailState(String error) : super(error: error);
}

class InsertEmployeeSuccessState extends EmployeeState {
  const InsertEmployeeSuccessState();
}

class DeleteEmployeeSuccessState extends EmployeeState {
  const DeleteEmployeeSuccessState();
}

class ExportEmployeesSuccessState extends EmployeeState {
  const ExportEmployeesSuccessState(String filePath)
      : super(filePath: filePath);
}
