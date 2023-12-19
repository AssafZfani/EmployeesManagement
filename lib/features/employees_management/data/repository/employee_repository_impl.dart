import 'dart:io';

import 'package:employees_management/core/resources/data_state.dart';
import 'package:employees_management/features/employees_management/data/data_sources/local/employee_dao.dart';
import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/domain/repository/employee_repository.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDao _employeeDao;

  EmployeeRepositoryImpl(this._employeeDao);

  @override
  Future<DataState<List<Employee>>> getEmployees(String? params) async {
    try {
      List<Employee> employeeList = params == null
          ? await _employeeDao.getEmployees()
          : await _employeeDao.getEmployeesByName('%$params%');
      return DataSuccess(employeeList);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<void> insertEmployee(Employee employee) =>
      _employeeDao.insertEmployee(employee);

  @override
  Future<void> deleteEmployee(Employee employee) =>
      _employeeDao.deleteEmployee(employee);

  @override
  Future<void> deleteEmployees() => _employeeDao.deleteEmployees();

  @override
  Future<String> exportEmployees() async {
    List<Employee> employeeList = await _employeeDao.getEmployees();

    // Create an Excel workbook
    final excel = Excel.createExcel();

    // Create a worksheet
    final sheet = excel['Sheet1'];

    // Add headers
    sheet
      ..cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 0)).value =
          'ID'
      ..cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 1)).value =
          'Name'
      ..cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 2)).value =
          'Phone'
      ..cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 3)).value =
          'Position'
      ..cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 4)).value =
          'StartDate';

    // Populate data
    for (var i = 0; i < employeeList.length; i++) {
      sheet
        ..cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 0))
            .value = employeeList[i].id
        ..cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 1))
            .value = employeeList[i].name
        ..cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 2))
            .value = employeeList[i].phone
        ..cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 3))
            .value = employeeList[i].position
        ..cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 4))
            .value = employeeList[i].startDate;
    }

    // Save the workbook to a file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/employees.xlsx';
    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    return filePath;
  }
}
