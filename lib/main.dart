import 'dart:io';

import 'package:employees_management/common_assets/fonts/common_fonts.dart';
import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_bloc.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_event.dart';
import 'package:employees_management/features/employees_management/presentation/screens/employees_list.dart';
import 'package:employees_management/locale/locales.dart';
import 'package:employees_management/locator.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init locator
  await setup();
  runApp(const EmployeesManagementApp());
}

class EmployeesManagementApp extends StatefulWidget {
  const EmployeesManagementApp({super.key});

  @override
  State<EmployeesManagementApp> createState() => _EmployeesManagementAppState();
}

class _EmployeesManagementAppState extends State<EmployeesManagementApp> {
  final faker = Faker.instance..setLocale(FakerLocaleType.he);

  @override
  void initState() {
    locator<FlutterLocalization>()
      ..init(
        mapLocales: [
          MapLocale('en', AppLocale.EN,
              fontFamily: Platform.isIOS
                  ? CommonFonts.sf_pro
                  : CommonFonts.roboto_flex),
          MapLocale('he', AppLocale.HE,
              fontFamily: Platform.isIOS
                  ? CommonFonts.sf_hebrew
                  : CommonFonts.noto_sans_hebrew),
        ],
        initLanguageCode: 'he',
      )
      ..onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppLocale.appTitle.getString(context),
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: locator<FlutterLocalization>().fontFamily,
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
        supportedLocales: locator<FlutterLocalization>().supportedLocales,
        localizationsDelegates:
            locator<FlutterLocalization>().localizationsDelegates,
      );

  // Fake information to fill the database
  EmployeeEvent buildInsertEvent() {
    final date =
        faker.date.between(DateTime.parse("1950-01-01"), DateTime.now());
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
