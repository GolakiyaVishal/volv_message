import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volv_message/notifiers/splash_notifier.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SplashNotifier>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }
}
