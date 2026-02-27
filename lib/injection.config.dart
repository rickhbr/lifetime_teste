// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ptax_app/core/network/dio_client.dart' as _i443;
import 'package:ptax_app/core/network/firebase_module.dart' as _i885;
import 'package:ptax_app/core/network/logging_interceptor.dart' as _i320;
import 'package:ptax_app/core/routes/app_router.dart' as _i623;
import 'package:ptax_app/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i947;
import 'package:ptax_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i820;
import 'package:ptax_app/features/auth/domain/repositories/auth_repository.dart'
    as _i354;
import 'package:ptax_app/features/auth/domain/usecases/get_auth_state.dart'
    as _i314;
import 'package:ptax_app/features/auth/domain/usecases/sign_in.dart' as _i624;
import 'package:ptax_app/features/auth/domain/usecases/sign_out.dart' as _i749;
import 'package:ptax_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i1032;
import 'package:ptax_app/features/currencies/data/datasources/currency_remote_datasource.dart'
    as _i678;
import 'package:ptax_app/features/currencies/data/repositories/currency_repository_impl.dart'
    as _i831;
import 'package:ptax_app/features/currencies/domain/repositories/currency_repository.dart'
    as _i957;
import 'package:ptax_app/features/currencies/domain/usecases/get_currencies.dart'
    as _i247;
import 'package:ptax_app/features/currencies/presentation/cubit/currencies_cubit.dart'
    as _i988;
import 'package:ptax_app/features/currency_detail/data/datasources/currency_detail_remote_datasource.dart'
    as _i259;
import 'package:ptax_app/features/currency_detail/data/repositories/currency_detail_repository_impl.dart'
    as _i802;
import 'package:ptax_app/features/currency_detail/domain/repositories/currency_detail_repository.dart'
    as _i1034;
import 'package:ptax_app/features/currency_detail/domain/usecases/get_latest_quote.dart'
    as _i329;
import 'package:ptax_app/features/currency_detail/presentation/cubit/currency_detail_cubit.dart'
    as _i510;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i320.LoggingInterceptor>(
      () => _i320.LoggingInterceptor(),
    );
    gh.lazySingleton<_i947.AuthRemoteDatasource>(
      () => _i947.AuthRemoteDatasourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i320.LoggingInterceptor>()),
    );
    gh.lazySingleton<_i259.CurrencyDetailRemoteDatasource>(
      () => _i259.CurrencyDetailRemoteDatasourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i678.CurrencyRemoteDatasource>(
      () => _i678.CurrencyRemoteDatasourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i354.AuthRepository>(
      () => _i820.AuthRepositoryImpl(gh<_i947.AuthRemoteDatasource>()),
    );
    gh.lazySingleton<_i1034.CurrencyDetailRepository>(
      () => _i802.CurrencyDetailRepositoryImpl(
        gh<_i259.CurrencyDetailRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i957.CurrencyRepository>(
      () => _i831.CurrencyRepositoryImpl(gh<_i678.CurrencyRemoteDatasource>()),
    );
    gh.lazySingleton<_i314.GetAuthStateUseCase>(
      () => _i314.GetAuthStateUseCase(gh<_i354.AuthRepository>()),
    );
    gh.lazySingleton<_i624.SignInUseCase>(
      () => _i624.SignInUseCase(gh<_i354.AuthRepository>()),
    );
    gh.lazySingleton<_i749.SignOutUseCase>(
      () => _i749.SignOutUseCase(gh<_i354.AuthRepository>()),
    );
    gh.lazySingleton<_i329.GetLatestQuoteUseCase>(
      () => _i329.GetLatestQuoteUseCase(gh<_i1034.CurrencyDetailRepository>()),
    );
    gh.factory<_i510.CurrencyDetailCubit>(
      () => _i510.CurrencyDetailCubit(gh<_i329.GetLatestQuoteUseCase>()),
    );
    gh.lazySingleton<_i247.GetCurrenciesUseCase>(
      () => _i247.GetCurrenciesUseCase(gh<_i957.CurrencyRepository>()),
    );
    gh.lazySingleton<_i1032.AuthCubit>(
      () => _i1032.AuthCubit(
        gh<_i624.SignInUseCase>(),
        gh<_i749.SignOutUseCase>(),
        gh<_i314.GetAuthStateUseCase>(),
      ),
    );
    gh.lazySingleton<_i623.AppRouter>(
      () => _i623.AppRouter(gh<_i1032.AuthCubit>()),
    );
    gh.factory<_i988.CurrenciesCubit>(
      () => _i988.CurrenciesCubit(gh<_i247.GetCurrenciesUseCase>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i885.FirebaseModule {}

class _$DioModule extends _i443.DioModule {}
