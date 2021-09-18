import 'package:flutter/material.dart';
import 'package:volv_message/common/app_route.dart';

class VolvApp extends StatelessWidget{
  const VolvApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volv MVVM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoute.splash,
      routes: AppRoute.routes,
    );
  }
}