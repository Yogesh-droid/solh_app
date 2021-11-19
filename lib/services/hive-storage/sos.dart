import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SOSHiveModel extends HiveObject {
  @HiveField(0)
  String? person;

  @HiveField(1)
  int? phoneNo;

  @HiveField(2)
  String? message;
}
