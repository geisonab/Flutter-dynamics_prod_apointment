import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final String labelText;
  final TextInputType inputType;

  const AdaptativeTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.labelText,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return Platform.isIOS
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: CupertinoTextField(
                keyboardType: inputType,
                onSubmitted: onSubmitted,
                placeholder: labelText,
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 6,
                ),
              ),
            )
          : TextField(
              keyboardType: inputType,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                labelText: labelText,
              ),
              controller: controller,
            );
    } catch (e) {
      return TextField(
        keyboardType: inputType,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        controller: controller,
      );
    }
  }
}
