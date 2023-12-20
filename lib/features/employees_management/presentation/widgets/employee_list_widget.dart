import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/custom_text_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/employee_widget.dart';
import 'package:employees_management/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class EmployeesListWidget extends StatelessWidget {
  final List<Employee> employees;

  const EmployeesListWidget({super.key, required this.employees});

  @override
  Widget build(BuildContext context) => CustomScrollView(slivers: [
    SliverToBoxAdapter(
          child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(text: AppLocale.id.getString(context), shrink: true),
                CustomText(text: AppLocale.name.getString(context)),
                CustomText(text: AppLocale.phone.getString(context)),
                CustomText(text: AppLocale.position.getString(context)),
                CustomText(text: AppLocale.startDate.getString(context))
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
