import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

/// Zone Card Atom
/// Displays pricing information for a specific zone
class ZoneCard extends StatelessWidget {
  final String zone;
  final String district;
  final String price;

  const ZoneCard({
    super.key,
    required this.zone,
    required this.district,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              zone,
              style: AppTextStyles.bodySmall,
            ),
            if (district.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                district,
                style: AppTextStyles.captionSmall,
              ),
            ],
            const SizedBox(height: 8),
            Text(
              price,
              style: AppTextStyles.priceLarge,
            ),
            Text(
              'VND',
              style: AppTextStyles.priceSmall,
            ),
          ],
        ),
      ),
    );
  }
}
