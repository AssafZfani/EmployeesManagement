import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/custom_text_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/employee_widget.dart';
import 'package:flutter/material.dart';

class EmployeesListWidget extends StatelessWidget {
  final List<Employee> employees;

  const EmployeesListWidget({super.key, required this.employees});

  @override
  Widget build(BuildContext context) => CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: Row(textDirection: TextDirection.rtl, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CustomText(text: "ID", shrink: true),
            CustomText(text: "Name"),
            CustomText(text: "Phone"),
            CustomText(text: "Position"),
            CustomText(text: "Start Date")
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => EmployeeWidget(employee: employees[index]),
            childCount: employees.length,
          ),
        )
      ]);
}
