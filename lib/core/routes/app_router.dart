import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LandingRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: CreateBookingRoute.page,
        ),
        AutoRoute(
          page: BookingQRRoute.page,
        ),
        AutoRoute(
          page: MyBookingsRoute.page,
        ),
      ];
}
