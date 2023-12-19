import 'package:flutter/material.dart';

class DeleteEmployeesDialog extends StatelessWidget {
  const DeleteEmployeesDialog({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text(
              'Are you sure you want to delete all of the employees?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop({'done': true});
              },
            ),
          ]);
}
