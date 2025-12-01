import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/routes/app_router.gr.dart';
import '../../core/theme/app_text_styles.dart';
import '../atomic/molecules/page_indicator_row.dart';
import '../atomic/organisms/landing_first_page_content.dart';
import '../atomic/organisms/landing_second_page_content.dart';

/// Landing Page
/// Hero screen with Lugger branding and call-to-action
@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToBooking() {
    context.router.replace(const CreateBookingRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Lugger',
          style: AppTextStyles.heading1,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt, color: Colors.white),
            tooltip: 'My Bookings',
            onPressed: () {
              context.router.push(const MyBookingsRoute());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                LandingFirstPageContent(onNext: _nextPage),
                LandingSecondPageContent(onBookPickup: _navigateToBooking),
              ],
            ),
          ),
          // Page Indicator
          PageIndicatorRow(
            currentPage: _currentPage,
            totalPages: 2,
          ),
        ],
      ),
    );
  }
}
