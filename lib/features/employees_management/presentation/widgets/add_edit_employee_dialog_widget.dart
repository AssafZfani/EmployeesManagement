import 'package:employees_management/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AddEditEmployeeDialog extends StatefulWidget {
  final String name;
  final String phone;
  final String position;
  final String startDate;

  const AddEditEmployeeDialog({
    super.key,
    this.name = '',
    this.phone = '',
    this.position = '',
    this.startDate = '',
  });

  @override
  State<AddEditEmployeeDialog> createState() => _AddEditEmployeeDialogState();
}

class _AddEditEmployeeDialogState extends State<AddEditEmployeeDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController positionController;
  late TextEditingController startDateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    positionController = TextEditingController(text: widget.position);
    startDateController = TextEditingController(text: widget.startDate);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    positionController.dispose();
    startDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
            '${widget.name.isEmpty ? AppLocale.add.getString(context) : AppLocale.update.getString(context)} ${AppLocale.employee.getString(context)}'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: AppLocale.name.getString(context)),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                    labelText: AppLocale.phone.getString(context)),
              ),
              TextFormField(
                controller: positionController,
                decoration: InputDecoration(
                    labelText: AppLocale.position.getString(context)),
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: startDateController,
                decoration: InputDecoration(
                    labelText: AppLocale.startDate.getString(context)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocale.cancel.getString(context)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop({
                'name': nameController.text,
                'phone': phoneController.text,
                'position': positionController.text,
                'startDate': startDateController.text,
              });
            },
            child: Text(AppLocale.save.getString(context)),
          ),
        ],
      );
}
