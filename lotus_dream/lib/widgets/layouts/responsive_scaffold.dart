import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../platform/platform_utils.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool showAppBar;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.title = '',
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: showAppBar
            ? CupertinoNavigationBar(
                middle: Text(title),
              )
            : null,
        child: SafeArea(child: body),
      );
    } else {
      return Scaffold(
        appBar: showAppBar ? AppBar(title: Text(title)) : null,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                // Web/Desktop layout
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: body,
                  ),
                );
              }
              return body; // Mobile layout
            },
          ),
        ),
      );
    }
  }
}
