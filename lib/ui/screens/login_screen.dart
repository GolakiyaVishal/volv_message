import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volv_message/notifiers/login_notifier.dart';
import 'package:volv_message/ui/widget/custom_text_input.dart';
import 'package:volv_message/utils/validator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volv MVVM'),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: context.watch<LoginNotifier>().loginKey,
        autovalidateMode: context.watch<LoginNotifier>().autoValidate,
        child: Column(
          children: [
            CustomTextInput(
              controller: context.watch<LoginNotifier>().usernameController,
              label: 'Username',
              textInputAction: TextInputAction.next,
              validator: (username) {
                if (!Validator.isUsername(username)) {
                  return 'Enter a valid username between 4 to 20 character';
                }
                return null;
              },
            ),
            CustomTextInput(
              controller: context.watch<LoginNotifier>().phoneNumberController,
              label: 'Phone Number with country code',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              validator: (number) {
                if (!Validator.isPhoneNumber(number)) {
                  return 'Enter a valid phone number with country code';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () => context.read<LoginNotifier>().getCurrentNumber(),
              child: const Text('Get current number'),
            ),
            const SizedBox(height: 42),
            if (context.watch<LoginNotifier>().isLoader)
              const SizedBox(
                height: 10,
                width: 80,
                child: LinearProgressIndicator(),
              ),
            if (!context.watch<LoginNotifier>().isLoader)
              TextButton(
                onPressed: () =>
                    context.read<LoginNotifier>().loginTap(context),
                child: const Text('Login'),
              )
          ],
        ),
      ),
    );
  }
}
