// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/http_api_datasource.dart' as _i680;
import '../../data/repositories/http_booking_repository_impl.dart' as _i766;
import '../../domain/repositories/booking_repository.dart' as _i377;
import '../../domain/usecases/cancel_booking_usecase.dart' as _i951;
import '../../domain/usecases/create_booking_usecase.dart' as _i832;
import '../../domain/usecases/edit_booking_usecase.dart' as _i856;
import '../../domain/usecases/get_booking_by_id_usecase.dart' as _i689;
import '../../domain/usecases/get_bookings_usecase.dart' as _i405;
import '../../domain/usecases/get_my_bookings_usecase.dart' as _i239;
import '../../domain/usecases/update_booking_status_usecase.dart' as _i327;
import '../../presentation/providers/booking_provider.dart' as _i965;
import '../networking/dio_client.dart' as _i201;
import '../services/device_id_service.dart' as _i148;
import 'shared_preferences_module.dart' as _i110;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i201.DioClient>(() => _i201.DioClient());
    gh.lazySingleton<_i680.HttpApiDatasource>(() => _i680.HttpApiDatasource());
    gh.lazySingleton<_i148.DeviceIdService>(
        () => _i148.DeviceIdService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i377.BookingRepository>(
        () => _i766.HttpBookingRepositoryImpl(gh<_i680.HttpApiDatasource>()));
    gh.factory<_i327.UpdateBookingStatusUseCase>(
        () => _i327.UpdateBookingStatusUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i689.GetBookingByIdUseCase>(
        () => _i689.GetBookingByIdUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i856.EditBookingUseCase>(
        () => _i856.EditBookingUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i832.CreateBookingUseCase>(
        () => _i832.CreateBookingUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i951.CancelBookingUseCase>(
        () => _i951.CancelBookingUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i405.GetBookingsUseCase>(
        () => _i405.GetBookingsUseCase(gh<_i377.BookingRepository>()));
    gh.lazySingleton<_i239.GetMyBookingsUseCase>(
        () => _i239.GetMyBookingsUseCase(gh<_i377.BookingRepository>()));
    gh.factory<_i965.BookingProvider>(() => _i965.BookingProvider(
          gh<_i832.CreateBookingUseCase>(),
          gh<_i405.GetBookingsUseCase>(),
          gh<_i689.GetBookingByIdUseCase>(),
          gh<_i327.UpdateBookingStatusUseCase>(),
          gh<_i951.CancelBookingUseCase>(),
          gh<_i856.EditBookingUseCase>(),
        ));
    return this;
  }
}

class _$SharedPreferencesModule extends _i110.SharedPreferencesModule {}
