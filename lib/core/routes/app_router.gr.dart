// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:booking_demo_app/domain/entities/booking_entity.dart' as _i8;
import 'package:booking_demo_app/presentation/pages/booking_detail_page.dart'
    as _i1;
import 'package:booking_demo_app/presentation/pages/booking_qr_page.dart'
    as _i2;
import 'package:booking_demo_app/presentation/pages/create_booking_page.dart'
    as _i3;
import 'package:booking_demo_app/presentation/pages/driver_page.dart' as _i4;
import 'package:booking_demo_app/presentation/pages/qr_scanner_page.dart'
    as _i5;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.BookingDetailPage]
class BookingDetailRoute extends _i6.PageRouteInfo<BookingDetailRouteArgs> {
  BookingDetailRoute({
    _i7.Key? key,
    required _i8.BookingEntity booking,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         BookingDetailRoute.name,
         args: BookingDetailRouteArgs(key: key, booking: booking),
         initialChildren: children,
       );

  static const String name = 'BookingDetailRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingDetailRouteArgs>();
      return _i1.BookingDetailPage(key: args.key, booking: args.booking);
    },
  );
}

class BookingDetailRouteArgs {
  const BookingDetailRouteArgs({this.key, required this.booking});

  final _i7.Key? key;

  final _i8.BookingEntity booking;

  @override
  String toString() {
    return 'BookingDetailRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i2.BookingQRPage]
class BookingQRRoute extends _i6.PageRouteInfo<BookingQRRouteArgs> {
  BookingQRRoute({
    _i7.Key? key,
    required _i8.BookingEntity booking,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         BookingQRRoute.name,
         args: BookingQRRouteArgs(key: key, booking: booking),
         initialChildren: children,
       );

  static const String name = 'BookingQRRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingQRRouteArgs>();
      return _i2.BookingQRPage(key: args.key, booking: args.booking);
    },
  );
}

class BookingQRRouteArgs {
  const BookingQRRouteArgs({this.key, required this.booking});

  final _i7.Key? key;

  final _i8.BookingEntity booking;

  @override
  String toString() {
    return 'BookingQRRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i3.CreateBookingPage]
class CreateBookingRoute extends _i6.PageRouteInfo<void> {
  const CreateBookingRoute({List<_i6.PageRouteInfo>? children})
    : super(CreateBookingRoute.name, initialChildren: children);

  static const String name = 'CreateBookingRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.CreateBookingPage();
    },
  );
}

/// generated route for
/// [_i4.DriverPage]
class DriverRoute extends _i6.PageRouteInfo<void> {
  const DriverRoute({List<_i6.PageRouteInfo>? children})
    : super(DriverRoute.name, initialChildren: children);

  static const String name = 'DriverRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.DriverPage();
    },
  );
}

/// generated route for
/// [_i5.QRScannerPage]
class QRScannerRoute extends _i6.PageRouteInfo<void> {
  const QRScannerRoute({List<_i6.PageRouteInfo>? children})
    : super(QRScannerRoute.name, initialChildren: children);

  static const String name = 'QRScannerRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.QRScannerPage();
    },
  );
}
