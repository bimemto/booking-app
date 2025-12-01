import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../molecules/hero_section.dart';

/// Landing First Page Content Organism
/// The first page of the landing screen with hero text and CTA
class LandingFirstPageContent extends StatelessWidget {
  final VoidCallback onNext;

  const LandingFirstPageContent({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),

            // Hero Text
            const HeroSection(
              heroText: 'Luggage.\nDelivered.',
              tagline: 'From airport to hotel –\nsecurely, reliably, effortlessly.',
            ),

            const Spacer(flex: 1),

            // Next Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: AppButtonStyles.primaryOutlined,
                  child: const Text(
                    'Next',
                    style: AppTextStyles.buttonPrimary,
                  ),
                ),
              ),
            ),

            const Spacer(flex: 2),

            // Luggage Icon at Bottom
            Center(
              child: Icon(
                Icons.luggage_outlined,
                size: 120,
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
