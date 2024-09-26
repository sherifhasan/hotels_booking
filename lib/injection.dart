import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hotels_booking/infrastructure/datasources/hotels_remote_data_source.dart';
import 'package:hotels_booking/presentation/router/app_router.dart';
import 'application/hotel_cubit.dart';
import 'domain/app_repository.dart';
import 'domain/usecases/fetch_hotels_use_case.dart';
import 'infrastructure/app_repository_imp.dart';

final getIt = GetIt.instance;

void setupInjection() {
  // register Dio
  getIt.registerSingleton<Dio>(Dio());

  //register HotelRemoteDataSource
  getIt
      .registerSingleton<HotelRemoteDataSource>(HotelRemoteDataSource(getIt()));

  // Repositories
  getIt.registerLazySingleton<AppRepository>(() => AppRepositoryImp(getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => FetchHotelsUseCase(getIt()));

  // Cubit
  getIt.registerFactory(() => HotelCubit(
        getIt<FetchHotelsUseCase>(),
      ));

  // Register app_router
  getIt.registerLazySingleton(() => HotelAppRouter());
}
