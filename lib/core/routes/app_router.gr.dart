// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:booking_demo_app/domain/entities/booking_entity.dart' as _i7;
import 'package:booking_demo_app/presentation/pages/booking_qr_page.dart'
    as _i1;
import 'package:booking_demo_app/presentation/pages/create_booking_page.dart'
    as _i2;
import 'package:booking_demo_app/presentation/pages/landing_page.dart' as _i3;
import 'package:booking_demo_app/presentation/pages/my_bookings_page.dart'
    as _i4;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.BookingQRPage]
class BookingQRRoute extends _i5.PageRouteInfo<BookingQRRouteArgs> {
  BookingQRRoute({
    _i6.Key? key,
    required _i7.BookingEntity booking,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         BookingQRRoute.name,
         args: BookingQRRouteArgs(key: key, booking: booking),
         initialChildren: children,
       );

  static const String name = 'BookingQRRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingQRRouteArgs>();
      return _i1.BookingQRPage(key: args.key, booking: args.booking);
    },
  );
}

class BookingQRRouteArgs {
  const BookingQRRouteArgs({this.key, required this.booking});

  final _i6.Key? key;

  final _i7.BookingEntity booking;

  @override
  String toString() {
    return 'BookingQRRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i2.CreateBookingPage]
class CreateBookingRoute extends _i5.PageRouteInfo<CreateBookingRouteArgs> {
  CreateBookingRoute({
    _i6.Key? key,
    _i7.BookingEntity? existingBooking,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         CreateBookingRoute.name,
         args: CreateBookingRouteArgs(
           key: key,
           existingBooking: existingBooking,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateBookingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateBookingRouteArgs>(
        orElse: () => const CreateBookingRouteArgs(),
      );
      return _i2.CreateBookingPage(
        key: args.key,
        existingBooking: args.existingBooking,
      );
    },
  );
}

class CreateBookingRouteArgs {
  const CreateBookingRouteArgs({this.key, this.existingBooking});

  final _i6.Key? key;

  final _i7.BookingEntity? existingBooking;

  @override
  String toString() {
    return 'CreateBookingRouteArgs{key: $key, existingBooking: $existingBooking}';
  }
}

/// generated route for
/// [_i3.LandingPage]
class LandingRoute extends _i5.PageRouteInfo<void> {
  const LandingRoute({List<_i5.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LandingPage();
    },
  );
}

/// generated route for
/// [_i4.MyBookingsPage]
class MyBookingsRoute extends _i5.PageRouteInfo<void> {
  const MyBookingsRoute({List<_i5.PageRouteInfo>? children})
    : super(MyBookingsRoute.name, initialChildren: children);

  static const String name = 'MyBookingsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.MyBookingsPage();
    },
  );
}
