// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/firebase_datasource.dart' as _i327;
import '../../data/datasources/http_api_datasource.dart' as _i680;
import '../../data/repositories/http_booking_repository_impl.dart' as _i766;
import '../../domain/repositories/booking_repository.dart' as _i377;
import '../../domain/usecases/create_booking_usecase.dart' as _i832;
import '../../domain/usecases/get_bookings_usecase.dart' as _i405;
import '../../domain/usecases/update_booking_status_usecase.dart' as _i327;
import '../../presentation/providers/booking_provider.dart' as _i965;
import '../networking/dio_client.dart' as _i201;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i201.DioClient>(() => _i201.DioClient());
    gh.lazySingleton<_i680.HttpApiDatasource>(() => _i680.HttpApiDatasource());
    gh.lazySingleton<_i377.BookingRepository>(
        () => _i766.HttpBookingRepositoryImpl(gh<_i680.HttpApiDatasource>()));
    gh.lazySingleton<_i327.FirebaseDatasource>(
        () => _i327.FirebaseDatasource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i327.UpdateBookingStatusUseCase>(
        () => _i327.UpdateBookingStatusUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i832.CreateBookingUseCase>(
        () => _i832.CreateBookingUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i405.GetBookingsUseCase>(
        () => _i405.GetBookingsUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i965.BookingProvider>(() => _i965.BookingProvider(
          gh<_i832.CreateBookingUseCase>(),
          gh<_i405.GetBookingsUseCase>(),
          gh<_i327.UpdateBookingStatusUseCase>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i616.FirebaseModule {}
