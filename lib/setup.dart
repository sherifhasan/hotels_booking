import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotels_booking/application/favourite/favourite_cubit.dart';
import 'package:hotels_booking/domain/usecases/favourite/favourite_usecases.dart';
import 'package:hotels_booking/infrastructure/datasources/favourite_local_data_source.dart';
import 'package:hotels_booking/infrastructure/datasources/hotels_remote_data_source.dart';
import 'package:hotels_booking/presentation/router/app_router.dart';
import 'application/hotel/hotel_cubit.dart';
import 'domain/app_repository.dart';
import 'domain/usecases/hotel/fetch_hotels_use_case.dart';
import 'infrastructure/app_repository_imp.dart';
import 'infrastructure/storage/hotel_database_model.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await _setupDatabase();
  _setupInjection();
}

void _setupInjection() {
  // register Dio
  getIt.registerSingleton<Dio>(Dio());

  //register FavouriteLocalDataSource
  getIt.registerSingleton<FavouriteLocalDataSource>(
      FavouriteLocalDataSource(getIt()));

  //register HotelRemoteDataSource
  getIt
      .registerSingleton<HotelRemoteDataSource>(HotelRemoteDataSource(getIt()));

  // Repositories
  getIt.registerLazySingleton<AppRepository>(
      () => AppRepositoryImp(getIt(), getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => FetchHotelsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetFavouritesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToFavouritesUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFromFavouritesUseCase(getIt()));

  // HotelCubit
  getIt.registerFactory(() => HotelCubit(
        getIt<FetchHotelsUseCase>(),
      ));
  // HotelCubit
  getIt.registerFactory(
    () => FavouriteCubit(getIt<GetFavouritesUseCase>(),
        getIt<AddToFavouritesUseCase>(), getIt<RemoveFromFavouritesUseCase>()),
  );
  // Register app_router
  getIt.registerLazySingleton(() => HotelAppRouter());
}

Future<void> _setupDatabase() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter for HotelHiveModel
  Hive.registerAdapter(HotelHiveModelAdapter());

  // Open the favourites box to store the HotelHiveModel
  await Hive.openBox<HotelHiveModel>(FavouriteLocalDataSource.favouritesBox);

  // Register HiveBox
  getIt.registerLazySingleton<Box<HotelHiveModel>>(
      () => Hive.box<HotelHiveModel>(FavouriteLocalDataSource.favouritesBox));
}
