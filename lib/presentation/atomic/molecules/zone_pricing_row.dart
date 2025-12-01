import 'package:flutter/material.dart';
import '../atoms/zone_card.dart';

/// Zone Pricing Row Molecule
/// Displays a row of zone pricing cards
class ZonePricingRow extends StatelessWidget {
  const ZonePricingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZoneCard(zone: 'Zone 1', district: 'District 1', price: '180,000'),
        ZoneCard(zone: 'Zone 2', district: 'District 2', price: '220,000'),
        ZoneCard(zone: 'Zone 3', district: 'District 3', price: '250,000'),
      ],
    );
  }
}
