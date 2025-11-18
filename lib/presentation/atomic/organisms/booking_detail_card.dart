import 'package:flutter/material.dart';
import '../../../domain/entities/booking_entity.dart';
import '../molecules/booking_info_card.dart';

/// Organism: Booking Detail Card
/// Complex component for displaying booking details
class BookingDetailCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingInfoCard(
          icon: Icons.person,
          label: 'Full Name',
          value: booking.fullName,
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 12),
        BookingInfoCard(
          icon: Icons.phone,
          label: 'Phone Number',
          value: booking.phoneNumber,
          iconColor: Colors.green,
        ),
        const SizedBox(height: 12),
        BookingInfoCard(
          icon: Icons.location_on_outlined,
          label: 'Pickup Location',
          value: booking.pickupLocation,
          iconColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        BookingInfoCard(
          icon: Icons.location_on,
          label: 'Dropoff Location',
          value: booking.dropoffLocation,
          iconColor: Colors.red,
        ),
        const SizedBox(height: 12),
        BookingInfoCard(
          icon: Icons.luggage,
          label: 'Number of Bags',
          value: '${booking.numberOfBags} ${booking.numberOfBags == 1 ? 'bag' : 'bags'}',
          iconColor: Colors.purple,
        ),
      ],
    );
  }
}
