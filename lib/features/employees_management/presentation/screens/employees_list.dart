import 'package:employees_management/features/employees_management/domain/models/employee_entity.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_bloc.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_event.dart';
import 'package:employees_management/features/employees_management/presentation/bloc/employee/employee_state.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/add_edit_employee_dialog_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/delete_employees_dialog_widget.dart';
import 'package:employees_management/features/employees_management/presentation/widgets/employee_list_widget.dart';
import 'package:employees_management/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({super.key});

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Employees List'),
        actions: [
          IconButton(
              onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
              icon: const Icon(Icons.search)),
          IconButton(onPressed: () => _onAddEmployeeViewPressed(context), icon: const Icon(Icons.add)),
          IconButton(onPressed: () => _onDeleteEmployeesViewPressed(context), icon: const Icon(Icons.delete_forever)),
          IconButton(onPressed: () => _onExportEmployeesViewPressed(), icon: const Icon(Icons.file_download)),
        ],
      ),
      body: const EmployeeListBloc());

  _onAddEmployeeViewPressed(BuildContext context) async {
    final result = await showDialog(context: context, builder: (BuildContext context) => const AddEditEmployeeDialog());
    if (result != null) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Employee successfully inserted!')));
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
    final result = await showDialog(context: context, builder: (BuildContext context) => const DeleteEmployeesDialog());
    if (result != null) {
      setState(() {
        if (result['done']) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Employees successfully deleted!')));
          BlocProvider.of<EmployeeBloc>(context).add(const DeleteEmployeesEvent());
        }
      });
    }
  }

  _onExportEmployeesViewPressed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Employees successfully exported!')));
    BlocProvider.of<EmployeeBloc>(context).add(const ExportEmployeesEvent());
  }
}

class EmployeeListBloc extends StatelessWidget {
  const EmployeeListBloc({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<EmployeeBloc, EmployeeState>(
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
              BlocProvider.of<EmployeeBloc>(context).add(const SearchEmployeeEvent());
              return Container();
            case ExportEmployeesSuccessState():
              Share.shareFiles([state.filePath!]);
              BlocProvider.of<EmployeeBloc>(context).add(const SearchEmployeeEvent());
              return Container();
            default:
              return Container();
          }
        },
      );
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  String? get searchFieldLabel => 'Search by employee name';

  @override
  Widget buildResults(BuildContext context) => BlocProvider(
        create: (_) => locator<EmployeeBloc>()..add(SearchEmployeeEvent(query: query)),
        child: const EmployeeListBloc(),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
