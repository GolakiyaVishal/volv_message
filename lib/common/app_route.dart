import 'package:volv_message/ui/screens/home_screen.dart';
import 'package:volv_message/ui/screens/login_screen.dart';
import 'package:volv_message/ui/screens/splash_screen.dart';

class AppRoute {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';

  static final routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    home : (context)=> const HomeScreen(),
  };
}