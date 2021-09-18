import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:volv_message/common/app_route.dart';
import 'package:volv_message/data/data_cources/local_data_source.dart';
import 'package:volv_message/utils/snack_bar_view.dart';

class SplashNotifier extends ChangeNotifier {
  final LocalDataSource localDataSource;

  SplashNotifier(this.localDataSource);

  void init(BuildContext context) {
    localDataSource.getUserData().then((value) {
      if (value == null) {
        Navigator.of(context).popAndPushNamed(AppRoute.login);
      } else {
        if (value.isLogin) {
          Navigator.of(context).popAndPushNamed(AppRoute.home);
        } else {
          showSnackBar('Something want wrong, please try again');
        }
      }
    });
  }
}
