import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:volv_message/data/tables/tables.dart';

import 'mocks.mocks.dart';


void main() {
  group('Store user data in hive', () {
    late UserData userData;

    setUp(() {
      userData = UserData(isLogin: true, username: 'vishal');
    });

    test('.write()', () {
      final BinaryWriter binaryWriter = MockBinaryWriter();

      UserDataAdapter().write(binaryWriter, userData);
      verify(binaryWriter.write(true, writeTypeId: true));
      verify(binaryWriter.write('vishal', writeTypeId: true));
    });
  });
}