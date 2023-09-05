import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';

abstract class EmployeeEvent {
  final Employee? employee;
  final String? query;

  const EmployeeEvent({this.employee, this.query});
}

class SearchEmployeeEvent extends EmployeeEvent {
  const SearchEmployeeEvent({String? query}) : super(query: query);
}

class InsertEmployeeEvent extends EmployeeEvent {
  const InsertEmployeeEvent(Employee employee) : super(employee: employee);
}

class DeleteEmployeeEvent extends EmployeeEvent {
  const DeleteEmployeeEvent(Employee employee) : super(employee: employee);
}

class DeleteEmployeesEvent extends EmployeeEvent {
  const DeleteEmployeesEvent();
}

class ExportEmployeesEvent extends EmployeeEvent {
  const ExportEmployeesEvent();
}
