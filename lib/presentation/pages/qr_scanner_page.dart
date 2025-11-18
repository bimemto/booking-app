import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../domain/entities/booking_entity.dart';
import '../../core/routes/app_router.gr.dart';

/// QR Scanner Page
/// Scans QR code containing booking data
@RoutePage()
class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleQRCode(String? qrCode) async {
    if (qrCode == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Parse QR code JSON
      final data = jsonDecode(qrCode) as Map<String, dynamic>;

      // Create booking entity from scanned data
      final booking = BookingEntity(
        id: data['id'] as String?,
        fullName: data['name'] as String? ?? data['fullName'] as String? ?? '',
        phoneNumber: data['phone'] as String? ?? data['phoneNumber'] as String? ?? '',
        pickupLocation: data['pickupLocation'] as String? ?? '',
        dropoffLocation: data['dropoffLocation'] as String? ?? '',
        numberOfBags: (data['bags'] as num?)?.toInt() ??
                      (data['numberOfBags'] as num?)?.toInt() ?? 1,
        isPickedUp: (data['isPickedUp'] as bool?) ?? false,
        createdAt: data['createdAt'] != null
            ? DateTime.parse(data['createdAt'] as String)
            : null,
      );

      if (!mounted) return;

      // Navigate to booking detail page with the scanned data
      await _controller.stop();
      context.router.push(BookingDetailRoute(booking: booking));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid QR code: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Scan QR Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                _handleQRCode(barcode.rawValue);
                break; // Process only the first valid QR code
              }
            },
          ),

          // Overlay with scanning area
          CustomPaint(
            painter: _ScannerOverlayPainter(),
            child: Container(),
          ),

          // Instructions
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Position the QR code within the frame',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Flash toggle button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                icon: ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, state, child) {
                    return Icon(
                      state.torchState == TorchState.on
                          ? Icons.flash_on
                          : Icons.flash_off,
                      color: Colors.white,
                      size: 32,
                    );
                  },
                ),
                onPressed: () => _controller.toggleTorch(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for scanner overlay
class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double scanAreaSize = size.width * 0.7;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;

    // Draw dark overlay
    final Paint overlayPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5);

    canvas.drawPath(
      Path()
        ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
        ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize),
          const Radius.circular(12),
        ))
        ..fillType = PathFillType.evenOdd,
      overlayPaint,
    );

    // Draw border
    final Paint borderPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize),
        const Radius.circular(12),
      ),
      borderPaint,
    );

    // Draw corner indicators
    final double cornerLength = 30;
    final Paint cornerPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Top-left corner
    canvas.drawLine(
      Offset(left, top + cornerLength),
      Offset(left, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left + cornerLength, top),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(left + scanAreaSize - cornerLength, top),
      Offset(left + scanAreaSize, top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + scanAreaSize, top),
      Offset(left + scanAreaSize, top + cornerLength),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(left, top + scanAreaSize - cornerLength),
      Offset(left, top + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left, top + scanAreaSize),
      Offset(left + cornerLength, top + scanAreaSize),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(left + scanAreaSize - cornerLength, top + scanAreaSize),
      Offset(left + scanAreaSize, top + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(left + scanAreaSize, top + scanAreaSize - cornerLength),
      Offset(left + scanAreaSize, top + scanAreaSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
