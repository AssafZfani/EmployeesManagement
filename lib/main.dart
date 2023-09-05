import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_bloc.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_event.dart';
import 'package:employees_management/features/employees_management/presentation/screens/employees_list.dart';
import 'package:employees_management/locator.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init locator
  await setup();
  runApp(EmployeesManagementApp());
}

class EmployeesManagementApp extends StatelessWidget {
  final faker = Faker.instance..setLocale(FakerLocaleType.he);

  EmployeesManagementApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employees Management',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (_) => locator<EmployeeBloc>()
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(buildInsertEvent())
            ..add(const SearchEmployeeEvent()),
          child: const EmployeesList(),
        ),
      );

  // Fake information to fill the database
  EmployeeEvent buildInsertEvent() {
    final date = faker.date.between(DateTime.parse("1950-01-01"), DateTime.now());
    return InsertEmployeeEvent(
      Employee(
        name: "${faker.name.firstName()} ${faker.name.lastName()}",
        position: faker.name.jobTitle(),
        phone: faker.phoneNumber.phoneNumber(format: "05########"),
        startDate: "${date.day}/${date.month}/${date.year}",
      ),
    );
  }
}
