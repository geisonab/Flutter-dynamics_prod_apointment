import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({
    super.key,
    required this.label,
    required this.onPressedLocal,
  });

  final String label;
  final Function() onPressedLocal;

  @override
  Widget build(BuildContext context) {
    try {
      if (kIsWeb) {
        return ElevatedButton(
          onPressed: onPressedLocal,
          child: Text(label),
        );
      } else {
        return Platform.isIOS
            ? CupertinoButton(
                onPressed: onPressedLocal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(label),
              )
            : ElevatedButton(
                onPressed: onPressedLocal,
                child: Text(label),
              );
      }
    } catch (e) {
      return ElevatedButton(
        onPressed: onPressedLocal,
        child: Text(label),
      );
    }
  }
}
