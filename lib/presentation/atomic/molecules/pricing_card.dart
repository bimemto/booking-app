import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import 'zone_pricing_row.dart';

/// Pricing Card Molecule
/// Displays pricing information with zones and additional options
class PricingCard extends StatelessWidget {
  const PricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pricing',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 24),

          // Zone Pricing
          const ZonePricingRow(),

          const SizedBox(height: 16),

          // Up to 2 bags text
          Center(
            child: Text(
              'up to 2 bags',
              style: AppTextStyles.captionMedium,
            ),
          ),

          const SizedBox(height: 32),

          // Additional Options
          const Text(
            'Additional options',
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 16),

          // Extra bag option
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Extra bag',
                  style: AppTextStyles.bodyMedium,
                ),
                Text(
                  '+70,000 VND',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
