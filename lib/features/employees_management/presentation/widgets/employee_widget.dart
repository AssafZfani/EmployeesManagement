import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_bloc.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_event.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/add_edit_employee_dialog_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeWidget extends StatelessWidget {
  final Employee employee;

  const EmployeeWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) => Dismissible(
        key: Key(employee.name.toString()),
        onDismissed: (direction) {
          _onEmployeeDismissed(context, employee);
        },
        child: GestureDetector(
          onTap: () {
            _onEmployeeSelected(context, employee);
          },
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(text: employee.id.toString(), shrink: true),
              CustomText(text: employee.name),
              CustomText(text: employee.phone),
              CustomText(text: employee.position),
              CustomText(text: employee.startDate)
            ],
          ),
        ),
      );

  _onEmployeeSelected(BuildContext context, Employee employee) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AddEditEmployeeDialog(
            name: employee.name,
            phone: employee.phone,
            position: employee.position,
            startDate: employee.startDate)).then((result) => {
          if (result != null)
            {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Employee successfully edited!'))),
              BlocProvider.of<EmployeeBloc>(context).add(
                InsertEmployeeEvent(
                  Employee(
                      id: employee.id,
                      name: result['name'],
                      phone: result['phone'],
                      position: result['position'],
                      startDate: result['startDate']),
                ),
              )
            }
        });
  }

  _onEmployeeDismissed(BuildContext context, Employee employee) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee successfully deleted!')));
    BlocProvider.of<EmployeeBloc>(context).add(DeleteEmployeeEvent(employee));
  }
}
