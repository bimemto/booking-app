import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../molecules/pricing_card.dart';

/// Landing Second Page Content Organism
/// The second page of the landing screen with pricing and booking CTA
class LandingSecondPageContent extends StatelessWidget {
  final VoidCallback onBookPickup;

  const LandingSecondPageContent({
    super.key,
    required this.onBookPickup,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            // Title
            const Text(
              'Book\na Pickup',
              textAlign: TextAlign.center,
              style: AppTextStyles.heroMedium,
            ),

            const SizedBox(height: 24),

            // Pricing Card
            const PricingCard(),

            const Spacer(),

            // Book a Pickup Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onBookPickup,
                style: AppButtonStyles.primaryOutlined,
                child: const Text(
                  'Book a Pickup',
                  style: AppTextStyles.buttonPrimary,
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
