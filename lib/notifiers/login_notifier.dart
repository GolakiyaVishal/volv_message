import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:volv_message/common/app_route.dart';
import 'package:volv_message/data/data_cources/local_data_source.dart';
import 'package:volv_message/data/tables/tables.dart';
import 'package:volv_message/ui/widget/verification_dialog.dart';
import 'package:volv_message/utils/internet_connection.dart';
import 'package:volv_message/utils/snack_bar_view.dart';

class LoginNotifier extends ChangeNotifier {
  final LocalDataSource localDataSource;

  GlobalKey<FormState> loginKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  bool isLoader = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController smsController = TextEditingController();
  String? _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();

  LoginNotifier(this.localDataSource);

  /// handle login tap
  Future<void> loginTap(BuildContext context) async {
    if (loginKey.currentState!.validate() &&
        await InternetConnection.check(context)) {
      showLoader();
      try {
        await _auth.verifyPhoneNumber(
            phoneNumber: phoneNumberController.text,
            timeout: const Duration(seconds: 60),
            verificationCompleted: (value) {
              hideLoader();
              verificationCompleted(value, context);
            },
            verificationFailed: (authException) {
              hideLoader();
              verificationFailed(context, authException);
            },
            codeSent: (verificationId, forceResendingToken) {
              hideLoader();
              codeSent(context, verificationId, forceResendingToken);
            },
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      } catch (e) {
        hideLoader();
        showSnackBar('Failed to Verify Phone Number: $e');
      }
    } else {
      autoValidate = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

  /// get current device mobile number
  Future<void> getCurrentNumber() async {
    phoneNumberController.text = (await _autoFill.hint) ?? '';
    debugPrint('phoneNumberController:: ${phoneNumberController.text}');
    // notifyListeners();
  }

  /// handle on verification complete
  verificationCompleted(
      PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
    await _auth.signInWithCredential(phoneAuthCredential);

    showSnackBar(
        'Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}');
    saveAndNext(context);
  }

  /// handle verification failed
  verificationFailed(
      BuildContext context, FirebaseAuthException authException) {
    showSnackBar(
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');

    debugPrint(
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  }

  /// show dialog after code sent
  codeSent(BuildContext context, String verificationId,
      [int? forceResendingToken]) async {
    _verificationId = verificationId;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => VerificationDialog(
              verificationId: verificationId,
              verifyTap: verifyTap,
            ));
  }

  codeAutoRetrievalTimeout(String verificationId) {
    _verificationId = verificationId;
    hideLoader();
    debugPrint('verification code:: $verificationId');
  }

  /// verify SMS code
  void verifyTap(BuildContext context, String smsCode) {
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader();
    var _credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: smsCode);

    _auth.signInWithCredential(_credential).then((result) {
      saveAndNext(context);
    }).catchError((e) {
      debugPrint('catchError:: $e');
      showSnackBar(e.toString());
    });
  }

  /// save data and open home screen
  void saveAndNext(BuildContext context) {
    hideLoader();
    localDataSource.saveUserData(
        UserData(isLogin: true, username: usernameController.text.toString()));

    usernameController.clear();
    phoneNumberController.clear();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(AppRoute.home);
  }

  showLoader() {
    if (!isLoader) {
      isLoader = true;
      notifyListeners();
    }
  }

  hideLoader() {
    if (isLoader) {
      isLoader = false;
      notifyListeners();
    }
  }
}
