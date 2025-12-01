import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

/// Hero Section Molecule
/// Displays hero text and tagline
class HeroSection extends StatelessWidget {
  final String heroText;
  final String tagline;

  const HeroSection({
    super.key,
    required this.heroText,
    required this.tagline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heroText,
          style: AppTextStyles.heroLarge,
        ),
        const SizedBox(height: 24),
        Text(
          tagline,
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}
