import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_booking/application/favourite/favourite_cubit.dart';
import 'package:hotels_booking/presentation/app_theme.dart';
import 'package:hotels_booking/presentation/router/app_router.dart';

import 'application/hotel/hotel_cubit.dart';
import 'setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HotelCubit>()..fetchHotels(),
        ),
        BlocProvider(
          create: (_) => getIt<FavouriteCubit>()..loadFavourites(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Hotels booking',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        routerDelegate: getIt<HotelAppRouter>().delegate(),
        routeInformationParser: getIt<HotelAppRouter>().defaultRouteParser(),
      ),
    );
  }
}
