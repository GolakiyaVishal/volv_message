import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:volv_message/notifiers/medicine_notifier.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:volv_message/notifiers/splash_notifier.dart';

import 'data/data_cources/local_data_source.dart';
import 'data/tables/tables.dart';
import 'notifiers/home_notifier.dart';
import 'notifiers/login_notifier.dart';
import 'ui/volv_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserDataAdapter());
  LocalDataSource localDataSource = LocalDataSourceImpl();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => LoginNotifier(localDataSource)),
      ChangeNotifierProvider(create: (_) => HomeNotifier(localDataSource)),
      ChangeNotifierProvider(create: (_) => SplashNotifier(localDataSource)),
      ChangeNotifierProvider(
        create: (context) => MedicineNotifier(),
      ),
    ],
    child: const VolvApp(),
  ));
}
