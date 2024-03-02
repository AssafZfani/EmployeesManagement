import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_bloc.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_event.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_state.dart';
import 'package:employees_management/features/employees_management/presentation/screens/settings.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/add_edit_employee_dialog_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/delete_employees_dialog_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/employee_list_widget.dart';
import 'package:employees_management/locale/locales.dart';
import 'package:employees_management/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:share_plus/share_plus.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({super.key});

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(AppLocale.employeesList.getString(context)),
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: CustomSearchDelegate(context)),
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () => _onAddEmployeeViewPressed(context),
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () => _onDeleteEmployeesViewPressed(context),
              icon: const Icon(Icons.delete_forever)),
          IconButton(
              onPressed: () => _onExportEmployeesViewPressed(),
              icon: const Icon(Icons.file_download)),
          IconButton(
              onPressed: () => _onSettingsViewPressed(),
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: const EmployeeListBloc());

  _onAddEmployeeViewPressed(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const AddEditEmployeeDialog());
    if (result != null) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocale.employeeSuccessfullyInserted.getString(context))));
        BlocProvider.of<EmployeeBloc>(context).add(
          InsertEmployeeEvent(
            Employee(
                name: result['name'],
                phone: result['phone'],
                position: result['position'],
                startDate: result['startDate']),
          ),
        );
      });
    }
  }

  _onDeleteEmployeesViewPressed(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const DeleteEmployeesDialog());
    if (result != null) {
      setState(() {
        if (result['done']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  AppLocale.employeesSuccessfullyDeleted.getString(context))));
          BlocProvider.of<EmployeeBloc>(context)
              .add(const DeleteEmployeesEvent());
        }
      });
    }
  }

  _onExportEmployeesViewPressed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(AppLocale.employeesSuccessfullyExported.getString(context))));
    BlocProvider.of<EmployeeBloc>(context).add(const ExportEmployeesEvent());
  }

  _onSettingsViewPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }
}

class EmployeeListBloc extends StatelessWidget {
  const EmployeeListBloc({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (_, state) {
          switch (state) {
            case GetEmployeesLoadingState():
              return const Center(child: CupertinoActivityIndicator());
            case GetEmployeesFailState():
              return const Center(child: Icon(Icons.refresh));
            case GetEmployeesSuccessState():
              return EmployeesListWidget(employees: state.employees!);
            case InsertEmployeeSuccessState():
            case DeleteEmployeeSuccessState():
              BlocProvider.of<EmployeeBloc>(context)
                  .add(const SearchEmployeeEvent());
              return Container();
            case ExportEmployeesSuccessState():
              Share.shareFiles([state.filePath!]);
              BlocProvider.of<EmployeeBloc>(context)
                  .add(const SearchEmployeeEvent());
              return Container();
            default:
              return Container();
          }
        },
      );
}

class CustomSearchDelegate extends SearchDelegate<String> {
  late final BuildContext context;

  CustomSearchDelegate(this.context);

  @override
  String? get searchFieldLabel =>
      AppLocale.searchByEmployeeName.getString(context);

  @override
  Widget buildResults(BuildContext context) => BlocProvider(
        create: (_) =>
            locator<EmployeeBloc>()..add(SearchEmployeeEvent(query: query)),
        child: const EmployeeListBloc(),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
