import 'package:employees_management/core/resources/data_state.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/delete_employee_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/delete_employees_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/export_employees_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/get_employees_use_case.dart';
import 'package:employees_management/features/employees_management/domain/use_cases/insert_employee_use_case.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetEmployeesUseCase _getEmployeesUseCase;
  final InsertEmployeeUseCase _insertEmployeeUseCase;
  final DeleteEmployeeUseCase _deleteEmployeeUseCase;
  final DeleteEmployeesUseCase _deleteEmployeesUseCase;
  final ExportEmployeesUseCase _exportEmployeesUseCase;

  EmployeeBloc(
      this._getEmployeesUseCase,
      this._insertEmployeeUseCase,
      this._deleteEmployeeUseCase,
      this._deleteEmployeesUseCase,
      this._exportEmployeesUseCase)
      : super(const GetEmployeesLoadingState()) {
    on<SearchEmployeeEvent>(onGetEmployees);
    on<InsertEmployeeEvent>(onInsertEmployee);
    on<DeleteEmployeeEvent>(onDeleteEmployee);
    on<DeleteEmployeesEvent>(onDeleteEmployees);
    on<ExportEmployeesEvent>(onExportEmployees);
  }

  void onGetEmployees(
      SearchEmployeeEvent event, Emitter<EmployeeState> emit) async {
    emit(const GetEmployeesLoadingState());

    final dataState = await _getEmployeesUseCase(params: event.query);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(GetEmployeesSuccessState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(GetEmployeesFailState(dataState.error!));
    }
  }

  void onInsertEmployee(
      InsertEmployeeEvent event, Emitter<EmployeeState> emit) async {
    await _insertEmployeeUseCase(params: event.employee);
    emit(const InsertEmployeeSuccessState());
  }

  void onDeleteEmployee(
      DeleteEmployeeEvent event, Emitter<EmployeeState> emit) async {
    await _deleteEmployeeUseCase(params: event.employee);
    emit(const DeleteEmployeeSuccessState());
  }

  void onDeleteEmployees(
      DeleteEmployeesEvent event, Emitter<EmployeeState> emit) async {
    await _deleteEmployeesUseCase();
    emit(GetEmployeesSuccessState(List.empty()));
  }

  void onExportEmployees(
      ExportEmployeesEvent event, Emitter<EmployeeState> emit) async {
    final filePath = await _exportEmployeesUseCase();
    emit(ExportEmployeesSuccessState(filePath));
  }
}
