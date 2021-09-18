import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;

  CustomTextInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.validator,
    this.textInputAction,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text(label),
            ),
            const WidgetSpan(
              child: Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      )),
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}
