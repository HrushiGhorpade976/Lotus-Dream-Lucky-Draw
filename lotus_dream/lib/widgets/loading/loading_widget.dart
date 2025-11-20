import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../platform/platform_utils.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isIOS) {
      return const Center(child: CupertinoActivityIndicator(radius: 15));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
