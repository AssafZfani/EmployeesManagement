import 'package:employees_management/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class DeleteEmployeesDialog extends StatelessWidget {
  const DeleteEmployeesDialog({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
      title: Text(AppLocale.deleteAllEmployees.getString(context)),
          actions: [
            TextButton(
              child: Text(AppLocale.no.getString(context)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocale.yes.getString(context)),
              onPressed: () {
                Navigator.of(context).pop({'done': true});
              },
            ),
          ]);
}
