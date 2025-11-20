import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../platform/platform_utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isIOS) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
        ),
      );
    }
  }
}
