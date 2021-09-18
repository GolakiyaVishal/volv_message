import 'package:hive/hive.dart';

import '../tables/tables.dart';

abstract class LocalDataSource {
  Future<void> saveUserData(UserData userData);
  Future<UserData?> getUserData();
  Future<void> clearData();
}

class LocalDataSourceImpl extends LocalDataSource {
  final _boxKey = 'userdata';

  @override
  Future<UserData?> getUserData() async {
    final userBox = await Hive.openBox(_boxKey);
    return userBox.get('data1');
  }

  @override
  Future<void> saveUserData(UserData userData) async {
    final userBox = await Hive.openBox(_boxKey);
    userBox.put('data1', userData);
  }

  @override
  Future<void> clearData() async {
    final userBox = await Hive.openBox(_boxKey);
    userBox.clear();
  }


}