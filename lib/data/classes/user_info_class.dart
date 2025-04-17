import 'package:hive/hive.dart';

part 'user_info_class.g.dart';

@HiveType(typeId: 2)
// ignore: camel_case_types
class UserInfo {
  @HiveField(0)
  int budget;

  UserInfo({
    required this.budget,
  });
}