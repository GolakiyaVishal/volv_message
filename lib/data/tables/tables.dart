import 'package:hive/hive.dart';

part 'tables.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  final bool isLogin;

  @HiveField(1)
  final String username;

  UserData({
    required this.isLogin,
    required this.username,
});
}


