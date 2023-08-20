import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webscreenLayout;
  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webscreenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return webscreenLayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}
