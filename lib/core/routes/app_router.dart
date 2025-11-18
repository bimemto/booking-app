import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: CreateBookingRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: BookingQRRoute.page,
        ),
        AutoRoute(
          page: DriverRoute.page,
        ),
        AutoRoute(
          page: QRScannerRoute.page,
        ),
        AutoRoute(
          page: BookingDetailRoute.page,
        ),
      ];
}
