import 'package:flutter/material.dart';
import '../atoms/page_indicator.dart';

/// Page Indicator Row Molecule
/// A row of page indicators
class PageIndicatorRow extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicatorRow({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: PageIndicator(isActive: currentPage == index),
          ),
        ),
      ),
    );
  }
}
