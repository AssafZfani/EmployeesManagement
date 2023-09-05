import 'package:floor/floor.dart';

@Entity(tableName: 'employees', primaryKeys: ['id'])
class Employee {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String position;
  final String phone;
  final String startDate;

  const Employee({this.id, required this.name, required this.position, required this.phone, required this.startDate});
}
