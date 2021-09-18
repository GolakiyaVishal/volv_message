import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:volv_message/common/app_route.dart';
import 'package:volv_message/data/data_cources/local_data_source.dart';

class HomeNotifier extends ChangeNotifier {
  final LocalDataSource localDataSource;
  String username = '';

  HomeNotifier(this.localDataSource);

  void getUsername() {
    localDataSource.getUserData().then((value){
      if(value != null) {
        username = value.username;
        notifyListeners();
      }
    });
  }

  void logoutTap(BuildContext context) {
    LocalDataSource localData = LocalDataSourceImpl();
    localData.clearData().then((value) {
      if(Navigator.canPop(context)){
        Navigator.pop(context);
      } else {
        Navigator.of(context).popAndPushNamed(AppRoute.login);
      }

    });
  }
}
