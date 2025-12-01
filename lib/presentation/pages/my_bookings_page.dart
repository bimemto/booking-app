import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/di/injection.dart';
import '../../core/routes/app_router.gr.dart';
import '../../core/services/device_id_service.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/get_my_bookings_usecase.dart';

/// My Bookings Page
/// Displays all bookings for the current device
@RoutePage()
class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  final _deviceIdService = getIt<DeviceIdService>();
  final _getMyBookingsUseCase = getIt<GetMyBookingsUseCase>();

  List<BookingEntity> _bookings = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Get device ID
      final deviceId = await _deviceIdService.getDeviceId();

      // Fetch bookings
      final result = await _getMyBookingsUseCase(deviceId);

      result.fold(
        (error) {
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
        },
        (bookings) {
          setState(() {
            _bookings = bookings;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load bookings: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white.withValues(alpha: 0.3),
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loadBookings,
                  style: AppButtonStyles.primaryOutlined,
                  child: const Text(
                    'Retry',
                    style: AppTextStyles.buttonPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.luggage_outlined,
                size: 100,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              const SizedBox(height: 24),
              const Text(
                'No bookings yet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your bookings will appear here',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.router.navigate(const CreateBookingRoute());
                  },
                  style: AppButtonStyles.primaryOutlined,
                  child: const Text(
                    'Create Booking',
                    style: AppTextStyles.buttonPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadBookings,
      color: Colors.white,
      backgroundColor: Colors.black,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: _bookings.length,
        itemBuilder: (context, index) {
          final booking = _bookings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _BookingCard(
              booking: booking,
              onTap: () {
                // Navigate to booking QR page
                context.router.push(BookingQRRoute(booking: booking));
              },
            ),
          );
        },
      ),
    );
  }
}

/// Widget for displaying a single booking in the list
class _BookingCard extends StatelessWidget {
  final BookingEntity booking;
  final VoidCallback? onTap;

  const _BookingCard({
    required this.booking,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    booking.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _getStatusColor(booking),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getStatusText(booking),
                    style: TextStyle(
                      color: _getStatusColor(booking),
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Divider
            Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.1),
            ),

            const SizedBox(height: 20),

            // Hotel info
            _buildInfoRow(
              Icons.hotel_outlined,
              booking.hotelDisplayName,
            ),
            const SizedBox(height: 16),

            // Arrival time
            _buildInfoRow(
              Icons.access_time_outlined,
              booking.arrivalTime,
            ),
            const SizedBox(height: 16),

            // Number of bags
            _buildInfoRow(
              Icons.luggage_outlined,
              '${booking.numberOfBags} bag${booking.numberOfBags > 1 ? 's' : ''}',
            ),
            const SizedBox(height: 16),

            // Phone
            _buildInfoRow(
              Icons.phone_outlined,
              booking.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white.withValues(alpha: 0.8),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  /// Get status text based on booking state
  String _getStatusText(BookingEntity booking) {
    if (booking.isPickedUp) {
      return 'Picked Up';
    }

    final status = booking.status?.toLowerCase();
    switch (status) {
      case 'confirmed':
        return 'Confirmed';
      case 'pending':
        return 'Pending';
      default:
        return 'Pending';
    }
  }

  /// Get status color based on booking state
  Color _getStatusColor(BookingEntity booking) {
    if (booking.isPickedUp) {
      return Colors.white.withValues(alpha: 0.9);
    }

    final status = booking.status?.toLowerCase();
    switch (status) {
      case 'confirmed':
        return Colors.green.withValues(alpha: 0.8);
      case 'pending':
        return Colors.orange.withValues(alpha: 0.7);
      default:
        return Colors.white.withValues(alpha: 0.6);
    }
  }
}
