import 'package:flutter/material.dart';

class VerificationDialog extends StatelessWidget {
  final String verificationId;
  final Function(BuildContext, String) verifyTap;

  VerificationDialog({Key? key,
    required this.verificationId,
    required this.verifyTap,
  })
      : super(key: key);

  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter SMS Code"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Verify"),
          onPressed: () => verifyTap(context, _codeController.text.trim()),
        )
      ],
    );
  }
}
