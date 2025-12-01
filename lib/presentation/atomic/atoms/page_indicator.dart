import 'package:flutter/material.dart';

/// Page Indicator Atom
/// A simple dot indicator for page views
class PageIndicator extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicator({
    super.key,
    required this.isActive,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white38,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
