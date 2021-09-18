import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:volv_message/data/data_cources/local_data_source.dart';
import 'package:volv_message/notifiers/login_notifier.dart';

Future<void> prepareWidget(WidgetTester tester, Widget widget) async {

  await tester.pumpWidget(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginNotifier>(
          create: (_) => LoginNotifier(LocalDataSourceImpl())),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ),
  ));
}