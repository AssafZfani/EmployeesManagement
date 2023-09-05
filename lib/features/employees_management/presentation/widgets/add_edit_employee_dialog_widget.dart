import 'package:flutter/material.dart';

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
        title: Text('${widget.name.isEmpty ? 'Add' : 'Update'} Employee'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
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
            child: const Text('Save'),
          ),
        ],
      );
}
