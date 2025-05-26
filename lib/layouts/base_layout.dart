import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

enum LayoutType {
  standard,
  fullScreen,
  minimal
}

class BaseLayout extends StatelessWidget {
  final Widget child;
  final LayoutType layoutType;

  const BaseLayout({
    super.key,
    required this.child,
    this.layoutType = LayoutType.standard,
  });

  @override
  Widget build(BuildContext context) {
    switch (layoutType) {
      case LayoutType.fullScreen:
        return child;
      case LayoutType.minimal:
        return Scaffold(
          body: child,
        );
      case LayoutType.standard:
      default:
        return HomeScreen(body: child);
    }
  }
} 